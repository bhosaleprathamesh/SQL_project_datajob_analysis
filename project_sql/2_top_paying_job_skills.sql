WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        job_location,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_location LIKE '%India' AND
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
The top 10 skills mentioned in the job postings are:

SQL: 6 occurrences
Power BI: 5 occurrences
MongoDB: 4 occurrences
Python: 4 occurrences
Oracle: 4 occurrences
Azure: 3 occurrences
AWS: 3 occurrences
Spark: 3 occurrences
Excel: 3 occurrences
GDPR: 2 occurrences

Insights:
-SQL is the most in-demand skill for analyst roles, likely due to its foundational role in data management and analysis.
-Power BI, a business intelligence tool, is highly sought after, reflecting the importance of data visualization and reporting.
-Other technical skills like Python, MongoDB, and Oracle emphasize the need for programming and database expertise.
-Cloud platforms like Azure and AWS are also important, highlighting the industry's shift toward cloud-based solutions.
-Excel remains a key tool, showing its continued relevance despite the rise of advanced tools.
*/
