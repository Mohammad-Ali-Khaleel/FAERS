
--STANDARDIZE DEMO_Combined AGE FILED TO YEARS

ALTER TABLE [DEMO_Combined]
ADD AGE_Years_fixed FLOAT;
-------------
WITH CTE AS (SELECT  [DEMO_ID]
    
      ,[AGE]
      ,[AGE_COD]

	   , case WHEN [AGE_COD] ='DEC' then round(CAST ([AGE]AS float)*12 ,2)
			WHEN	  [AGE_COD]='YR' then ROUND([AGE] ,2)
			WHEN  	  [AGE_COD]='YEAR' then ROUND([AGE] ,2)
			WHEN  	  [AGE_COD]='MON' then ROUND(CAST ([AGE]AS float)/12 ,2)
			WHEN   	  [AGE_COD]='WK' then ROUND(CAST ([AGE]AS float)/52 ,2)
			WHEN  	  [AGE_COD]='WEEK' THEN ROUND(CAST ([AGE]AS float)/52 ,2)
			WHEN  	  [AGE_COD]='DY' then ROUND(CAST ([AGE]AS float)/365 ,2)
			WHEN  	  [AGE_COD]='DAY' then ROUND(CAST ([AGE]AS float)/365 ,2)
			WHEN   	  [AGE_COD]='HR' then ROUND(CAST ([AGE]AS float)/8760 ,2)
			WHEN   	  [AGE_COD]='HOUR' then ROUND(CAST ([AGE]AS float)/8760,2) else AGE END AGE_Years_fixed
	
  FROM [FAERS_A].[dbo].[DEMO_Combined]
  WHERE ISNUMERIC([AGE]) = 1)
  UPDATE [DEMO_Combined] 
  SET [DEMO_Combined].AGE_Years_fixed = cte.AGE_Years_fixed FROM [DEMO_Combined]   INNER JOIN
  CTE ON [DEMO_Combined].DEMO_ID = CTE.DEMO_ID;

--STANDARDIZING DEMO_Combined COUNTRY CODE
ALTER TABLE DEMO_Combined
ADD  COUNTRY_CODE VARCHAR(2);
go
-----------------------------------
update DEMO_Combined
  set COUNTRY_CODE = case
