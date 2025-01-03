SELECT 
    COUNT(job_id) AS job_count,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

-- CASE - BEGINS THE EXPRESSION
-- WHEN - SPECIFIES THE CONDITION(S) TO LOOK AT
-- THEN - WHAT TO DO WHEN THE CONDITION IS TRUE
-- ELSE(OPTIONAL) - PROVIDES OUTPUT IF NONE OF THE WHEN CONDITIONS ARE MET
-- END - CONCLUDES THE CASE EXPRESSION