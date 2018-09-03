ALTER TABLE metabase2."DataSet"
  ADD COLUMN "Abstract_xml" xml;

ALTER TABLE metabase2."DataSet"
   ALTER COLUMN "Abstract" TYPE character varying(5000);

