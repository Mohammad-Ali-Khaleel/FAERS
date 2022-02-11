
/************************************** CREATING FAERS_B DATABASE***************************************

*********************************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = '[FAERS_B]')
  BEGIN
    CREATE DATABASE [FAERS_B]
    END
    GO
------------------------------
       USE [FAERS_B]
    GO
--------------------------------
ALTER DATABASE [FAERS_B] SET RECOVERY SIMPLE;
-------------------------------------------------------------------------------------------------------------------------
/************************************** CREATING DRUG_MAPPER TABLE ***************************************

*********************************************************************************************************************/
DROP  TABLE IF EXISTS DRUG_Mapper ;
CREATE TABLE DRUG_Mapper (
	[DRUG_ID] [int] NOT NULL,
	[primaryid] [bigint] NULL,
	[caseid] [bigint] NULL,
	[DRUG_SEQ] [bigint] NULL,
	[ROLE_COD] [varchar](2) NULL,
	[PERIOD] [varchar](4) NULL,
	[DRUGNAME] [varchar](500) NULL,
	[prod_ai] [varchar](400) NULL,
	[NDA_NUM] [varchar](200) NULL,
	[NOTES] [varchar](100) NULL,
	[RXAUI] [bigint] NULL,
	[RXCUI] [bigint] NULL,
	[STR] [varchar](3000) NULL,
	[SAB] [varchar](20) NULL,
	[TTY] [varchar](20) NULL,
	[CODE] [varchar](50) NULL,
	[remapping_NOTES] [varchar](100) NULL,
	[remapping_RXAUI] [varchar](8) NULL,
	[remapping_RXCUI] [varchar](8) NULL,
	[remapping_STR] [varchar](3000) NULL,
	[remapping_SAB] [varchar](20) NULL,
	[remapping_TTY] [varchar](20) NULL,
	[remapping_CODE] [varchar](50) NULL,

) 

INSERT INTO DRUG_Mapper (DRUG_ID, primaryid, caseid, DRUG_SEQ, ROLE_COD,  DRUGNAME, prod_ai, NDA_NUM,  PERIOD)
SELECT DRUG_ID, primaryid, caseid, DRUG_SEQ, ROLE_COD,  DRUGNAME, prod_ai, NDA_NUM,  PERIOD
FROM [FAERS_A].dbo.DRUGs_Combined
where primaryid in (select primaryid from [FAERS_A].[dbo].[ALIGNED_DEMO_DRUG_REAC_INDI_THER]);
------------------------------

CREATE INDEX DRUGNAME_INDEX
ON DRUG_Mapper ( DRUGNAME )
go


/************************************** CREATE RXNORM TABLES AND LOADING TABLES***************************************

JUST UPDATE THE FILES LOCATION IN THE CODE
*********************************************************************************************************************/


DROP  TABLE IF EXISTS RXNATOMARCHIVE;
CREATE TABLE RXNATOMARCHIVE
(
   RXAUI             varchar(8) NOT NULL,
   AUI               varchar(10),
   STR               varchar(4000) NOT NULL,
   ARCHIVE_TIMESTAMP varchar(280) NOT NULL,
   CREATED_TIMESTAMP varchar(280) NOT NULL,
   UPDATED_TIMESTAMP varchar(280) NOT NULL,
   CODE              varchar(50),
   IS_BRAND          varchar(1),
   LAT               varchar(3),
   LAST_RELEASED     varchar(30),
   SAUI              varchar(50),
   VSAB              varchar(40),
   RXCUI             varchar(8),
   SAB               varchar(20),
   TTY               varchar(20),
   MERGED_TO_RXCUI   varchar(8)
)
;

DROP  TABLE IF EXISTS RXNCONSO;
CREATE TABLE RXNCONSO
(
   RXCUI             varchar(8) NOT NULL,
   LAT               varchar (3) DEFAULT 'ENG' NOT NULL,
   TS                varchar (1),
   LUI               varchar(8),
   STT               varchar (3),
   SUI               varchar (8),
   ISPREF            varchar (1),
   RXAUI             varchar(8) NOT NULL,
   SAUI              varchar (50),
   SCUI              varchar (50),
   SDUI              varchar (50),
   SAB               varchar (20) NOT NULL,
   TTY               varchar (20) NOT NULL,
   CODE              varchar (50) NOT NULL,
   STR               varchar (3000) NOT NULL,
   SRL               varchar (10),
   SUPPRESS          varchar (1),
   CVF               varchar(50)
)
;

DROP TABLE IF EXISTS RXNREL;
CREATE TABLE RXNREL
(
   RXCUI1    varchar(8) ,
   RXAUI1    varchar(8),
   STYPE1    varchar(50),
   REL       varchar(4) ,
   RXCUI2    varchar(8) ,
   RXAUI2    varchar(8),
   STYPE2    varchar(50),
   RELA      varchar(100) ,
   RUI       varchar(10),
   SRUI      varchar(50),
   SAB       varchar(20) NOT NULL,
   SL        varchar(1000),
   DIR       varchar(1),
   RG        varchar(10),
   SUPPRESS  varchar(1),
   CVF       varchar(50)
)
;

