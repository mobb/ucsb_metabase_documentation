-- Table: metabase2."SiteAltitude"

-- DROP TABLE metabase2."SiteAltitude";

CREATE TABLE metabase2."SiteAltitude"
(
  "SiteCode" character varying(50) NOT NULL,
  "AltitudeMin" double precision NOT NULL,
  "AltitudeMax" double precision NOT NULL,
  "Unit" character varying(10),
  CONSTRAINT "SiteAltitude_pkey" PRIMARY KEY ("SiteCode")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE metabase2."SiteAltitude"
  OWNER TO mob;
