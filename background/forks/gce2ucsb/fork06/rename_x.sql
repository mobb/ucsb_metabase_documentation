ALTER DATABASE sbc_metabase RENAME TO sbc_metabase_x;
CREATE DATABASE sbc_metabase;
psql -U gastil -h rdb2 sbc_metabase < sbc.sql

ALTER DATABASE mcr_metabase RENAME TO mcr_metabase_x;
CREATE DATABASE mcr_metabase;
psql -U gastil -h rdb2 mcr_metabase < mcr.sql
