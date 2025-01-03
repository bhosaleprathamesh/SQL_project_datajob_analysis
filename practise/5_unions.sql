--Union - combines results from two or maore SELECT statements 
-- they need to have the same amount of columns and the data type must match
-- gets rid of duplicate rows ie all rows are unique 


SELECT 
    job_title_short,
    company_id,
    job_location

FROM 
    january_jobs

UNION

SELECT 
    job_title_short,
    company_id,
    job_location

FROM 
    february_jobs

UNION

SELECT 
    job_title_short,
    company_id,
    job_location

FROM 
    march_jobs

--UNION ALL same as UNION but returns all rows even duplicates unlike UNION

SELECT 
    job_title_short,
    company_id,
    job_location

FROM 
    january_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location

FROM 
    february_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location

FROM 
    march_jobs