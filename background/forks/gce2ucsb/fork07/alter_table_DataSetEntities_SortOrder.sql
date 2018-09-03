ALTER TABLE metabase2."DataSetEntities"
  ADD COLUMN "SortOrder" integer;
	COMMENT ON COLUMN metabase2."DataSetEntities"."SortOrder"
	IS 'The order the data entity appears in the dataset.';
