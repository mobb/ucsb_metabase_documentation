# Fork log, GCE metabase 2 -> UCSB (SBC, MCR LTER) 2013
A "fork" is a change to the metabase2 schema. There are 3 types:

- essential and not backward compatible
- essential and backward-compatible
- non-essential, and to be considered later.

For SBC/MCR work in 2012-2013, only essential forks are implemented. Non-essential forks may be noted below 
under "Future forks".
Anticipated forks are also noted below, under "Future forks".
Forks are numbered in the order they were implemented. 

A 'stub' is not a fork, so description of stubs do not appear here. Stubs are placeholders for parts 
of the model that need to be more fully deveoped later.
An example of a stub is something
that returns a hard copy of a field till changes in model (or something else more sophisticated) can be implemented. 
We have stubs for
Boilerplate (rows of the table mb2.eml.Boilerplate). Many of the stubs use postgres's built-in XML type.



## Fork descriptions:
Each fork's sql and notes are in a dir. See there for more info.

**fork 1:**

- 2013 March
- allowed DataSet to be n:n with funding. Added a new table "DataSetType" to use instead of StudyType". see that dir.
- not backward compatible. Wade approved.


**fork 2:**

- 2013 April
- added a column to DataSet to hold abstract in xml
- increased size of column for abstract (char varying)
- backward compatible


**fork 3**: 

- DEPRECATED. See Fork 7 for everything related to DataSetEntities table
- 2013 June
- added a column to DataSetEntities for SortOrder
- backward compatible


**fork 4**:

- 2013 June
- attributes: create new tables to refactor EMLUnitMap into a more EML-centric model
- These will sit alongside the metabase tables, and our views may use both original metabase tables and our new tables.
- backward compatible.
- in the future forks section, these were g and h (we need an attribute label, and 'exclusive' booleans on the bounds.

**fork 5**:

- 2013 June
- add a column methods_xml to both DataSetMethods and DataSetEntityMethods
- backward compatible

**fork 6**:

- 2013 June
- widen several columns. drop and reload.
- backward compatible

**fork 7**:

- 2013 August
- add column DataSetEntities.SortOrder (was fork 3, deprecated)
- add column DataSetEntities.EntityID
- widen DataSetEntities.EntityDescription (required a drop/reload)


**Fork 8** (required drop-reload)

- 2013 September
- reset data types from real to fp
- (the drop/reload from fork 7 done at the same time.)

**Fork 9**:

- 2013 September
- several changes to the information about DataSetFile
- DataSetFile: some columns added, some NOT NULLs relaxed.
- new table: SubPath, to hold a controlled vocabulary to be used for constructing entity URLs


**Fork 10**:

- 2013 September
- dataSet Geograhic coverage.
- several small changes to exsiting tables and several new tables. handles our use of geocov at multiple levels (3), and for references.

**Fork 11**:

- 2013 September
- three new cross-reference tables for Temporal coverage. handles coverage at datset, entity and attribute level.

**Fork 12**:

- 2013 October
- two New cross-reference tables for Taxonomic coverage. handles coverage at dataset and entity levels (neither sbc nor mcr uses attr-level coverage at this time)

**Fork 13**

- added a sort_order to keywordSet. not related to note about a future fork regarding keywords, below.

Fork 14:

**Jan 2014**
- DataSetFile: add a column called "FileNameReplaced" so that as we add update a time series with a new file, we can record what it replaced.  self referencing, and nullable.


**Fork 15**

TBD! 


----------

When you write up a fork that's been noted below, give it a number, and move the short description up here.

Future forks: recorded here so you can erase your white board.

Noted 2013 Apr 03
**a. real -> floating point**

At least some fields with numbers typed 'real' need to switch to double precision
the lats and lons in "SubSite" were the first ones we noticed.


**b. DataSetPersonnel**:

we need a table to hold creators which are organizations. add Organizations, 
?? logic: if NULL then it's a person [note (august): not sure what was meant here. if ??=NULL] 
how to accomodate the individualName+org that MCR uses?


**c. DataSetKeywords**

split KeywordTheme into Theme and Vocab (in orig, they are conflated)


**d. merge the keyword models for research_project and dataset** (models, terms)i




**e. in research_project**, 

Noted 2013 May 03
we need a project:project cross ref. or something else so the relationship between projects is described. self refrencing?



**f. DataSetVariables**: 

Noted 2013 May 03
column ValueCodes is csv. we will make it XML, and dump our enumeratedList into it.
This is one of the xml stubs. we have a column called enumeration_xml. The real fork will add tables to hold attribute enums.	


**g. possible new cross-ref tables**? 

Noted 2013 May 03
EntitySubSite, attributeSubsite? (this is related to taxon-coverage at different levels. does gastil have a plan for these?)



**h. packageId components - possible new table, EMLRevision**.

package id has 3 components, scope, datasetId, revision.
scope is fixed (per site)
datasetID is key in many tables
revision can come from one of:

1. query the catalog for the current resvision of that datsaetID and +1 
2. local: metabase2.DataSetNotify: I think this is where Wade stores it
3. local: metabase2.EMLRevsion: this would be a new table
4. local: pkg_mgmt.pkg_state: might be best because a) this is what showDraft will look for to name the file it displays, and b) packageId composed in a view.

Oct 2013: NO FORK. 

packageId = string + metabase2.dataset.datasetid + pkg_mgmt.pkg_state.rev
Option 4.



**i. October 2013**

EMLUnitDictionary.multiplierToSI and EMLUnitDictonary.constantToSI should be type numeric instead of type char. 
This cound be combined with fork4, since that affected the EML unit map.
Requires a drop-reload. not yet implemented.

**j. alternateId**

added feb 2014., from your notes 2013-09-23
we might need a cross ref table, dataset_alternateID. see your paper notes, or talk to gastil. why the entity sort order?

cols: 

datasetid
entitysortorder
altid
system


