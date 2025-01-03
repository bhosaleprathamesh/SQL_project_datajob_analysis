-- subqueries can be used in SELECT, FROM, HAVING and WHERE
SELECT *
FROM (
    SELECT *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- example
SELECT 
    name AS company_name
FROM
    company_dim
WHERE 
    company_id IN (
    SELECT
            company_id
    FROM
            job_postings_fact
    WHERE 
            job_no_degree_mention = true
)

--CTE(Common Table Expressions) can be used within SELECT, INSERT, UPDATE or  DELETE statement
-- defined with WITH

WITH jan_jobs AS (
    SELECT *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1 
)

SELECT *
FROM jan_jobs

--example
WITH company_job_count AS (
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;

--Problem 7*
SELECT
    job_id,
    skill_id
FROM
    skills_job_dim AS skills_to_job