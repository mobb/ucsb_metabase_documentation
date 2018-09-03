-- 1. NEW TABLE: metabase2."DataSetTypes"

-- DROP TABLE metabase2."DataSetTypes";

CREATE TABLE metabase2."DataSetTypes"
(
  "DataSetType" character varying(20) NOT NULL, -- A short key not for display
  "Name" character varying(50) NOT NULL, -- A label for display
  "Definition" character varying(300),
  "Notes" character varying(300),
  CONSTRAINT "PK_DataSetType" PRIMARY KEY ("DataSetType")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE metabase2."DataSetTypes"
  OWNER TO mob;
COMMENT ON COLUMN metabase2."DataSetTypes"."DataSetType" IS 'A short key not for display';
COMMENT ON COLUMN metabase2."DataSetTypes"."Name" IS 'A label for display';





-- 2. ALTER TABLE: metabase2.DataSet

ALTER TABLE metabase2."DataSet" RENAME "StudyType"  TO "DataSetType";
-- drop old fk

ALTER TABLE ONLY metabase2."DataSet"
  ADD CONSTRAINT "FK_DataSet_DataSetType" FOREIGN KEY ("DataSetType") REFERENCES metabase2."DataSetTypes"("DataSetType") ON UPDATE CASCADE;

~
-- 3. Table: metabase2."ProjectsDatasets"

-- DROP TABLE metabase2."ProjectsDatasets";

CREATE TABLE metabase2."ProjectsDatasets"
(
  "ProjectCode" character varying(20) NOT NULL,
  "DataSetID" integer NOT NULL,
  CONSTRAINT "PK_ProjectDatasets" PRIMARY KEY ("ProjectCode", "DataSetID"),
  CONSTRAINT "FK_ProjectsDatasets_Dataset" FOREIGN KEY ("DataSetID")
      REFERENCES metabase2."DataSet" ("DataSetID") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "FK_ProjectsDatasets_Project" FOREIGN KEY ("ProjectCode")
      REFERENCES metabase2."Projects" ("ProjectCode") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE metabase2."ProjectsDatasets"
  OWNER TO gastil;
