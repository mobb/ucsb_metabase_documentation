CREATE TABLE metabase2."DataSetEntitySites"
(
  "DataSetID" integer NOT NULL,
  "EntitySortOrder" integer NOT NULL,
  "SiteCode" character varying(50) NOT NULL,
  "GeoCoverageSortOrder" integer NOT NULL DEFAULT 1,
  CONSTRAINT "PK_DataSetEntitySites" PRIMARY KEY ("DataSetID", "EntitySortOrder","SiteCode"),
  CONSTRAINT "FK_DataSetEntitySites_DataSetEntities" FOREIGN KEY ("DataSetID","EntitySortOrder")
      REFERENCES metabase2."DataSetEntities" ("DataSetID","SortOrder") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_DataSetEntitySites_SuperSite" FOREIGN KEY ("SiteCode")
      REFERENCES metabase2."SuperSite" ("SiteCode") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
;
ALTER TABLE metabase2."DataSetEntitySites"
  ADD CONSTRAINT "UQ_DataSetEntitySites" UNIQUE ("DataSetID", "EntitySortOrder", "GeoCoverageSortOrder");

ALTER TABLE metabase2."DataSetEntitySites"
   ADD COLUMN "IsRef" boolean;
COMMENT ON COLUMN metabase2."DataSetEntitySites"."IsRef"
  IS 'true if a reference should be used rather than a tree. The id of the reference is the SiteCode.';

