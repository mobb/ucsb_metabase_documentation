-- these statements executed  2013 sept 11
--------------------------------------------------------------------

CREATE TABLE metabase2."SubPathList"
(
  "SubPath" character varying(100) NOT NULL, -- no leading slash but trailing slash required or else an empty string.
  note character varying(500), -- Purpose of sub path, if deprecated or superseeded
  CONSTRAINT "pk_SubPathList" PRIMARY KEY ("SubPath"),
  CONSTRAINT "ck_SubPathList_slash" CHECK ("SubPath"::text ~~ '%/'::text AND "SubPath"::text !~~ '/%'::text OR "SubPath"::text = ''::text)
)
WITH (
  OIDS=FALSE
);
COMMENT ON TABLE metabase2."SubPathList"
  IS 'controlled vocabulary for sub paths ';
COMMENT ON COLUMN metabase2."SubPathList"."SubPath" IS 'no leading slash but trailing slash required or else an empty string.';
COMMENT ON COLUMN metabase2."SubPathList".note IS 'Purpose of sub path, if deprecated or superseeded';

--------------------------------------------------------------------

-- DataSetFile
--------------------------------------------------------------------

-- add a column so that we can construct a URL-dir from two parts (head and sub path). 
ALTER TABLE metabase2."DataSetFile" ADD COLUMN "SubPath" character varying(100);
COMMENT ON COLUMN metabase2."DataSetFile"."SubPath" IS 'the middle part of the path. Can be empty string.';

ALTER TABLE metabase2."DataSetFile"
  ADD CONSTRAINT "FK_DataSetFile_SubPath" FOREIGN KEY ("SubPath")
      REFERENCES metabase2."SubPathList" ("SubPath") MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE NO ACTION;

-- add a column for an element that is 1:1 with entity distribution
ALTER TABLE metabase2."DataSetFile"
   ADD COLUMN "OnlineDescription" character varying(500);

-- sbc and mcr will have some packages with offline or inline data.
-- if offline, this element is required. see other docs for our usage guidelines. 
ALTER TABLE metabase2."DataSetFile"
   ADD COLUMN "OfflineMediumName" character varying(500);

ALTER TABLE metabase2."DataSetFile"
  ADD CONSTRAINT "CK_DataSetFile"
  CHECK (("PathCode" like 'offline' AND "OfflineMediumName" is not null)
        OR ("PathCode" not like 'offline'));

-- this constraint reflects that we intend to have only one filename per entityname.
ALTER TABLE metabase2."DataSetFile"
  ADD CONSTRAINT "UK_DataSetFile" UNIQUE ("DataSetID", "EntityName");



-- these alter statements reflect our usage. 
-- we allow them to be null, defaults are meainingless in our model.
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "Size" DROP NOT NULL;
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "Size" DROP DEFAULT;

ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "Authentication" DROP NOT NULL;
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "Authentication" DROP DEFAULT;

ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "Version" DROP NOT NULL;
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "Version" DROP DEFAULT;

-- in our model, missingvaluecode goes with the attribute, not entity.
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "MissingValues" DROP NOT NULL;
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "MissingValues" DROP DEFAULT;

-- in our model, file dates for management are stored in the package management schema, not metabase2
ALTER TABLE metabase2."DataSetFile" ALTER COLUMN "DateCreated" DROP NOT NULL;






--------------------------------------------------------------------

			-- FileTypeList
--------------------------------------------------------------------

ALTER TABLE metabase2."FileTypeList"
   ADD COLUMN "PhysicalLineDelimiter" character varying(8);
COMMENT ON COLUMN metabase2."FileTypeList"."PhysicalLineDelimiter"
  IS 'When a record spans more than one line or row in a file. Rarely used.';

ALTER TABLE metabase2."FileTypeList"
   ADD COLUMN "CollapseDelimiters" character varying(3);
COMMENT ON COLUMN metabase2."FileTypeList"."CollapseDelimiters"
  IS 'Used when multiple spaces act as a single delimiter between columns. Not normally used with other fieldDelimiters.';

ALTER TABLE metabase2."FileTypeList"
   ADD COLUMN "LiteralCharacter" character varying(4);
COMMENT ON COLUMN metabase2."FileTypeList"."LiteralCharacter"
  IS 'A single character but if represented in hex it takes 4 char.';

ALTER TABLE metabase2."FileTypeList"
  ADD CONSTRAINT "CK_FileTypeList_CollapseDelimiters"
  CHECK ("CollapseDelimiters" in ('yes','no') or "CollapseDelimiters" is null);

--------------------------------------------------------------------
