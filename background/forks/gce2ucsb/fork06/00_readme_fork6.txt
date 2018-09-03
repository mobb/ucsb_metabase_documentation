Fork 6.

Date: 2013-06-28
backward compatible? yes
essential? yes

Approach:
full backup
use sed to edit sql
drop and reload both databases

Goal:
increase the width of these fields:
EntityName (in tables below) from varchar 50 to varchar 100
FileName "
DataSet.Abstract (5000)

EntityName is refernced in these tables:
ALTER TABLE ONLY "DataSetEntityMethodSteps"
ALTER TABLE ONLY "DataSetEntityMethods"
ALTER TABLE ONLY "DataSetFileHist"
ALTER TABLE ONLY "DataSetFile"
ALTER TABLE ONLY "DataSetVariables"
ALTER TABLE ONLY "MetaDataFile"
ALTER TABLE ONLY "MetaDataFile"

FileNome is referenced in these:
ALTER TABLE ONLY "DataSetFileHist"
ALTER TABLE ONLY "MetaDataFile"


Approach:
full backup
use sed to edit sql
drop and reload both databases


The  sed:
cat sbc.sql | sed 's/"EntityName" character varying.50./"EntityName" character varying(100)/' | sed 's/"FileName" character varying.50./"FileName" character varying(100)/' > goo

then run the sql rename_x.sql:
ALTER DATABASE sbc_metabase RENAME TO sbc_metabase_x;
CREATE DATABASE sbc_metabase;
psql -U gastil -h rdb2 sbc_metabase < sbc.sql

ALTER DATABASE mcr_metabase RENAME TO mcr_metabase_x;
CREATE DATABASE mcr_metabase;
psql -U gastil -h rdb2 mcr_metabase < mcr.sql



