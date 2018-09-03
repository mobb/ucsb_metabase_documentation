We want to specify the order in which a keywordSet is inserted into the EML.
do this by added a sort order to the thesarus type.


ALTER TABLE metabase2."KeywordTypes" ADD COLUMN "ThesaurusSortOrder" integer;
COMMENT ON COLUMN metabase2."KeywordTypes"."ThesaurusSortOrder" IS 'actually it sorts the combination of keywordType and thesaurus being 1:1 with the PK KeywordType which concatenates those two eml elements ids.';


Also I just realized I should have named that new column in vw_eml_keyword to
    thesaurus_position
not thesaurus_sort_order.

Want that changed? 

