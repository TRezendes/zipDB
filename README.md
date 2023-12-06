# zipDB the ZIP Code&trade; Database

## zipDB

A simple database that marries multiple datasets to aid in geolocating addresses via ZIP Code&trade;. All of the data in the database are freely available online (see the [Licensing section](#licensing) for links), but not all in the same place and not always easily cross-referenceable. This project is (currently) primarily for my own purposes, so it is quite limited in scope, but I wanted to share it in case anyone else could make use of it. As I have further need of it and as I have time and energy available, I will gradually expand its density and capabilities.

## The Database

### short_table

Simple ZIP Code data. Each ZIP Code appears only one time, so codes that cross municipal boundaries may return incorrect place names. [Full documentation for the source data](https://simplemaps.com/data/us-zips#sample_fields).

- **zip5** char(5) CONSTRAINT pkey_county_fips PRIMARY KEY
  - Five didgit ZIP Code
- **city** nvarchar(232) NOT NULL
  - Official USPS city name
- **state_abr** nchar(2) NOT NULL
  - Official USPS state abbreviation
- **county_name** nvarchar(232)
  - County name

### county_fips

State and County codes. [Full documentation for the source data](https://www.census.gov/library/reference/code-lists/ansi.html#cou).

- **state_postal_abbr** nchar(2)
  - State postal abbreviation
- **state_fips_code** nchar(2)
  - State FIPS code
- **county_fips_code** nchar(5)
  - County FIPS code
- **county_ns_code** nchar(8) CONSTRAINT pkey_county_fips PRIMARY KEY
  - County NS code
- **county_name** nvarchar(232)
  - County name and legal/statistical area description
- **fips_class** nchar(2)
  - FIPS class code
- **functional_status** nchar(1)
  - Functional status

### zip_to_county

To be used for deriving County from ZIP Code (but not ZIP Code from County). [Full documentation for the source data](https://www.huduser.gov/portal/datasets/usps_crosswalk.html#codebook)

- **zip5** nchar(5)
  - 5 digit USPS ZIP code
- **county_code** nchar(5)
  - 5 digit unique 2000 or 2010 Census county GEOID consisting of state FIPS + county FIPS
- **zip_preferred_city** nvarchar(232)
  - USPS preferred city name
- **zip_preferred_state** nchar(2)
  - USPS preferred state address state
- **residential_ratio** numeric(20, 19)
  - The ratio of residential addresses in the ZIP
- **business_ratio** numeric(20, 19)
  - The ratio of business addresses in the ZIP
- **other_ratio** numeric(20, 19)
  - The ratio of other addresses in the ZIP
- **total_ratio** numeric(20, 19)
  - The ratio of all addresses in the ZIP
- CONSTRAINT pkey_zip_to_county PRIMARY KEY (zip5, county_code)

### zip_to_county_crosswalk

- zip_to_county.**zip5**
- zip_to_county.**zip_preferred_city**
- county_fips.**county_name**
- **state_abbr**
  - county_fips.state_postal_abbr
- zip_to_county.**zip_preferred_state**
- zip_to_county.**residential_ratio**
- zip_to_county.**business_ratio**
- zip_to_county.**other_ratio**
- zip_to_county.**total_ratio**

## Notes

The INSERT files use the [SQL Server Utilities Statement `GO`](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/sql-server-utilities-statements-go?view=sql-server-ver16) to break the INSERTs into batches of 1,000 to accomodate SQL Server's [Table Value Constructor INSERT limit](https://learn.microsoft.com/en-us/sql/t-sql/queries/table-value-constructor-transact-sql?view=sql-server-ver16&redirectedfrom=MSDN#limitations-and-restrictions). For other SQL flavors, the `GO` statements will need to be removed, and INSERT batches may need to be limited in another way.

## Licensing

The databse itself, including all SQL and related code, is released under [the Public Domain Dedication and License v1.0](LICENSE) complemented by [these Community Norms](CommunityNorms.md).

Other licenses and restrictions may apply to the data within the database (including data as represented within the relevant INSERT statements).

- Data in the following files are from U.S. Government sources and are assumed to be in the public domain per [17 U.S.C. &sect; 105](https://www.law.cornell.edu/uscode/text/17/105).
  - Derived from [HUD-USPS ZIP Crosswalk Files](https://www.huduser.gov/apps/public/uspscrosswalk/home)
    - [ZIP_COUNTY_092023.xlsx](data/ZIP_COUNTY_092023.xlsx)
    - [INSERT_zip_to_county.sql](INSERT_zip_to_county.sql)
  - Derived from [U.S. Census County and County Equivalent Entity data](https://www.census.gov/library/reference/code-lists/ansi.html#cou)
    - [national_county2020.txt](data/national_county2020.txt)
    - [national_county2020.xlsx](data/national_county2020.xlsx)
    - [INSERT_county_fips.sql](INSERT_county_fips.sql)
- Data in the following files are derived from [SimpleMaps US Zip Codes Database](https://simplemaps.com/data/us-zips) and are released under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) license.
  - [uszips.csv](data/uszips.csv)
  - [uszips.xlsx](data/uszips.xlsx)
  - [uszipsSQLinserts.xlsx](data/uszipsSQLinserts.xlsx)
  - [INSERT_short_table.sql](INSERT_short_table.sql)

"ZIP Code" is a [trademark of the United States Postal Service](https://about.usps.com/strategic-planning/cs09/CSPO_09_001.htm)

---

A project of [232 Software](http://232.software)

![GitHub License](https://img.shields.io/github/license/TRezendes/zipDB?color=%23D60077)