DROP TABLE IF EXISTS RXNSAB;
CREATE TABLE RXNSAB
(
   VCUI           varchar (8),
   RCUI           varchar (8),
   VSAB           varchar (40),
   RSAB           varchar (20) NOT NULL,
   SON            varchar (3000),
   SF             varchar (20),
   SVER           varchar (20),
   VSTART         varchar (10),
   VEND           varchar (10),
   IMETA          varchar (10),
   RMETA          varchar (10),
   SLC            varchar (1000),
   SCC            varchar (1000),
   SRL            integer,
   TFR            integer,
   CFR            integer,
   CXTY           varchar (50),
   TTYL           varchar (300),
   ATNL           varchar (1000),
   LAT            varchar (3),
   CENC           varchar (20),
   CURVER         varchar (1),
   SABIN          varchar (1),
   SSN            varchar (3000),
   SCIT           varchar (4000)
)
;

DROP TABLE IF EXISTS RXNSAT;
CREATE TABLE RXNSAT
(
   RXCUI            varchar(8) ,
   LUI              varchar(8),
   SUI              varchar(8),
   RXAUI            varchar(9),
   STYPE            varchar (50),
   CODE             varchar (50),
   ATUI             varchar(11),
   SATUI            varchar (50),
   ATN              varchar (1000) NOT NULL,
   SAB              varchar (20) NOT NULL,
   ATV              varchar (4000),
   SUPPRESS         varchar (1),
   CVF              varchar (50)
)
;

DROP TABLE IF EXISTS RXNSTY;
CREATE TABLE RXNSTY
(
   RXCUI          varchar(8) NOT NULL,
   TUI            varchar (4),
   STN            varchar (100),
   STY            varchar (50),
   ATUI           varchar (11),
   CVF            varchar (50)
)
;

DROP TABLE IF EXISTS RXNDOC;
CREATE TABLE RXNDOC (
    DOCKEY      varchar(50) NOT NULL,
    VALUE       varchar(1000),
    TYPE        varchar(50) NOT NULL,
    EXPL        varchar(1000)
)
;

DROP  TABLE IF EXISTS  RXNCUICHANGES;
CREATE TABLE RXNCUICHANGES
(
      RXAUI         varchar(8),
      CODE          varchar(50),
      SAB           varchar(20),
      TTY           varchar(20),
      STR           varchar(3000),
      OLD_RXCUI     varchar(8) NOT NULL,
      NEW_RXCUI     varchar(8) NOT NULL
)
;

DROP  TABLE IF EXISTS  RXNCUI;
 CREATE TABLE RXNCUI (
 cui1 VARCHAR(8),
 ver_start VARCHAR(40),
 ver_end   VARCHAR(40),
 cardinality VARCHAR(8),
 cui2       VARCHAR(8) 
)
;

BULK INSERT RXNATOMARCHIVE FROM 'd:\RxNorm_full_06072021\rrf\RXNATOMARCHIVE.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');


BULK INSERT RXNCONSO FROM 'd:\RxNorm_full_06072021\rrf\RXNCONSO.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');


BULK INSERT RXNREL FROM 'd:\RxNorm_full_06072021\rrf\RXNREL.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');



BULK INSERT RXNSAB FROM 'd:\RxNorm_full_06072021\rrf\RXNSAB.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');



BULK INSERT RXNSAT FROM 'd:\RxNorm_full_06072021\rrf\RXNSAT.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');



BULK INSERT RXNSTY FROM 'd:\RxNorm_full_06072021\rrf\RXNSTY.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');



BULK INSERT RXNDOC FROM 'd:\RxNorm_full_06072021\rrf\RXNDOC.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');



BULK INSERT RXNCUICHANGES FROM 'd:\RxNorm_full_06072021\rrf\RXNCUICHANGES.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');


BULK INSERT RXNCUI FROM 'd:\RxNorm_full_06072021\rrf\RXNCUI.RRF' WITH  ( FIRSTROW = 1, FIELDTERMINATOR = '|',  ROWTERMINATOR='0x0A');


-------===============================================================================================
CREATE INDEX RXNCONSO_RXCUI
ON RXNCONSO ( RXCUI);

CREATE INDEX RXNCONSO_RXAUI
ON RXNCONSO ( RXAUI);

CREATE INDEX RXNCONSO_SAB
ON RXNCONSO ( SAB);

CREATE INDEX RXNCONSO_TTY
ON RXNCONSO ( TTY);

CREATE INDEX RXNCONSO_CODE
ON RXNCONSO ( CODE);



CREATE INDEX RXNSAT_RXCUI
ON RXNSAT (RXCUI );

CREATE INDEX RXNSAT_RXAUI
ON RXNSAT (RXCUI, RXAUI );




Create Index RXNREL_RXCUI1
on RXNREL (RXCUI1);

Create Index RXNREL_RXCUI2
on RXNREL (RXCUI2);

Create Index RXNREL_RXAUI1
on RXNREL (RXAUI1);

Create Index RXNREL_RXAUI2
on RXNREL (RXAUI2);

Create Index RXNREL_RELA
on RXNREL (RELA);

Create Index RXNREL_REL
on RXNREL (REL);
