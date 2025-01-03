SELECT job_posted_date 
FROM job_postings_fact
LIMIT 10;

SELECT 
    '2023-07-15'::DATE,
    'true'::BOOLEAN,
    '36'::INTEGER,
    '3.14'::REAL;

--converting timestamp to date
SELECT
    job_title_short AS job,
    job_location AS location,
    job_posted_date::DATE AS date 
FROM
    job_postings_fact;

--specifying timezone to timestamp and then converting the timezone
SELECT 
    job_title_short AS job,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kolkata' AS date
FROM
    job_postings_fact
LIMIT 10;

--EXTRACTING MONTH/YEAR ETC FROM COLUMN
SELECT 
    job_title_short AS job,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kolkata' AS date,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
LIMIT 10;

--TREND ANALYSIS
SELECT 
    COUNT(job_id) AS job_postings,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
    job_postings DESC;

--CREATING TABLES FOR JAN,FEB,MAR
CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT 
    job_posted_date
FROM january_jobs;