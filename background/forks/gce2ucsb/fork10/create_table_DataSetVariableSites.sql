-- Table: metabase2."DataSetEntitySites"

-- DROP TABLE metabase2."DataSetVariableSites";

CREATE TABLE metabase2."DataSetVariableSites"
(
  "DataSetID" integer NOT NULL,
  "EntitySortOrder" integer NOT NULL,
  "ColumnPosition" integer NOT NULL,
  "SiteCode" character varying(50) NOT NULL,
  "GeoCoverageSortOrder" integer NOT NULL DEFAULT 1,
  "IsRef" boolean, -- true if a reference should be used rather than a tree. The id of the reference is the SiteCode.
  CONSTRAINT "PK_DataSetVariableSites" PRIMARY KEY ("DataSetID", "EntitySortOrder", "ColumnPosition","SiteCode"),
  CONSTRAINT "FK_DataSetVariableSites_DataSetVariables2" FOREIGN KEY ("DataSetID", "EntitySortOrder","ColumnPosition")
      REFERENCES metabase2."DataSetVariables2" ("DataSetID", "EntitySortOrder","ColumnPosition") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_DataSetVariableSites_SuperSite" FOREIGN KEY ("SiteCode")
      REFERENCES metabase2."SuperSite" ("SiteCode") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "UQ_DataSetVariableSites" UNIQUE ("DataSetID", "EntitySortOrder", "ColumnPosition","GeoCoverageSortOrder")
);
COMMENT ON COLUMN metabase2."DataSetVariableSites"."IsRef" IS 'true if a reference should be used rather than a tree. The id of the reference is the SiteCode.';


