ALTER TABLE metabase2."KeywordTypes" ADD COLUMN "ThesaurusSortOrder" integer;
COMMENT ON COLUMN metabase2."KeywordTypes"."ThesaurusSortOrder" IS 'actually it sorts the combination of keywordType and thesaurus being 1:1 with the PK KeywordType which concatenates those two eml elements ids.';


