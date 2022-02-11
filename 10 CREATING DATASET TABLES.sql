-- CREATING DATASET TABLES


Drop table IF EXISTS  DRUGS_STANDARDIZED;
SELECT  primaryid
	  ,[DRUG_ID]
      ,[DRUG_SEQ]
      ,[ROLE_COD]
      ,PERIOD
	  , FINAL_RXAUI as RXAUI
	  , REMAPPING_STR as DRUG 
INTO DRUGS_STANDARDIZED    
FROM [FAERS_B].[dbo].[DRUG_MAPPER_3]
WHERE FINAL_RXAUI IS NOT NULL 
and FINAL_RXAUI <> 9267486  -- REMOVE DRUGS MAPPED TO UNKNOWN STR 
and primaryid in (select primaryid from [FAERS_A].[dbo].[ALIGNED_DEMO_DRUG_REAC_INDI_THER]) 

------------------------------------------------------
DROP TABLE IF EXISTS ADVERSE_REACTIONS;
with CTE as (
SELECT  MedDRA_CODE  , [primaryid]  ,[PERIOD]
   
FROM  REAC_Combined  WHERE primaryid IN  (SELECT PRIMARYID FROM ALIGNED_DEMO_DRUG_REAC_INDI_THER)), 

CTE_2 as (select pt_code AS CODE, pt_name  AS ADVERSE_EVENT from pref_term
		union 
		select llt_code, llt_name from low_level_term)

SELECT  CTE.primaryid, CTE.PERIOD, CTE_2.ADVERSE_EVENT
INTO ADVERSE_REACTIONS
FROM CTE INNER JOIN CTE_2 ON MedDRA_CODE = CODE
----------------------------------------------------------

DROP table if exists DRUG_ADVERSE_REACTIONS_Pairs; 
SELECT distinct a.PRIMARYID , RXAUI , DRUG, Adverse_Event  
INTO DRUG_ADVERSE_REACTIONS_Pairs  
FROM [FAERS_A].[dbo].[DRUGS_STANDARDIZED] A INNER JOIN ADVERSE_REACTIONS B ON
A.PRIMARYID = B.PRIMARYID

----------------------------------
DROP table if exists DRUG_ADVERSE_REACTIONS_COUNT;

SELECT RXAUI ,  DRUG,  Adverse_Event , COUNT(Adverse_Event) AS count_of_reaction
INTO DRUG_ADVERSE_REACTIONS_COUNT
FROM DRUG_ADVERSE_REACTIONS_Pairs 
group by RXAUI,Adverse_Event,DRUG
---------------------------------
 
DROP TABLE IF EXISTS DRUG_INDICATIONS;
with CTE as (
SELECT  MedDRA_CODE  , [primaryid], indi_drug_seq
      
      ,[PERIOD]   
FROM  INDI_Combined WHERE primaryid IN  (SELECT  PRIMARYID FROM ALIGNED_DEMO_DRUG_REAC_INDI_THER) 
AND MEDDRA_CODE NOT IN (10070592,10057097)),

CTE_2 as (select pt_code AS CODE, pt_name  AS DRUG_INDICATION from pref_term
		union
		select llt_code, llt_name from low_level_term)

SELECT  CTE.primaryid, CTE.indi_drug_seq, CTE.PERIOD, CTE_2.DRUG_INDICATION
INTO DRUG_INDICATIONS
FROM CTE INNER JOIN CTE_2 ON MedDRA_CODE = CODE

--------------------------

SELECT
  caseid,
  primaryid,
  caseversion,
  fda_dt,
  I_F_COD,
  event_dt,
  AGE_Years_fixed AS AGE,
  Gender,
  COUNTRY_CODE,
  Period INTO DEMOGRAPHICS
FROM Aligned_DEMO_DRUG_REAC_INDI_THER

-------------------------

DROP TABLE IF EXISTS CASE_OUTCOMES;
SELECT DISTINCT 
     A. [primaryid]
      ,[OUTC_COD]
      ,A.[PERIOD]
INTO CASE_OUTCOMES
  FROM [OUTC_Combined] A
  INNER JOIN Aligned_DEMO_DRUG_REAC_INDI_THER C
  ON A.primaryid = C.primaryid 
 
---------------------
DROP table IF EXISTS THERAPY_DATES;
SELECT  
      [Primaryid]
      ,[dsg_drug_seq]
      ,[START_DT]
      ,[END_DT]
      ,[DUR]
      ,case when len([DUR_COD])=0 then null else [DUR_COD] end as DUR_COD
      ,[PERIOD]

INTO THERAPY_DATES
  FROM [THER_Combined] 
  WHERE primaryid IN  (SELECT PRIMARYID FROM ALIGNED_DEMO_DRUG_REAC_INDI_THER)
 --------------------------------


DROP TABLE IF EXISTS REPORT_SOURCES
SELECT  
      [Primaryid]
      ,[RPSR_COD]
      ,[PERIOD]