WHEN reporter_country = 'AFGHANISTAN' THEN 'AF'
WHEN reporter_country = 'ALAND ISLANDS' THEN 'AX'
WHEN reporter_country = 'ALBANIA' THEN 'AL'
WHEN reporter_country = 'ALGERIA' THEN 'DZ'
WHEN reporter_country = 'AMERICAN SAMOA' THEN 'AS'
WHEN reporter_country = 'ANDORRA' THEN 'AD'
WHEN reporter_country = 'ANGOLA' THEN 'AO'
WHEN reporter_country = 'ANGUILLA' THEN 'AI'
WHEN reporter_country = 'ANTIGUA AND BARBUDA' THEN 'AG'
WHEN reporter_country = 'ARGENTINA' THEN 'AR'
WHEN reporter_country = 'ARMENIA' THEN 'AM'
WHEN reporter_country = 'ARUBA' THEN 'AW'
WHEN reporter_country = 'AUSTRALIA' THEN 'AU'
WHEN reporter_country = 'AUSTRIA' THEN 'AT'
WHEN reporter_country = 'AZERBAIJAN' THEN 'AZ'
WHEN reporter_country = 'BAHAMAS' THEN 'BS'
WHEN reporter_country = 'BAHRAIN' THEN 'BH'
WHEN reporter_country = 'BANGLADESH' THEN 'BD'
WHEN reporter_country = 'BARBADOS' THEN 'BB'
WHEN reporter_country = 'BELARUS' THEN 'BY'
WHEN reporter_country = 'BELGIUM' THEN 'BE'
WHEN reporter_country = 'BELIZE' THEN 'BZ'
WHEN reporter_country = 'BENIN' THEN 'BJ'
WHEN reporter_country = 'BERMUDA' THEN 'BM'
WHEN reporter_country = 'BOLIVIA' THEN 'BO'
WHEN reporter_country = 'BOSNIA AND HERZEGOWINA' THEN 'BA'
WHEN reporter_country = 'BOTSWANA' THEN 'BW'
WHEN reporter_country = 'BRAZIL' THEN 'BR'
WHEN reporter_country = 'BRUNEI DARUSSALAM' THEN 'BN'
WHEN reporter_country = 'BULGARIA' THEN 'BG'
WHEN reporter_country = 'BURKINA FASO' THEN 'BF'
WHEN reporter_country = 'BURUNDI' THEN 'BI'
WHEN reporter_country = 'CAMBODIA' THEN 'KH'
WHEN reporter_country = 'CAMEROON' THEN 'CM'
WHEN reporter_country = 'CANADA' THEN 'CA'
WHEN reporter_country = 'CAPE VERDE' THEN 'CV'
WHEN reporter_country = 'CAYMAN ISLANDS' THEN 'KY'
WHEN reporter_country = 'CHILE' THEN 'CL'
WHEN reporter_country = 'CHINA' THEN 'CN'
WHEN reporter_country = 'COLOMBIA' THEN 'CO'
WHEN reporter_country = 'CONGO' THEN 'CG'
WHEN reporter_country = 'CONGO, THE DEMOCRATIC REPUBLIC OF THE' THEN 'CD'
WHEN reporter_country = 'COSTA RICA' THEN 'CR'
WHEN reporter_country = 'COTE D''IVOIRE' THEN 'CI'
WHEN reporter_country = 'COUNTRY NOT SPECIFIED' THEN NULL
WHEN reporter_country = 'CROATIA (local name: Hrvatska)' THEN 'HR'
WHEN reporter_country = 'CUBA' THEN 'CU'
WHEN reporter_country = 'CURACAO' THEN 'CW'
WHEN reporter_country = 'CYPRUS' THEN 'CY'
WHEN reporter_country = 'CZECH REPUBLIC' THEN 'CZ'
WHEN reporter_country = 'DENMARK' THEN 'DK'
WHEN reporter_country = 'DOMINICA' THEN 'DM'
WHEN reporter_country = 'DOMINICAN REPUBLIC' THEN 'DO'
WHEN reporter_country = 'ECUADOR' THEN 'EC'
WHEN reporter_country = 'EGYPT' THEN 'EG'
WHEN reporter_country = 'EL SALVADOR' THEN 'SV'
WHEN reporter_country = 'ESTONIA' THEN 'EE'
WHEN reporter_country = 'ETHIOPIA' THEN 'ET'
WHEN reporter_country = 'European Union' THEN 'EU'
WHEN reporter_country = 'FAROE ISLANDS' THEN 'FO'
WHEN reporter_country = 'FIJI' THEN 'FJ'
WHEN reporter_country = 'FINLAND' THEN 'FI'
WHEN reporter_country = 'FRANCE' THEN 'FR'
WHEN reporter_country = 'FRANCE, METROPOLITAN' THEN 'FX'
WHEN reporter_country = 'FRENCH GUIANA' THEN 'GF'
WHEN reporter_country = 'FRENCH POLYNESIA' THEN 'PF'
WHEN reporter_country = 'FRENCH SOUTHERN TERRITORIES' THEN 'TF'
WHEN reporter_country = 'GABON' THEN 'GA'
WHEN reporter_country = 'GAMBIA' THEN 'GM'
WHEN reporter_country = 'GEORGIA' THEN 'GE'
WHEN reporter_country = 'GERMANY' THEN 'DE'
WHEN reporter_country = 'GHANA' THEN 'GH'
WHEN reporter_country = 'GIBRALTAR' THEN 'GI'
WHEN reporter_country = 'GREECE' THEN 'GR'
WHEN reporter_country = 'GREENLAND' THEN 'GL'
WHEN reporter_country = 'GRENADA' THEN 'GD'
WHEN reporter_country = 'GUADELOUPE' THEN 'GP'
WHEN reporter_country = 'GUAM' THEN 'GU'
WHEN reporter_country = 'GUATEMALA' THEN 'GT'
WHEN reporter_country = 'GUINEA-BISSAU' THEN 'GW'
WHEN reporter_country = 'GUYANA' THEN 'GY'
WHEN reporter_country = 'HAITI' THEN 'HT'
WHEN reporter_country = 'HONDURAS' THEN 'HN'
WHEN reporter_country = 'HONG KONG' THEN 'HK'
WHEN reporter_country = 'HUNGARY' THEN 'HU'
WHEN reporter_country = 'ICELAND' THEN 'IS'
WHEN reporter_country = 'INDIA' THEN 'IN'
WHEN reporter_country = 'INDONESIA' THEN 'ID'
WHEN reporter_country = 'IRAN (ISLAMIC REPUBLIC OF)' THEN 'IR'
WHEN reporter_country = 'IRAQ' THEN 'IQ'
WHEN reporter_country = 'IRELAND' THEN 'IE'
WHEN reporter_country = 'ISLE OF MAN' THEN 'IM'
WHEN reporter_country = 'ISRAEL' THEN 'IL'
WHEN reporter_country = 'ITALY' THEN 'IT'
WHEN reporter_country = 'JAMAICA' THEN 'JM'
WHEN reporter_country = 'JAPAN' THEN 'JP'
WHEN reporter_country = 'JORDAN' THEN 'JO'
WHEN reporter_country = 'KAZAKHSTAN' THEN 'KZ'
WHEN reporter_country = 'KENYA' THEN 'KE'
WHEN reporter_country = 'KIRIBATI' THEN 'KI'
WHEN reporter_country = 'KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF' THEN 'KP'
WHEN reporter_country = 'KOREA, REPUBLIC OF' THEN 'KR'
WHEN reporter_country = 'KUWAIT' THEN 'KW'
WHEN reporter_country = 'KYRGYZSTAN' THEN 'KG'
WHEN reporter_country = 'LAO PEOPLE''S DEMOCRATIC REPUBLIC' THEN 'LA'
WHEN reporter_country = 'LATVIA' THEN 'LV'
WHEN reporter_country = 'LEBANON' THEN 'LB'
WHEN reporter_country = 'LESOTHO' THEN 'LS'
WHEN reporter_country = 'LIBERIA' THEN 'LR'
WHEN reporter_country = 'LIBYAN ARAB JAMAHIRIYA' THEN 'LY'
WHEN reporter_country = 'LIECHTENSTEIN' THEN 'LI'
WHEN reporter_country = 'LITHUANIA' THEN 'LT'
WHEN reporter_country = 'LUXEMBOURG' THEN 'LU'
WHEN reporter_country = 'MACAU' THEN 'MO'
WHEN reporter_country = 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF' THEN 'MK'
WHEN reporter_country = 'MADAGASCAR' THEN 'MG'
WHEN reporter_country = 'MALAWI' THEN 'MW'
WHEN reporter_country = 'MALAYSIA' THEN 'MY'
WHEN reporter_country = 'MALI' THEN 'ML'
WHEN reporter_country = 'MALTA' THEN 'MT'
WHEN reporter_country = 'MARTINIQUE' THEN 'MQ'
WHEN reporter_country = 'MAURITANIA' THEN 'MR'
WHEN reporter_country = 'MAURITIUS' THEN 'MU'
WHEN reporter_country = 'MAYOTTE' THEN 'YT'
WHEN reporter_country = 'MEXICO' THEN 'MX'
WHEN reporter_country = 'MICRONESIA, FEDERATED STATES OF' THEN 'FM'
WHEN reporter_country = 'MOLDOVA, REPUBLIC OF' THEN 'MD'
WHEN reporter_country = 'MONACO' THEN 'MC'
WHEN reporter_country = 'MONGOLIA' THEN 'MN'
WHEN reporter_country = 'MONTENEGRO' THEN 'ME'
WHEN reporter_country = 'MONTSERRAT' THEN 'MS'
WHEN reporter_country = 'MOROCCO' THEN 'MA'
WHEN reporter_country = 'MYANMAR' THEN 'MM'
WHEN reporter_country = 'NAMIBIA' THEN 'NA'
WHEN reporter_country = 'NEPAL' THEN 'NP'
WHEN reporter_country = 'NETHERLANDS' THEN 'NL'
WHEN reporter_country = 'NETHERLANDS ANTILLES' THEN 'AN'
WHEN reporter_country = 'NETHERLANDS ANTILLES (retired code)' THEN 'AN'
WHEN reporter_country = 'NEW CALEDONIA' THEN 'NC'
WHEN reporter_country = 'NEW ZEALAND' THEN 'NZ'
WHEN reporter_country = 'NICARAGUA' THEN 'NI'
WHEN reporter_country = 'NIGER' THEN 'NE'
WHEN reporter_country = 'NIGERIA' THEN 'NG'
WHEN reporter_country = 'NORFOLK ISLAND' THEN 'NF'
WHEN reporter_country = 'NORWAY' THEN 'NO'
WHEN reporter_country = 'OMAN' THEN 'OM'
WHEN reporter_country = 'PAKISTAN' THEN 'PK'
WHEN reporter_country = 'PALESTINIAN TERRITORY, OCCUPIED' THEN 'PS'
WHEN reporter_country = 'PANAMA' THEN 'PA'
WHEN reporter_country = 'PAPUA NEW GUINEA' THEN 'PG'
WHEN reporter_country = 'PARAGUAY' THEN 'PY'
WHEN reporter_country = 'PERU' THEN 'PE'
WHEN reporter_country = 'PHILIPPINES' THEN 'PH'
WHEN reporter_country = 'POLAND' THEN 'PL'
WHEN reporter_country = 'PORTUGAL' THEN 'PT'
WHEN reporter_country = 'PUERTO RICO' THEN 'PR'
WHEN reporter_country = 'QATAR' THEN 'QA'
WHEN reporter_country = 'REUNION' THEN 'RE'
WHEN reporter_country = 'ROMANIA' THEN 'RO'
WHEN reporter_country = 'RUSSIAN FEDERATION' THEN 'RU'
WHEN reporter_country = 'RWANDA' THEN 'RW'
WHEN reporter_country = 'SAINT KITTS AND NEVIS' THEN 'KN'
WHEN reporter_country = 'SAMOA' THEN 'WS'
WHEN reporter_country = 'SAUDI ARABIA' THEN 'SA'
WHEN reporter_country = 'SENEGAL' THEN 'SN'
WHEN reporter_country = 'SERBIA' THEN 'RS'
WHEN reporter_country = 'SERBIA AND MONTENEGRO' THEN 'CS'
WHEN reporter_country = 'SERBIA AND MONTENEGRO (see individual countries)' THEN 'CS'
WHEN reporter_country = 'SIERRA LEONE' THEN 'SL'
WHEN reporter_country = 'SINGAPORE' THEN 'SG'
WHEN reporter_country = 'SLOVAKIA (Slovak Republic)' THEN 'SK'
WHEN reporter_country = 'SLOVENIA' THEN 'SI'
WHEN reporter_country = 'SOLOMON ISLANDS' THEN 'SB'
WHEN reporter_country = 'SOUTH AFRICA' THEN 'ZA'
WHEN reporter_country = 'SPAIN' THEN 'ES'
WHEN reporter_country = 'SRI LANKA' THEN 'LK'
WHEN reporter_country = 'SUDAN' THEN 'SD'
WHEN reporter_country = 'SURINAME' THEN 'SR'
WHEN reporter_country = 'SVALBARD AND JAN MAYEN ISLANDS' THEN 'SJ'
WHEN reporter_country = 'SWAZILAND' THEN 'SZ'
WHEN reporter_country = 'SWEDEN' THEN 'SE'
WHEN reporter_country = 'SWITZERLAND' THEN 'CH'
WHEN reporter_country = 'SYRIAN ARAB REPUBLIC' THEN 'SY'
WHEN reporter_country = 'TAIWAN, PROVINCE OF CHINA' THEN 'TW'
WHEN reporter_country = 'TANZANIA, UNITED REPUBLIC OF' THEN 'TZ'
WHEN reporter_country = 'THAILAND' THEN 'TH'
WHEN reporter_country = 'TOGO' THEN 'TG'
WHEN reporter_country = 'TOKELAU' THEN 'TK'
WHEN reporter_country = 'TRINIDAD AND TOBAGO' THEN 'TT'
WHEN reporter_country = 'TUNISIA' THEN 'TN'
WHEN reporter_country = 'TURKEY' THEN 'TR'
WHEN reporter_country = 'UGANDA' THEN 'UG'
WHEN reporter_country = 'UKRAINE' THEN 'UA'
WHEN reporter_country = 'UNITED ARAB EMIRATES' THEN 'AE'
WHEN reporter_country = 'UNITED KINGDOM' THEN 'GB'
WHEN reporter_country = 'UNITED STATES' THEN 'US'
WHEN reporter_country = 'UNITED STATES MINOR OUTLYING ISLANDS' THEN 'UM'
WHEN reporter_country = 'URUGUAY' THEN 'UY'
WHEN reporter_country = 'UZBEKISTAN' THEN 'UZ'
WHEN reporter_country = 'VATICAN CITY STATE (HOLY SEE)' THEN 'VA'
WHEN reporter_country = 'VENEZUELA' THEN 'VE'
WHEN reporter_country = 'VIET NAM' THEN 'VN'
WHEN reporter_country = 'VIRGIN ISLANDS (U.S.)' THEN 'VI'
WHEN reporter_country = 'WALLIS AND FUTUNA ISLANDS' THEN 'WF'
WHEN reporter_country = 'YEMEN' THEN 'YE'
WHEN reporter_country = 'YUGOSLAVIA' THEN 'YU'
WHEN reporter_country = 'ZAIRE' THEN 'ZR'
WHEN reporter_country = 'ZAMBIA' THEN 'ZM'
WHEN reporter_country = 'ZIMBABWE' THEN 'ZW'
ELSE CASE WHEN LEN(reporter_country)=2 THEN reporter_country
ELSE NULL

