/* 
CREATE TABLE short_table (
    city nvarchar(232) NOT NULL,
    state_abr nchar(2) NOT NULL,
    zip5 char(5),
    county_name nvarchar(232)
    CONSTRAINT pkey_shorttable PRIMARY KEY (zip5),
);
 */
/* 
CREATE TABLE county_fips (
    state_postal_abbr nchar(2),
    state_fips_code nchar(2),
    county_fips_code nchar(5),
    county_ns_code nchar(8),
    county_name nvarchar(232),
    fips_class nchar(2),
    functional_status nchar(1),
    CONSTRAINT pkey_county_fips PRIMARY KEY (county_ns_code)
);
 */
/* 
CREATE TABLE zip_to_county (
    zip5 nchar(5),
    county_code nchar(5),
    zip_preferred_city nvarchar(232),
    zip_preferred_state nchar(2),
    residential_ratio numeric(20, 19),
    business_ratio numeric(20, 19),
    other_ratio numeric(20, 19),
    total_ratio numeric(20, 19),
    CONSTRAINT pkey_zip_to_county PRIMARY KEY (zip5, county_code)
);
 */
