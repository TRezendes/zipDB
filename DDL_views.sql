
CREATE VIEW zip_to_county_crosswalk AS (
    SELECT zc.zip5, zc.zip_preferred_city, cf.county_name, cf.state_postal_abbr state_abbr, zc.zip_preferred_state, zc.residential_ratio, zc.business_ratio, zc.other_ratio, zc.total_ratio
    FROM zip_to_county zc
    JOIN county_fips cf ON zc.county_code = CONCAT(cf.state_fips_code, cf.county_fips_code)
);