END END
--------------------------------------------------
ALTER TABLE DEMO_Combined
ADD  Gender VARCHAR(3);
go
--------------------------------------------------
update DEMO_Combined
set Gender = sex;
---------------------------------------------------
update DEMO_Combined
set Gender = null
where Gender = 'UNK';
---------------------------------------------------

update DEMO_Combined
set Gender = null
where Gender = 'NS';
--------------------------------------------------
update DEMO_Combined
set Gender = null
where gender = 'YR';
---------------------------------------------------

-------------------------------------
-- PREPARE FOR DEDUPLICATION STEP, COMBINE ALL TOGETHER : DEMO_COMBINED + DRUGs_Combined + COMBINED_DRUGS + COMBINED_THER + COMBINED_INDI + COMBINED_REAC 
-- GET ONLY THE LATEST CASE REPORT
DROP table IF EXISTS Aligned_DEMO_DRUG_REAC_INDI_THER ;

WITH CTE AS (SELECT  x.DEMO_ID, x.caseid, x.primaryid, x.caseversion, x.fda_dt, x.I_F_COD, x.event_dt, x.AGE_Years_fixed, x.GENDER, x.COUNTRY_CODE,x.OCCP_COD, x.PERIOD, Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC
				FROM    DEMO_Combined x  LEFT OUTER JOIN
                 
				(SELECT   primaryid	, STRING_AGG(cast(drugname as NVARCHAR(MAX)), '/'  ) WITHIN GROUP(ORDER BY DRUG_SEQ ) AS Aligned_drugs
				FROM DRUGs_Combined
				group by primaryid) a ON x.primaryid = a.primaryid LEFT OUTER JOIN

				(SELECT   primaryid	, STRING_AGG(cast(MEDDRA_CODE as NVARCHAR(MAX)), '/'  ) WITHIN GROUP(ORDER BY indi_drug_seq,MEDDRA_CODE ) AS Aligned_INDI
				FROM INDI_Combined WHERE MEDDRA_CODE NOT IN (10070592,10057097)
				group by primaryid) b on a.primaryid=b.primaryid left outer join

				(SELECT   primaryid	, STRING_AGG(cast(START_DT as NVARCHAR(MAX)), '/'  ) WITHIN GROUP(ORDER BY dsg_drug_seq,START_DT ) AS Aligned_START_DATE
				FROM THER_Combined
				group by primaryid) c on a.primaryid=c.primaryid left outer join 

				(SELECT primaryid   , STRING_AGG(cast(MEDDRA_CODE as NVARCHAR(MAX)), '/' ) WITHIN GROUP(ORDER BY MEDDRA_CODE ) as ALIGNED_REAC 
				FROM [REAC_Combined]  
				GROUP BY primaryid) d on a.primaryid=d.primaryid 
				) 

