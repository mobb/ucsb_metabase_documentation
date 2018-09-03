ALTER TABLE metabase2."DataSetSites"
   ADD COLUMN "EntitySortOrder" integer NOT NULL;
   ADD COLUMN "ColumnPosition" integer NOT NULL; --attribute
   ADD COLUMN "GeoCoverageSortOrder" integer NOT NULL;
;
