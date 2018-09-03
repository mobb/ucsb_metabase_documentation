
CREATE TABLE metabase2."MeasurementScaleDomains"
(
  "EMLDomainType" character varying(17) NOT NULL,
  "MeasurementScale" character varying(8) NOT NULL,
  "NonNumericDomain" character varying(17),
  "MeasurementScaleDomainID" character varying(12) NOT NULL,
  CONSTRAINT "pk_MeasurementScaleDomains" PRIMARY KEY ("MeasurementScaleDomainID"),
  CONSTRAINT "MeasurementScaleDomains_FK_MeasurementScale" FOREIGN KEY ("MeasurementScale")
      REFERENCES metabase2."EMLMeasurementScaleList" ("measurementScale") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE metabase2."MeasurementScaleDomains"
  OWNER TO gastil;

-- Index: metabase2."fki_MeasurementScaleDomains_FK_MeasurementScale"

-- DROP INDEX metabase2."fki_MeasurementScaleDomains_FK_MeasurementScale";

CREATE INDEX "fki_MeasurementScaleDomains_FK_MeasurementScale"
  ON metabase2."MeasurementScaleDomains"
  USING btree
  ("MeasurementScale" COLLATE pg_catalog."default");


