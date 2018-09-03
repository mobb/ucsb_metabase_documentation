
CREATE TABLE metabase2."DataSetVariables2"
(
  "DataSetID" integer NOT NULL,
  "EntitySortOrder" integer NOT NULL,
  "ColumnPosition" smallint NOT NULL,
  "AttributeID" character varying(100),
  "AttributeName" character varying(200) NOT NULL,
  "AttributeLabel" character varying(200) NOT NULL,
  "Description" character varying(2000) DEFAULT 'none'::character varying,
  "StorageType" character varying(30),
  "MeasurementScaleDomainID" character varying(12),
  "FormatString" character varying(40),
  "PrecisionDateTime" character varying(40),
  "Enumeration_xml" xml,
  "TextPatternDefinition" character varying(100),
  "Unit" character varying(100),
  "PrecisionNumeric" double precision,
  "NumberType" character varying(30),
  "Bounds_xml" xml,
  "MissingValueCode_xml" xml,
  CONSTRAINT pk_datasetvariables2_pk PRIMARY KEY ("DataSetID", "EntitySortOrder", "ColumnPosition"),
  CONSTRAINT "DataSetVariables2_FK_DataSetID_EntitySortOrder" FOREIGN KEY ("DataSetID", "EntitySortOrder")
      REFERENCES metabase2."DataSetEntities" ("DataSetID", "SortOrder") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "DataSetVariables2_FK_NumberType" FOREIGN KEY ("NumberType")
      REFERENCES metabase2."EMLNumberTypeList" ("NumberType") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "DataSetVariables2_FK_units" FOREIGN KEY ("Unit")
      REFERENCES metabase2."EMLUnitDictionary" (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "DataSetVariables2_UQ_AttributeID" UNIQUE ("DataSetID", "AttributeID"),
  CONSTRAINT "DataSetVariables2_UQ_AttributeName" UNIQUE ("DataSetID", "EntitySortOrder", "AttributeName"),
  CONSTRAINT "DataSetVariables2_CK_Enumeration_xml" CHECK ("Enumeration_xml" IS NULL AND "MeasurementScaleDomainID"::text !~~ '%Enum'::text OR "Enumeration_xml" IS NOT NULL AND "MeasurementScaleDomainID"::text ~~ '%Enum'::text),
  CONSTRAINT "DataSetVariables2_CK_FormatString" CHECK ("FormatString" IS NULL AND "MeasurementScaleDomainID"::text !~~ 'dateTime'::text OR "FormatString" IS NOT NULL AND "MeasurementScaleDomainID"::text ~~ 'dateTime'::text), -- null if MeasurementScaleDomainID not dateTime otherwise not null
  CONSTRAINT "DataSetVariables2_CK_NumberType" CHECK ("NumberType" IS NULL AND ("MeasurementScaleDomainID"::text <> ALL (ARRAY['ratio'::text, 'interval'::text])) OR "NumberType" IS NOT NULL AND ("MeasurementScaleDomainID"::text = ANY (ARRAY['ratio'::text, 'interval'::text]))),
  CONSTRAINT "DataSetVariables2_CK_PrecisionDateTime" CHECK ("PrecisionDateTime" IS NULL AND "MeasurementScaleDomainID"::text !~~ 'dateTime'::text OR "PrecisionDateTime" IS NOT NULL AND "MeasurementScaleDomainID"::text ~~ 'dateTime'::text),
  CONSTRAINT "DataSetVariables2_CK_PrecisionNumeric" CHECK ("PrecisionNumeric" IS NULL AND ("MeasurementScaleDomainID"::text <> ALL (ARRAY['ratio'::text, 'interval'::text])) OR "PrecisionNumeric" IS NOT NULL AND ("MeasurementScaleDomainID"::text = ANY (ARRAY['ratio'::text, 'interval'::text]))),
  CONSTRAINT "DataSetVariables2_CK_TextPatternDefinition" CHECK ("TextPatternDefinition" IS NULL AND "MeasurementScaleDomainID"::text !~~ '%Text'::text OR "TextPatternDefinition" IS NOT NULL AND "MeasurementScaleDomainID"::text ~~ '%Text'::text),
  CONSTRAINT "DataSetVariables2_CK_unit" CHECK ("Unit" IS NULL AND ("MeasurementScaleDomainID"::text <> ALL (ARRAY['ratio'::text, 'interval'::text])) OR "Unit" IS NOT NULL AND ("MeasurementScaleDomainID"::text = ANY (ARRAY['ratio'::text, 'interval'::text])))
)
WITH (
  OIDS=FALSE
);
ALTER TABLE metabase2."DataSetVariables2"
  OWNER TO gastil;
COMMENT ON CONSTRAINT "DataSetVariables2_CK_FormatString" ON metabase2."DataSetVariables2" IS 'null if MeasurementScaleDomainID not dateTime otherwise not null';


-- Index: metabase2."fki_DataSetVariables2_FK_NumberType"

-- DROP INDEX metabase2."fki_DataSetVariables2_FK_NumberType";

CREATE INDEX "fki_DataSetVariables2_FK_NumberType"
  ON metabase2."DataSetVariables2"
  USING btree
  ("NumberType" COLLATE pg_catalog."default");

-- Index: metabase2."fki_DataSetVariables2_FK_units"

-- DROP INDEX metabase2."fki_DataSetVariables2_FK_units";

CREATE INDEX "fki_DataSetVariables2_FK_units"
  ON metabase2."DataSetVariables2"
  USING btree
  ("Unit" COLLATE pg_catalog."default");