INTO REPORT_SOURCES
  FROM RPSR_Combined 
   WHERE primaryid IN  (SELECT PRIMARYID FROM ALIGNED_DEMO_DRUG_REAC_INDI_THER)
 -----------------------------
DROP TABLE IF EXISTS DRUG_MARGIN ;
SELECT RXAUI, SUM(count_of_reaction) as Margin 
into DRUG_MARGIN
from DRUG_ADVERSE_REACTIONS_COUNT
GROUP BY RXAUI;
---------------------

DROP TABLE IF EXISTS EVENT_MARGIN ;
SELECT Adverse_Event, SUM(count_of_reaction) as Margin 
into EVENT_MARGIN
from DRUG_ADVERSE_REACTIONS_COUNT
GROUP BY Adverse_Event;
-------------------

DROP TABLE IF EXISTS TOTAL_COUNT ;
SELECT  SUM(count_of_reaction) as N
into TOTAL_COUNT
from DRUG_ADVERSE_REACTIONS_COUNT;

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--contingency table:
DROP TABLE IF EXISTS CONTINGENCY_TABLE ;
SELECT a.RXAUI, DRUG, a.Adverse_Event,  a.count_of_reaction as A
	, (EVENT_MARGIN.Margin - count_of_reaction) as B
	, (DRUG_MARGIN.Margin - count_of_reaction) as C
	, (SELECT N from TOTAL_COUNT)  - EVENT_MARGIN.Margin -(DRUG_MARGIN.Margin - count_of_reaction) as D
	into  CONTINGENCY_TABLE
	from
	DRUG_ADVERSE_REACTIONS_COUNT a inner join DRUG_MARGIN on  a.RXAUI = DRUG_MARGIN.RXAUI
	inner join EVENT_MARGIN  on a.Adverse_Event = EVENT_MARGIN.Adverse_Event
	order by RXAUI, Adverse_Event
	
	
ALTER table CONTINGENCY_TABLE
ADD ID INT IDENTITY(1,1) NOT NULL;


------------------------------
ALTER TABLE CONTINGENCY_TABLE
ALTER COLUMN A FLOAT ;
ALTER TABLE CONTINGENCY_TABLE
ALTER COLUMN B FLOAT ;
ALTER TABLE CONTINGENCY_TABLE
ALTER COLUMN C FLOAT ;
ALTER TABLE CONTINGENCY_TABLE
ALTER COLUMN D FLOAT ;
--------------------------------------
--------------------------------------

DROP TABLE IF EXISTS [FAERS_A].[dbo].[PROPORTIONATE_ANALYSIS];

SET ARITHABORT OFF    
SET ANSI_WARNINGS OFF
select RXAUI, DRUG, Adverse_Event,
A	,(((A+B)*(A+C))/(A+B+C+D)) as N_Expected	
	,(A/(A+C))/(B/(B+D)) AS PRR   
	,EXP(LOG((A/(A+C))/(B/(B+D)))-(1.96*SQRT((1/A)-(1/(A+C))+(1/B)-(1/(B+D)))))  PRR_LB  
	,EXP(LOG((A/(A+C))/(B/(B+D)))+(1.96*SQRT((1/A)-(1/(A+C))+(1/B)-(1/(B+D)))))  PRR_UB
	,ROUND ((A+B+C+D)*(SQUARE((ABS((A*D) - (B*C)))-((A+B+C+D)/2))/((A+C) * (B+D) * (A+B) * (C+D))) ,8)   as CHI_Squared_Yates
	,ROUND((((A / C) / (B / D))),8) as ROR
	,EXP(LOG((A / C) / (B / D))-(1.96*SQRT((1/A)+(1/(B))+(1/C)+(1/(B+D)))))  ROR_LB  
	,EXP(LOG((A / C) / (B / D))+(1.96*SQRT((1/A)+(1/(B))+(1/C)+(1/(B+D)))))  ROR_UB
	, log((A + 0.5)/ ((((A+B)*(A+C))/(A+B+C+D)) + 0.5),2)   as IC
	, (log((A + 0.5)/ ((((A+B)*(A+C))/(A+B+C+D)) + 0.5),2)) - (3.3*(Power((A+0.5),-0.5)))-(2*(Power((A+0.5),-1.5)))  as IC025
    , (log((A + 0.5)/ ((((A+B)*(A+C))/(A+B+C+D)) + 0.5),2)) + (2.4*(Power((A+0.5),-0.5)))-(0.5*(Power((A+0.5),-1.5)))  as IC975

	
INTO [FAERS_A].[dbo].[PROPORTIONATE_ANALYSIS]
FROM CONTINGENCY_TABLE 



ALTER table [FAERS_A].[dbo].[PROPORTIONATE_ANALYSIS] 
ADD ID INT IDENTITY(1,1) NOT NULL

-------------------------------
