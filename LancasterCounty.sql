/* 
    This query is a work in progress. The idea is to have a generalized query to narrow down ZIP Codes by County name.
 */


/* 
SELECT zc.zip5 zip5, cf.county_name, cf.state_postal_abbr state_abbr, zc.business_ratio, zc.total_ratio
FROM zip_to_county zc
JOIN county_fips cf ON zc.county_code = CONCAT(cf.state_fips_code, cf.county_fips_code)
WHERE zc.zip5 IN (
    SELECT zip5
    FROM (
        SELECT zc.zip5 zip5, cf.county_name, cf.state_postal_abbr state_abbr, zc.residential_ratio, zc.business_ratio, zc.other_ratio, zc.total_ratio
        FROM zip_to_county zc
        JOIN county_fips cf ON zc.county_code = CONCAT(cf.state_fips_code, cf.county_fips_code)
        WHERE zc.zip5 IN (
            SELECT zc.zip5
            FROM zip_to_county zc
            JOIN county_fips cf ON zc.county_code = CONCAT(cf.state_fips_code, cf.county_fips_code)
            WHERE county_name LIKE 'Lancaster%'
                AND cf.state_postal_abbr = 'PA'
            )
            AND business_ratio > 0
        ) sq
    GROUP BY zip5
    HAVING COUNT(DISTINCT county_name) > 1
    )
    AND county_name = 'Lancaster county'
    AND business_ratio > 0.25

ORDER BY zip5, business_ratio DESC
 */


SELECT CONCAT('(''', zip5, ''', ', business_ratio, '),')
FROM (
    SELECT zc.zip5 zip5, cf.county_name, cf.state_postal_abbr state_abbr, zc.residential_ratio, zc.business_ratio, zc.other_ratio, zc.total_ratio
    FROM zip_to_county zc
    JOIN county_fips cf ON zc.county_code = CONCAT(cf.state_fips_code, cf.county_fips_code)
    WHERE zc.zip5 IN (
        SELECT zc.zip5
        FROM zip_to_county zc
        JOIN county_fips cf ON zc.county_code = CONCAT(cf.state_fips_code, cf.county_fips_code)
        WHERE county_name LIKE 'Lancaster%'
            AND cf.state_postal_abbr = 'PA'
        )
        AND county_name LIKE 'Lancaster%'
        AND business_ratio > 0
    ) sq
