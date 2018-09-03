-- the first fork 6

ALTER TABLE metabase2."DataSetEntityMethodSteps"
   ADD COLUMN "MethodStep_xml" xml;
COMMENT ON COLUMN metabase2."DataSetEntityMethodSteps"."MethodStep_xml"
  IS 'does not contain the <methodStep> element itself, only the content of that element.';


ALTER TABLE metabase2."DataSetMethods"
   ADD COLUMN "MethodStep_xml" xml;
COMMENT ON COLUMN metabase2."DataSetMethods"."MethodStep_xml"
  IS 'does not contain the <methodStep> element itself, only the content of that element.';


-- the  second fork6. better one.

ALTER TABLE metabase2."DataSetEntityMethods"
   ADD COLUMN "Methods_xml" xml;
COMMENT ON COLUMN metabase2."DataSetEntityMethods"."Methods_xml"
  IS 'does contain the <methodStep> element(s)';

ALTER TABLE metabase2."DataSetEntityMethodSteps" RENAME "MethodStep_xml"  TO deprecated;

-- originally, to be consistent with the change made to DataSetMethods, 
-- the methodStep_xml should have been on the table DataSetEntityMethods, not DataSetENtityMethodSteps

