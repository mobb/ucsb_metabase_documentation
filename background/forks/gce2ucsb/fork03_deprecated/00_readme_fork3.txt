Fork 3:

THIS DIR DEPRECATED.
SEE FORK 7 FOR ALL MATERIAL RELATED TO DATASETENTITIES.





we added a column to the DataSetEntities table.

ALTER TABLE metabase2."DataSetEntities"
  ADD COLUMN "SortOrder" integer;
	COMMENT ON COLUMN metabase2."DataSetEntities"."SortOrder"
	IS 'The order the data entity appears in the dataset.';
