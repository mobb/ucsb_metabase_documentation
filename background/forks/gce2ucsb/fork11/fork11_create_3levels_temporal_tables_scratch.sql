CREATE TABLE scratch."DataSetEntityTemporal"
(
  "DataSetID" integer NOT NULL,
  "EntitySortOrder" integer NOT NULL,
  "TemporalCoverageID" character varying(50) NOT NULL,
  "TemporalCoverageSortOrder" integer NOT NULL DEFAULT 1,
  "BeginDate" date NOT NULL,
  "EndDate" date NOT NULL,
  "UseOnlyYear" boolean, -- When true, put only the YYYY in the EML, ignoring the -MM-DD part of the dates both begin and end.
  CONSTRAINT "PK_DataSetEntityTemporal" PRIMARY KEY ("DataSetID", "EntitySortOrder", "BeginDate"),
  CONSTRAINT "FK_DataSetEntityTemporal_DataSetEntities" FOREIGN KEY ("DataSetID", "EntitySortOrder")
      REFERENCES metabase2."DataSetEntities" ("DataSetID", "SortOrder") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE TABLE scratch."DataSetTemporal"
(
  "DataSetID" integer NOT NULL,
  "TemporalCoverageID" character varying(50) NOT NULL,
  "TemporalCoverageSortOrder" integer NOT NULL DEFAULT 1,
  "BeginDate" date NOT NULL,
  "EndDate" date NOT NULL,
  "UseOnlyYear" boolean, -- When true, put only the YYYY in the EML, ignoring the -MM-DD part of the dates both begin and end.
  CONSTRAINT "PK_DataSetTemporal" PRIMARY KEY ("DataSetID", "BeginDate"),
  CONSTRAINT "FK_DataSetTemporal_DataSet" FOREIGN KEY ("DataSetID")
      REFERENCES metabase2."DataSet" ("DataSetID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE TABLE scratch."DataSetVariableTemporal"
(
  "DataSetID" integer NOT NULL,
  "EntitySortOrder" integer NOT NULL,
  "ColumnPosition" integer NOT NULL,
  "TemporalCoverageID" character varying(50) NOT NULL,
  "TemporalCoverageSortOrder" integer NOT NULL DEFAULT 1,
  "BeginDate" date NOT NULL,
  "EndDate" date NOT NULL,
  "UseOnlyYear" boolean, -- When true, put only the YYYY in the EML, ignoring the -MM-DD part of the dates both begin and end.
  CONSTRAINT "PK_DataSetVariableTemporal" PRIMARY KEY ("DataSetID", "EntitySortOrder", "ColumnPosition", "BeginDate"),
  CONSTRAINT "FK_DataSetVariableTemporal_DataSetEntities" FOREIGN KEY ("DataSetID", "EntitySortOrder", "ColumnPosition")
      REFERENCES metabase2."DataSetVariables2" ("DataSetID", "EntitySortOrder", "ColumnPosition") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
);
