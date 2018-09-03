January 2014.
Both SBC and MCR are now using Metabase for updating timeseries.

Both projects revision files for time series updates.

this means that an entity named "CTD profiles", might currently have a filename:
ctd_profiles_20130101.txt. 

the next update of entity "CTD profiles" will have a different filename, eg, 
ctd_profiles_20140101.txt.

CTD profiles will have only one current file, and the newest file replaces older files

We want to keep track of the files that go with the entity "CTD profiles". Metabase does not have a concept of revision at all.

Solution:
we will add a new column to DataSetEntity called "FileNameReplaced"
Same datatype as FileName
nullable
add a self-referencing FK, replaces points to FileName

So for any FileName, we can say filenameB file-name-replaced filenameA
etc


This fork actually was more complicated. It generated some changes to several views, mainly because of a unique constraint on one table. (with replaced filename, an entity may have more than one filename associated.

So here are the basic steps, in human-speak. Gastil will send sql.

1. table DataSetFile: add column: ReplacedFilename. 
                   add FK self, DataSetFile.Filename
                   add constraint DSID-FileName
                   drop unique constraint DSID-EntityName

2. view vw_eml_package_id: revision=0 when status is draft0 or anticipated.

3. view vw_eml_short_name: generate shortName if status is draft0 or anticipated

4. view vw_eml_physical: return only leaves (no filenames that are referents)

5. view_eml_entity: return only leaves (no entity generated if filename is referent), because entity must know about ____, which are per-file

6. view_eml_access: return only leaves (no access tree generated if filename is referent), because entity must know about auth rules, which are per-file.


