ALTER TABLE metabase2."SuperSite"
   ADD COLUMN "ShapeType" character varying(20) NOT NULL;

ALTER TABLE metabase2."SuperSite"
  ADD CONSTRAINT "CK_SuperSite_ShapeType"
  CHECK ("ShapeType" in ('point','rectangle','polygon','polyline','vector'));

