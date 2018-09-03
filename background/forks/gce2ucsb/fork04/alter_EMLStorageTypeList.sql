ALTER TABLE metabase2."EMLStorageTypeList" ADD COLUMN "typeSystem" character varying(200);
COMMENT ON COLUMN metabase2."EMLStorageTypeList"."typeSystem" IS 'include the entire url if it is a url';

