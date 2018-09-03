Mon Jun 24 16:33:39 PDT 2013

backward compatible? yes
essential? yes

Goal:
attributes need to be a little more EML centric. This is essential to us getting our EML content in. 
When all content is in metabase, it may become clearer how the Metabase concept of a 'variable' is used, and we may readopt components.

Approach:
Two new tables will sit alongside the metabase tables, and our views will use both original metabase tables and our new tables.

----------
Original Metabase2 (see image attribute_info_tables_original.jpg):
"*TypeList" tables hold vocabularies. For the attribute information group of tables, these are:
SuperTypeList
DataTypeList
VariableTypeList
NumericalTypeList
 
These values are the FK constraints in two tables: 
1, DataSetVariables, which holds the basic descriptions that will become EML-attributes, and
2. EMLUnitMap, which maps between the Metabase concept of a variable and EML's

The EMLUnitMap table also has FK constraints to 5 tables, 4 are *TypeList tables, 
EMLNumberTypeList
EMLStorateGypeLIst
EMLMeasurementScaleList
EMLStorageTypeList
EMLUnitDictionary



------------
SBC/MCR Solution (see image sbc_mcr_fork4_tables.jpg):

Original tables we use:
EMLMeasurementScaleList (a new table references it)
EMLUnitDictionary (a new table references it)

New tables:
1. MeasurementScaleDomains
This table collects together the features that describe an EML measurements scale. These are:
a. EML Domain type (nonNumeric, numeric, dateTime -- these are the XML-Types
b. measurement scase (nominal, ordinal, interval, ratio, dateTime) -- these are element names.
c. for the nonNumeric domains, there is a sub-domain, either "enumerated" or "text"

measurementScale references EMLMeasurementScaleList.measurementScale
these 3 cols are grouped together into a measScaleDomain_id 


2. EMLStorageTypeList
We added a column for typeSystem. All original values were set to 
'http://www.w3.org/2001/XMLSchema-datatypes'


3. DataSetVariables2
similar to original DataSetVariables. has all the content needed for an EML attribute. 
table has blocks of columns for different measurementScale-domains. So attributes will have only certain columns filled out. see below for more. 

This table has many constraints,
checks for the blocks of cols that should be blank for a given measurementScaleDomain_id
FK: 
measScaleDomain_ID references measurementScaleDomains.MeasScaleDomain_ID
Unit refernces EMLUnitDictionary
numberType references numberTypeList
storageType refernces storageTypelist


---------------------------------------
LATER:
Wed Sep 11 13:31:07 PDT 2013

DataSetVariables2 ammended so that TextDescription can be wider, to accomodate a full description (see sbc.36 for an example)
increasing width of TextDescritpion to 500 chars

