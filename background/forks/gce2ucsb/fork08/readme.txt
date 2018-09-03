this expands entityDescription from 100 to 500 characters 
and converts data type real to double precision, esp for lat and lon

see mob's more complete notes

 "EntityDescription" character varying(200) NOT NULL


    "Distance" real,
    "MinValid" real,
    "MinExpected" real,
    "MaxExpected" real,
    "MaxValid" real,
    "MinValue" real,
    "MaxValue" real,
    "EML_DatePrec" real,
    "MinValid" real,
    "MinExpected" real,
    "MaxExpected" real,
    "MaxValid" real,
    "MinValue" real,
    "MaxValue" real,
    datetime_precision real,

::real
real NOT NULL
real DEFAULT

sed 's/ real NOT NULL/ double precision NOT NULL/' | sed 's/ real DEFAULT/
double precision DEFAULT/'

then one other where the Hectacres was the last column in a CREATE TABLE