select DEMO_ID, caseid, primaryid, caseversion, fda_dt,  I_F_COD, event_dt, AGE_Years_fixed, GENDER, COUNTRY_CODE, OCCP_COD, Period, Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC
INTO ALIGNED_DEMO_DRUG_REAC_INDI_THER
from	(select *, row_number() over(partition by caseid order by primaryid desc, PERIOD desc, caseversion desc, fda_dt desc,  I_F_COD desc, event_dt desc ) as row_num 
from CTE 
		) a where a.row_num = 1;

-- Full match(ALL CRITERIA MATCHED)
WITH CTE AS (
	select *, 
	row_number() over(partition by event_dt, AGE_Years_fixed, GENDER, COUNTRY_CODE,  Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
	) Delete from cte WHERE row_num > 1; 

--(Full match - event_dt)
WITH CTE AS (
	select *, 
	row_number() over(partition by  AGE_Years_fixed, GENDER, COUNTRY_CODE,  Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
		) Delete from cte WHERE row_num > 1;

--(Full match - AGE_Years_fixed)
WITH CTE AS (
	select *, 
	row_number() over(partition by event_dt, GENDER, COUNTRY_CODE,  Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
	) Delete from cte WHERE row_num > 1;

--(Full match -	GENDER)
WITH CTE AS (
	select *, 
	row_number() over(partition by event_dt, AGE_Years_fixed, COUNTRY_CODE,  Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
	) Delete from cte WHERE row_num > 1;

--(Full match - COUNTRY_CODE)
WITH CTE AS (
	select *, 
	row_number() over(partition by event_dt, AGE_Years_fixed, GENDER,  Aligned_drugs , Aligned_INDI , Aligned_START_DATE , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
	) Delete from cte WHERE row_num > 1;

--(Full match -	Aligned_INDI)
WITH CTE AS (
	select *, 
	row_number() over(partition by event_dt, AGE_Years_fixed, GENDER, COUNTRY_CODE,  Aligned_drugs, Aligned_START_DATE , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
	) Delete from cte WHERE row_num > 1

--(Full match -	Aligned_START_DATE)
WITH CTE AS (
	select *, 
	row_number() over(partition by event_dt, AGE_Years_fixed, GENDER, COUNTRY_CODE,  Aligned_drugs , Aligned_INDI , ALIGNED_REAC ORDER BY primaryid desc, Period desc) as row_num  
	from Aligned_DEMO_DRUG_REAC_INDI_THER
	) Delete from cte WHERE row_num > 1;
---------------------------------------------------------------------------------------------
--DELETE CASES PRESENT IN THE DELETED CASES FILES IN THE FAERS QUARTERLY DATA EXTRACT FILES
-- WE USED MICROSOFT ACCESS DATABASE TO COMBINE THE TABLES TO PRODUCCE COMBINED_DELETED_CASES_REPORTS, KEEP Field1 NAME AS THE FIELD NAME OF THE CASEID

DELETE FROM Aligned_DEMO_DRUG_REAC_INDI_THER
WHERE CASEID IN (SELECT Field1 FROM COMBINED_DELETED_CASES_REPORTS)
---------------------------------------------------------------------------------------------
