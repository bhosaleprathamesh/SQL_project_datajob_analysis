# Introduction
Uncovering the lucrative career paths for Data Analysts in India: This project analyzes top-paying roles, in-demand skills, and identifies the sweet spot where high salary meets high demand.

Check the SQL queries here: [project_sql_folder](/project_sql/)
# Background
Driven by the desire to equip Data Analysts with the knowledge needed to navigate the Indian job market effectively, this project focuses on identifying the skills that translate to higher earning potential and increased career opportunities.

The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I Used 
For my in-depth exploration of the data analyst job market, I utilized several essential tools:

- **SQL:** The cornerstone of my analysis, enabling me to query databases and extract valuable insights.
- **PostgreSQL:** My database management system of choice, well-suited for managing job posting data.
- **Visual Studio Code:** My preferred platform for database management and executing SQL queries.
- **Git & GitHub:** Vital for version control and sharing SQL scripts, fostering collaboration and efficient project tracking.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location(India). This query highlights the high paying opportunities in the field.

~~~sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_location LIKE '%India' AND
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
~~~
# What I Learned

# Conclusion
