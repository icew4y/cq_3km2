##################################################     Build 3
##################################################
##################################################     INFORMIX     ###########
##################################################
##################################################
#INFORMIX.ServerItems
/*SELECT
 user OBJ_NAME,
 user TEMPLATE_NAME,
 0 SUB_OBJ_NAME,
 user NODES_SQLCLASS_NAME,
 user LOCAL_FILTER
 ,user AS aowner
FROM systables s 
WHERE 1 <> 1     --Tables
UNION ALL*/
SELECT
 trim(both from CAST("Tables              " AS VARCHAR(100))) OBJ_NAME,
 trim(both from CAST("Tables              " AS VARCHAR(100))) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("TableObjects" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype = 'T' and owner <> 'informix'" AS VARCHAR(100)) LOCAL_FILTER
 ,trim(both from user) AS aowner
 ,0 Image_Index
FROM systables s 
WHERE tabtype = 'T' and owner <> 'informix'     --Tables
UNION ALL
SELECT
 CAST("Views" AS VARCHAR(20)) OBJ_NAME,
 CAST("Views" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("TableObjects" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype = 'V' and owner <> 'informix'" AS VARCHAR(100)) LOCAL_FILTER
 ,user AS aowner
 ,4 Image_Index
FROM systables s              --Views
WHERE tabtype = 'V' and owner <> 'informix'
UNION ALL
SELECT
 CAST("Sinonims" AS VARCHAR(20)) OBJ_NAME,
 CAST("Sinonims" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("TableObjects" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype IN ('P', 'S') and owner <> 'informix'" AS VARCHAR(100)) LOCAL_FILTER
 ,user AS aowner
 ,4 Image_Index
FROM systables s              --Sinonims
WHERE tabtype IN ('P', 'S') and owner <> 'informix'
UNION ALL
SELECT
 CAST("Procedures" AS VARCHAR(20)) OBJ_NAME,
 CAST("Procedures" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("TableObjects" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype = 'PR' and owner <> 'informix'" AS VARCHAR(100)) LOCAL_FILTER
 ,user AS aowner
 ,3 Image_Index
FROM systables s              --Synonyms
WHERE tabtype = 'PR' and owner <> 'informix'
UNION ALL
SELECT
 CAST("SysInfo" AS VARCHAR(20)) OBJ_NAME,
 CAST("SysInfo" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("SysInfo" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("owner = 'informix'" AS VARCHAR(100)) LOCAL_FILTER
 ,user AS aowner
 ,-1 Image_Index
FROM systables s              --SysInfo
WHERE 1<>1 

##################################################
#INFORMIX.Tables
select
  trim(both from owner) || '.' || trim(both from tabname) objname,
  s.tabid,
  case when s.owner = 'informix' then 1 else 0 end order1,
  trim(both from owner) owner,
  s.tabname  name,
  trim(s.tabtype || " ") atype
, "TableColumns" NODES_SQLCLASS_NAME
, "TableColumns" TEMPLATE_NAME
, CAST(("tabid = '" || s.tabid || "'") AS VARCHAR(100)) LOCAL_FILTER
, 0 Image_Index
from systables s
where tabtype <> "" and owner <> 'informix'
order by 1,2,3

##################################################
#INFORMIX.Tables.Columns

SELECT 
colname,
tabid,
colno,
collength as Length,
colmin,
colmax,
coltype-trunc(coltype/256)*256 as Type,

case when coltype-trunc(coltype/256)*256=0 then "CHAR"
     when coltype-trunc(coltype/256)*256=1 then "SMALLINT"
     when coltype-trunc(coltype/256)*256=2 then "INTEGER"
     when coltype-trunc(coltype/256)*256=3 then "FLOAT"
     when coltype-trunc(coltype/256)*256=4 then "SMALLFLOAT"
     when coltype-trunc(coltype/256)*256=5 then "DECIMAL"
     when coltype-trunc(coltype/256)*256=6 then "SERIAL*"
     when coltype-trunc(coltype/256)*256=7 then "DATE"
     when coltype-trunc(coltype/256)*256=8 then "MONEY"
     when coltype-trunc(coltype/256)*256=9 then "NULL"
     when coltype-trunc(coltype/256)*256=10 then "DATETIME"
     when coltype-trunc(coltype/256)*256=11 then "BYTE"
     when coltype-trunc(coltype/256)*256=12 then "TEXT"
     when coltype-trunc(coltype/256)*256=13 then "VARCHAR"
     when coltype-trunc(coltype/256)*256=14 then "INTERVAL"
     when coltype-trunc(coltype/256)*256=15 then "NCHAR"
     when coltype-trunc(coltype/256)*256=16 then "NVARCHAR"
     when coltype-trunc(coltype/256)*256=17 then "INT8"
     when coltype-trunc(coltype/256)*256=18 then "SERIAL8*"
     when coltype-trunc(coltype/256)*256=19 then "SET"
     when coltype-trunc(coltype/256)*256=20 then "MULTISET"
     when coltype-trunc(coltype/256)*256=21 then "LIST"
     when coltype-trunc(coltype/256)*256=22 then "ROW"
     when coltype-trunc(coltype/256)*256=23 then "COLLECTION"
     when coltype-trunc(coltype/256)*256=24 then "ROWREF"
     when coltype-trunc(coltype/256)*256=40 then "Variable-length opaque type"
     when coltype-trunc(coltype/256)*256=41 then "Fixed-length opaque type"
     when coltype-trunc(coltype/256)*256=4118 then "Named row"
end as TypeName
, trunc(coltype/256) as Null
, "" TEMPLATE_NAME
, case when trunc(coltype/256)=0 then "Yes" else "No" end as CanNull
, 1 Image_Index
FROM informix.syscolumns
order by tabid, colno

##################################################
#INFORMIX.Procedures
select
  trim(both from owner) || '.' || trim(both from procname) objname,
  case when s.owner = 'informix' then 1 else 0 end order1,
  trim(both from owner) owner,
  s.procname  name
, "ProceduresParameters" NODES_SQLCLASS_NAME
, "ProceduresParameters" TEMPLATE_NAME
, CAST(("") AS VARCHAR(100)) LOCAL_FILTER
, 3 Image_Index
from sysprocedures s
where owner <> 'informix'
order by 1,2,3

##################################################
#INFORMIX.Procedure.Body
select procid, datakey, seqno, data
from sysprocbody
where procid = 563
  and datakey = 'T'
order by seqno


##################################################
#INFORMIX.SysInfo.ServerItems
SELECT
 CAST("SysTables" AS VARCHAR(100)) OBJ_NAME,
 CAST("SysTables" AS VARCHAR(100)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("SysTableObjects" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype = 'T' and owner = 'informix'" AS VARCHAR(100)) LOCAL_FILTER,
 CAST("informix" AS VARCHAR(20)) aowner
, 0 Image_Index
FROM systables s 
WHERE tabtype = 'T' and owner = 'informix'     --Tables
UNION ALL
SELECT
 CAST("SysViews" AS VARCHAR(20)) OBJ_NAME,
 CAST("SysViews" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("SysTableObjects" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype = 'V' and owner = 'informix'" AS VARCHAR(100)) LOCAL_FILTER,
 CAST("informix" AS VARCHAR(20)) aowner
, 4 Image_Index
FROM systables s              --Views
WHERE tabtype = 'V' and owner = 'informix'
UNION ALL
SELECT
 CAST("SysSinonims" AS VARCHAR(20)) OBJ_NAME,
 CAST("SysSinonims" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("SysSinonims" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype IN ('P', 'S') and owner = 'informix'" AS VARCHAR(100)) LOCAL_FILTER,
 CAST("informix" AS VARCHAR(20)) aowner
, 4 Image_Index
FROM systables s              --Sinonims
WHERE tabtype IN ('P', 'S') and owner = 'informix'
UNION ALL
SELECT
 CAST("SysProcedures" AS VARCHAR(20)) OBJ_NAME,
 CAST("SysProcedures" AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST("SysProcedures" AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST("atype = 'PR' and owner = 'informix'" AS VARCHAR(100)) LOCAL_FILTER,
 CAST("informix" AS VARCHAR(20)) aowner
, 3 Image_Index
FROM systables s              --Synonyms
WHERE tabtype = 'PR' and owner = 'informix'


##################################################
#INFORMIX.SysTables
select
  trim(both from owner) || '.' || trim(both from tabname) objname,
  s.tabid,
  case when s.owner = 'informix' then 1 else 0 end order1,
  trim(both from owner) owner,
  s.tabname  name,
  trim(s.tabtype || " ") atype
, "TableColumns" NODES_SQLCLASS_NAME
, "TableColumns" TEMPLATE_NAME
, CAST(("tabid = '" || s.tabid || "'") AS VARCHAR(100)) LOCAL_FILTER
, 0 Image_Index
from systables s
where tabtype <> "" and owner = 'informix'
order by 1,2,3

##################################################
#INFORMIX.SysTables.Columns

SELECT 
colname,
tabid,
colno,
collength as Length,
colmin,
colmax,
coltype-trunc(coltype/256)*256 as Type,

case when coltype-trunc(coltype/256)*256=0 then "CHAR"
     when coltype-trunc(coltype/256)*256=1 then "SMALLINT"
     when coltype-trunc(coltype/256)*256=2 then "INTEGER"
     when coltype-trunc(coltype/256)*256=3 then "FLOAT"
     when coltype-trunc(coltype/256)*256=4 then "SMALLFLOAT"
     when coltype-trunc(coltype/256)*256=5 then "DECIMAL"
     when coltype-trunc(coltype/256)*256=6 then "SERIAL*"
     when coltype-trunc(coltype/256)*256=7 then "DATE"
     when coltype-trunc(coltype/256)*256=8 then "MONEY"
     when coltype-trunc(coltype/256)*256=9 then "NULL"
     when coltype-trunc(coltype/256)*256=10 then "DATETIME"
     when coltype-trunc(coltype/256)*256=11 then "BYTE"
     when coltype-trunc(coltype/256)*256=12 then "TEXT"
     when coltype-trunc(coltype/256)*256=13 then "VARCHAR"
     when coltype-trunc(coltype/256)*256=14 then "INTERVAL"
     when coltype-trunc(coltype/256)*256=15 then "NCHAR"
     when coltype-trunc(coltype/256)*256=16 then "NVARCHAR"
     when coltype-trunc(coltype/256)*256=17 then "INT8"
     when coltype-trunc(coltype/256)*256=18 then "SERIAL8*"
     when coltype-trunc(coltype/256)*256=19 then "SET"
     when coltype-trunc(coltype/256)*256=20 then "MULTISET"
     when coltype-trunc(coltype/256)*256=21 then "LIST"
     when coltype-trunc(coltype/256)*256=22 then "ROW"
     when coltype-trunc(coltype/256)*256=23 then "COLLECTION"
     when coltype-trunc(coltype/256)*256=24 then "ROWREF"
     when coltype-trunc(coltype/256)*256=40 then "Variable-length opaque type"
     when coltype-trunc(coltype/256)*256=41 then "Fixed-length opaque type"
     when coltype-trunc(coltype/256)*256=4118 then "Named row"
end as TypeName,
trunc(coltype/256) as Null,
"" TEMPLATE_NAME,
case when trunc(coltype/256)=0 then "Yes" else "No" end as CanNull
, 1 Image_Index
FROM informix.syscolumns
order by tabid, colno

##################################################
#INFORMIX.SysProcedures
select
  trim(both from owner) || '.' || trim(both from procname) objname,
  case when s.owner = 'informix' then 1 else 0 end order1,
  trim(both from owner) owner,
  s.procname  name
, "ProceduresParameters" NODES_SQLCLASS_NAME
, "ProceduresParameters" TEMPLATE_NAME
, CAST(("") AS VARCHAR(100)) LOCAL_FILTER
, 3 Image_Index
from sysprocedures s
where owner = 'informix'
order by 1,2,3

##################################################
#INFORMIX.Procedure.Body
select procid, datakey, seqno, data
from sysprocbody
where procid = 563
  and datakey = 'T'
order by seqno



##################################################
##################################################
##################################################     ORACLE     #############
##################################################
##################################################
#ORACLE.ServerItems
--Tables
SELECT
 CAST('Tables' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Tables' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST(' atype = ''T'' and owner <> ''SYS'' ' AS VARCHAR2(200) ) LOCAL_FILTER
 ,0 Image_Index
FROM SYS.ALL_TABLES A 
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')

-- Views
UNION ALL
SELECT
 CAST('Views' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Views' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST('atype = ''V'' and owner <> ''informix''' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM SYS.ALL_OBJECTS A  
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')
      AND (A.OBJECT_TYPE = 'VIEW')

-- Synonyms
UNION ALL
SELECT
 CAST('Synonyms' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Synonyms' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST('atype = ''V'' and owner <> ''SYS''' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM SYS.ALL_SYNONYMS A 
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')

--Snapshots
--Clusters
--TableSpaces

--Sequences
UNION ALL
SELECT
 CAST('Sequences' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Sequences' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('SequencesObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST(' ' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM SYS.ALL_SEQUENCES A 
WHERE A.SEQUENCE_OWNER NOT IN ('SYS', 'SYSTEM')

--Procedures
UNION ALL
SELECT
 CAST('Procedures' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Procedures' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST('atype = ''PR'' and owner <> ''informix''' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM
    SYS.ALL_OBJECTS A
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')
      AND (A.OBJECT_TYPE = 'PROCEDURE')

--Functions
UNION ALL
SELECT
 CAST('Functions' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Functions' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST('atype = ''PR'' and owner <> ''informix''' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM
    SYS.ALL_OBJECTS A
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')
      AND (A.OBJECT_TYPE = 'FUNCTION')
      
--Packages
UNION ALL
SELECT
 CAST('Packages' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Packages' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST('atype = ''PR'' and owner <> ''informix''' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM
    SYS.ALL_OBJECTS A
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')
    AND (A.OBJECT_TYPE = 'PACKAGE')      
      
--Packages Bodies
UNION ALL
SELECT
 CAST('Packages Bodies' AS VARCHAR2(20)) OBJ_NAME,
 CAST('Packages Bodies' AS VARCHAR2(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('TableObjects' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST('atype = ''PR'' and owner <> ''informix''' AS VARCHAR2(100)) LOCAL_FILTER
 ,0 Image_Index
FROM
    SYS.ALL_OBJECTS A
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')
   AND (A.OBJECT_TYPE = 'PACKAGE BODY')

--SysInfo
UNION ALL
SELECT
 'SysInfo' OBJ_NAME,
 'SysInfo' TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('SysInfo' AS VARCHAR2(20)) NODES_SQLCLASS_NAME,
 CAST(' ' AS VARCHAR2(100)) LOCAL_FILTER
, 0 Image_Index
FROM dual

##################################################
#ORACLE.Tables
SELECT
  A.OWNER
 ,A.TABLE_NAME
 ,DECODE(A.OWNER, USER, A.TABLE_NAME, A.OWNER || '.' || A.TABLE_NAME) VIS_TABLE_NAME
 ,DECODE(A.OWNER, USER, 1, 2) ORDER1
 ,A.OWNER || '.' || A.TABLE_NAME OWNER_TABLE_NAME
 ,'TableColumns' NODES_SQLCLASS_NAME
 ,'TableColumns' TEMPLATE_NAME
 ,T.COMMENTS DESCRIPTION
FROM SYS.ALL_TABLES A 
	,SYS.ALL_TAB_COMMENTS T
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')    
 AND A.OWNER = T.OWNER AND A.TABLE_NAME = T.TABLE_NAME
ORDER BY ORDER1, A.OWNER, A.TABLE_NAME

##################################################
#ORACLE.Tables.Columns
SELECT
 A.COLUMN_ID
, A.DATA_TYPE
, A.DATA_LENGTH
, A.DATA_PRECISION
, A.DATA_SCALE
, A.NULLABLE
, A.DATA_DEFAULT
, A.OWNER
, A.TABLE_NAME
, A.COLUMN_NAME
, A.DATA_TYPE_MOD
, A.DATA_TYPE_OWNER
, A.DEFAULT_LENGTH
, A.NUM_DISTINCT
, A.LOW_VALUE
, A.HIGH_VALUE
, A.DENSITY
, A.NUM_NULLS
, A.NUM_BUCKETS
, A.LAST_ANALYZED
, A.SAMPLE_SIZE
, A.CHARACTER_SET_NAME
, A.CHAR_COL_DECL_LENGTH
, A.GLOBAL_STATS
, A.USER_STATS
, A.AVG_COL_LEN
, A.OWNER
, A.OWNER || '.' || A.TABLE_NAME OWNER_TABLE_NAME
, A.OWNER || '.' || A.TABLE_NAME || '.' || A.COLUMN_ID ID
, ' ' NODES_SQLCLASS_NAME
, ' ' TEMPLATE_NAME
, 0 Image_Index
FROM
  SYS.ALL_TAB_COLUMNS A
WHERE 
  A.OWNER NOT IN ('SYS', 'SYSTEM')    
ORDER BY A.OWNER, A.TABLE_NAME, A.COLUMN_ID

##################################################
#ORACLE.Views
SELECT
  A.OWNER
 ,A.OBJECT_NAME
 ,A.OBJECT_TYPE
 ,DECODE(A.OWNER, USER, A.OBJECT_NAME, A.OWNER || '.' || A.OBJECT_NAME) VIS_OBJECT_NAME
 ,DECODE(A.OWNER, USER, 1, 2) ORDER1
 ,'TableColumns' NODES_SQLCLASS_NAME
 ,'TableColumns' TEMPLATE_NAME
 , A.OWNER || '.' || A.OBJECT_TYPE || '.' || A.OBJECT_NAME ID
 ,0 Image_Index
FROM SYS.ALL_OBJECTS A
WHERE A.OWNER NOT IN ('SYS', 'SYSTEM')
      AND (A.OBJECT_TYPE = 'VIEW')
ORDER BY ORDER1, A.OWNER, A.OBJECT_TYPE, A.OBJECT_NAME

##################################################
#ORACLE.Sequences
SELECT
  A.LAST_NUMBER
, A.INCREMENT_BY
, A.CYCLE_FLAG
, A.ORDER_FLAG
, A.MIN_VALUE
, A.MAX_VALUE
, A.CACHE_SIZE
, A.SEQUENCE_OWNER
, A.SEQUENCE_NAME
, A.SEQUENCE_OWNER || '.' || A.SEQUENCE_NAME ID
, DECODE(A.SEQUENCE_OWNER, USER, A.SEQUENCE_NAME, A.SEQUENCE_OWNER || '.' || A.SEQUENCE_NAME) VIS_SEQUENCE_NAME
, DECODE(A.SEQUENCE_OWNER, USER, 1, 2) ORDER1
, ' ' NODES_SQLCLASS_NAME
, ' ' TEMPLATE_NAME
, 0 Image_Index
FROM
  SYS.ALL_SEQUENCES A
WHERE A.SEQUENCE_OWNER NOT IN ('SYS', 'SYSTEM')
ORDER BY ORDER1, A.SEQUENCE_OWNER, A.SEQUENCE_NAME



##################################################
##################################################
##################################################     MSAccess     #############
##################################################
##################################################
#MSAccess.ServerItems
 SELECT
 "Tables" As OBJ_NAME,
 "Tables" As TEMPLATE_NAME,
 count(*) As SUB_OBJ_NAME,
 "TableObjects" As NODES_SQLCLASS_NAME,
 "" As LOCAL_FILTER
FROM MSysObjects s
WHERE type = 1

##################################################
#MSAccess.Tables
select
  Name As objname,
  type As tabid 
, "TableColumns" As NODES_SQLCLASS_NAME
, "TableColumns" As TEMPLATE_NAME
, "" As LOCAL_FILTER
from MSysObjects s
where type = 1
order by 1,2



##################################################
##################################################
##################################################     Interbase     #############
##################################################
##################################################
#Interbase.ServerItems
SELECT
 CAST('Tables' AS VARCHAR(20)) OBJ_NAME,
 CAST('Tables' AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('Tables' AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST('[RDB$VIEW_SOURCE] IS NULL' AS VARCHAR(100)) LOCAL_FILTER
 ,0 Image_Index
FROM RDB$RELATIONS
UNION ALL
SELECT
 CAST('Views' AS VARCHAR(20)) OBJ_NAME,
 CAST('Views' AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('Views' AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST('[RDB$VIEW_SOURCE] IS NOT NULL' AS VARCHAR(100)) LOCAL_FILTER
 ,4 Image_Index
FROM RDB$RELATIONS
UNION ALL
SELECT
 CAST('Procedures' AS VARCHAR(20)) OBJ_NAME,
 CAST('Procedures' AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('Procedures' AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST(' ' AS VARCHAR(100)) LOCAL_FILTER
 ,3 Image_Index
FROM RDB$PROCEDURES
UNION ALL
SELECT
 CAST('Functions' AS VARCHAR(20)) OBJ_NAME,
 CAST('Functions' AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('Functions' AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST(' ' AS VARCHAR(100)) LOCAL_FILTER
 ,3 Image_Index
FROM RDB$FUNCTIONS
UNION ALL
SELECT
 CAST('Generators' AS VARCHAR(20)) OBJ_NAME,
 CAST('Generators' AS VARCHAR(20)) TEMPLATE_NAME,
 count(*) SUB_OBJ_NAME,
 CAST('Generators' AS VARCHAR(20)) NODES_SQLCLASS_NAME,
 CAST(' ' AS VARCHAR(100)) LOCAL_FILTER
 ,0 Image_Index
FROM RDB$GENERATORS

##################################################
#Interbase.Tables.Views
SELECT
  A.RDB$RELATION_NAME Name
, A.RDB$RELATION_NAME tabid
, A.RDB$DESCRIPTION Description
, A.RDB$RELATION_ID tabid
, A.RDB$OWNER_NAME
, A.RDB$VIEW_BLR
, A.RDB$VIEW_SOURCE
, A.RDB$SYSTEM_FLAG
, A.RDB$DBKEY_LENGTH
, A.RDB$FORMAT
, A.RDB$FIELD_ID
, A.RDB$SECURITY_CLASS
, A.RDB$EXTERNAL_FILE
, A.RDB$RUNTIME
, A.RDB$EXTERNAL_DESCRIPTION
, A.RDB$DEFAULT_CLASS
, A.RDB$FLAGS
, 'TableColumns' NODES_SQLCLASS_NAME
, 'TableColumns' TEMPLATE_NAME
, CAST(('tabid = ''' || A.RDB$RELATION_NAME || '''') AS VARCHAR(100)) LOCAL_FILTER
, 0 Image_Index
FROM
RDB$RELATIONS A
WHERE (A.RDB$SYSTEM_FLAG <> 1 or A.RDB$SYSTEM_FLAG IS NULL)
ORDER BY A.RDB$RELATION_NAME

##################################################
#Interbase.TableColumns
SELECT
  A.RDB$FIELD_NAME     colname
, A.RDB$FIELD_POSITION colno
, A.RDB$RELATION_NAME  tabid
, B.RDB$FIELD_LENGTH   ColLen
, B.RDB$FIELD_TYPE
, B.RDB$FIELD_SUB_TYPE
, B.RDB$FIELD_SCALE
, A.RDB$DEFAULT_SOURCE
, A.RDB$NULL_FLAG
, A.RDB$FIELD_SOURCE
, A.RDB$QUERY_NAME
, A.RDB$BASE_FIELD
, A.RDB$EDIT_STRING
, A.RDB$QUERY_HEADER
, A.RDB$UPDATE_FLAG
, A.RDB$FIELD_ID
, A.RDB$VIEW_CONTEXT
, A.RDB$DESCRIPTION
, A.RDB$DEFAULT_VALUE
, A.RDB$SYSTEM_FLAG
, A.RDB$SECURITY_CLASS
, A.RDB$COMPLEX_NAME
, A.RDB$COLLATION_ID
, 'TableColumnsProps' TEMPLATE_NAME
, 1 Image_Index
FROM
  RDB$RELATION_FIELDS A
 ,RDB$FIELDS B
WHERE
  A.RDB$FIELD_SOURCE = B.RDB$FIELD_NAME
ORDER BY A.RDB$RELATION_NAME, A.RDB$FIELD_POSITION

##################################################
#Interbase.Procedures
SELECT
  A.RDB$PROCEDURE_NAME
, A.RDB$OWNER_NAME
, A.RDB$DESCRIPTION
, A.RDB$PROCEDURE_SOURCE
, A.RDB$SYSTEM_FLAG
, 'ProcedureParameters' TEMPLATE_NAME
, 3 Image_Index
FROM
RDB$PROCEDURES A
WHERE (A.RDB$SYSTEM_FLAG <> 1 or A.RDB$SYSTEM_FLAG IS NULL)

##################################################
#Interbase.ProcedureParameters
SELECT
  A.RDB$PARAMETER_NAME
, A.RDB$PARAMETER_NUMBER
, A.RDB$PARAMETER_TYPE
, A.RDB$PROCEDURE_NAME
, A.RDB$FIELD_SOURCE
, A.RDB$DESCRIPTION
, A.RDB$SYSTEM_FLAG
, B.RDB$FIELD_TYPE
, B.RDB$FIELD_SUB_TYPE
, B.RDB$FIELD_LENGTH
, B.RDB$FIELD_SCALE
, ' ' TEMPLATE_NAME
, 1 Image_Index
FROM
RDB$PROCEDURE_PARAMETERS A
, RDB$FIELDS B
WHERE A.RDB$FIELD_SOURCE = B.RDB$FIELD_NAME

##################################################
#Interbase.Functions
SELECT
A.RDB$MODULE_NAME
, A.RDB$ENTRYPOINT
, A.RDB$QUERY_NAME
, A.RDB$DESCRIPTION
, A.RDB$FUNCTION_NAME
, A.RDB$FUNCTION_TYPE
, A.RDB$RETURN_ARGUMENT
, A.RDB$SYSTEM_FLAG
, 'FunctionParameters' TEMPLATE_NAME
, 3 Image_Index
FROM
RDB$FUNCTIONS A
WHERE (A.RDB$SYSTEM_FLAG <> 1 or A.RDB$SYSTEM_FLAG IS NULL)

##################################################
#Interbase.FunctionParameters
SELECT
  A.RDB$ARGUMENT_POSITION
, A.RDB$FIELD_TYPE
, A.RDB$FIELD_SUB_TYPE
, A.RDB$FIELD_LENGTH
, A.RDB$FIELD_SCALE
, A.RDB$FUNCTION_NAME
, A.RDB$MECHANISM
, A.RDB$CHARACTER_SET_ID
, ' ' TEMPLATE_NAME
, 1 Image_Index
FROM
RDB$FUNCTION_ARGUMENTS A
WHERE 1=1/*(A.RDB$ARGUMENT_POSITION <> 0)*/

##################################################
#Interbase.Generators
SELECT
  A.RDB$GENERATOR_NAME
, A.RDB$GENERATOR_ID
, A.RDB$SYSTEM_FLAG
, ' ' TEMPLATE_NAME
, 0 Image_Index
FROM
RDB$GENERATORS A
WHERE (A.RDB$SYSTEM_FLAG <> 1 or A.RDB$SYSTEM_FLAG IS NULL)



##################################################
##################################################
##################################################     MSSQL    ###########
##################################################
##################################################
#MSSQL.ServerItems

--Tables
SELECT
 CAST('Tables' AS nvarchar) OBJ_NAME
 ,CAST('Tables' AS nvarchar) TEMPLATE_NAME
 ,count(*) SUB_OBJ_NAME
 ,CAST('TableObjects' AS nvarchar) NODES_SQLCLASS_NAME
 ,CAST('' AS nvarchar ) LOCAL_FILTER
 ,0 Image_Index
FROM INFORMATION_SCHEMA.TABLES  
WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA'

-- Views
UNION ALL
SELECT
 CAST('Views' AS nvarchar) OBJ_NAME
 ,CAST('Views' AS nvarchar) TEMPLATE_NAME
 ,count(*) SUB_OBJ_NAME
 ,CAST('ViewsObjects' AS nvarchar) NODES_SQLCLASS_NAME
 ,CAST('' AS nvarchar) LOCAL_FILTER
 ,4 Image_Index
FROM INFORMATION_SCHEMA.VIEWS 
WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA'

--Procedures
UNION ALL
SELECT
   CAST('Procedures' AS nvarchar) OBJ_NAME
 , CAST('Procedures' AS nvarchar) TEMPLATE_NAME
 , count(*) SUB_OBJ_NAME
 , CAST('RoutinesObjects' AS nvarchar) NODES_SQLCLASS_NAME
 , CAST('ROUTINE_TYPE = ''PROCEDURE'' ' AS nvarchar) LOCAL_FILTER
 ,3 Image_Index
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA not in ('INFORMATION_SCHEMA',  'system_function_schema')
  AND ROUTINE_TYPE = 'PROCEDURE'

--Functions
UNION ALL
SELECT
 CAST('Functions' AS nvarchar) OBJ_NAME
 ,CAST('Functions' AS nvarchar) TEMPLATE_NAME
 ,count(*) SUB_OBJ_NAME
 ,CAST('TableObjects' AS nvarchar) NODES_SQLCLASS_NAME
 ,CAST('ROUTINE_TYPE = ''FUNCTION'' ' AS nvarchar) LOCAL_FILTER
 ,3 Image_Index
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_SCHEMA not in ('INFORMATION_SCHEMA',  'system_function_schema')
  AND ROUTINE_TYPE = 'FUNCTION'

--SysInfo
UNION ALL
SELECT
 'SysInfo' OBJ_NAME
 ,'SysInfo' TEMPLATE_NAME
 ,count(*) SUB_OBJ_NAME
 ,CAST('SysInfo' AS nvarchar) NODES_SQLCLASS_NAME
 ,CAST(' ' AS nvarchar) LOCAL_FILTER
 ,0 Image_Index


##################################################
#MSSQL.Tables

SELECT 
  TABLE_CATALOG	
, TABLE_SCHEMA	
, TABLE_NAME
, TABLE_TYPE
, 'TableColumns' TEMPLATE_NAME
, CAST('TABLE_NAME = ''' + TABLE_NAME + ''' ' AS nvarchar) LOCAL_FILTER
, 0 Image_Index
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA'


##################################################
#MSSQL.Views

SELECT
  TABLE_CATALOG	
, TABLE_SCHEMA	
, TABLE_NAME
, 'TableColumns' TEMPLATE_NAME
, CAST('TABLE_NAME = ''' + TABLE_NAME + ''' ' AS nvarchar) LOCAL_FILTER
, 4 Image_Index
FROM INFORMATION_SCHEMA.VIEWS 
WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA'

##################################################
#MSSQL.Columns

SELECT
  TABLE_CATALOG
, TABLE_SCHEMA	
, TABLE_NAME
, COLUMN_NAME	
, ORDINAL_POSITION
, COLUMN_DEFAULT	
, IS_NULLABLE	
, DATA_TYPE
, CHARACTER_MAXIMUM_LENGTH	
, CHARACTER_OCTET_LENGTH	
, NUMERIC_PRECISION	
, NUMERIC_PRECISION_RADIX	
, NUMERIC_SCALE	
, DATETIME_PRECISION	
, COLUMN_NAME + '.' + TABLE_NAME ID
, 'ViewColumnsProps' TEMPLATE_NAME
, 4 Image_Index
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA <> 'INFORMATION_SCHEMA'
ORDER BY TABLE_NAME, ORDINAL_POSITION



##################################################
#MSSQL.Procedures

SELECT 
   ROUTINE_NAME
,  SPECIFIC_SCHEMA
, 'Parameters' TEMPLATE_NAME
,3 Image_Index
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA not in ('INFORMATION_SCHEMA',  'system_function_schema')
  AND ROUTINE_TYPE = 'PROCEDURE'


##################################################
#MSSQL.Functions

SELECT 
   ROUTINE_NAME
,  SPECIFIC_SCHEMA
, 'Parameters' TEMPLATE_NAME
,3 Image_Index
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA not in ('INFORMATION_SCHEMA',  'system_function_schema')
  AND ROUTINE_TYPE = 'FUNCTION'


##################################################
#MSSQL.Parameters

SELECT
  SPECIFIC_CATALOG
, SPECIFIC_SCHEMA
, SPECIFIC_NAME
, PARAMETER_NAME
, DATA_TYPE
, IS_RESULT
, CHARACTER_MAXIMUM_LENGTH	
, CHARACTER_OCTET_LENGTH	
, NUMERIC_PRECISION	
, NUMERIC_PRECISION_RADIX	
, NUMERIC_SCALE
, DATETIME_PRECISION
, ORDINAL_POSITION
, PARAMETER_NAME + '.' + SPECIFIC_NAME ID
, 'ParametersProps' TEMPLATE_NAME
, 4 Image_Index
FROM INFORMATION_SCHEMA.PARAMETERS 
WHERE SPECIFIC_SCHEMA not in ('INFORMATION_SCHEMA',  'system_function_schema')
ORDER BY SPECIFIC_NAME, ORDINAL_POSITION