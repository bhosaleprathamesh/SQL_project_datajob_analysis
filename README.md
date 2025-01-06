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

Here's the breakdown of the top data analyst jobs in India 2023:
- **Salary Trends:** The top-paying roles are specialized positions like "Staff Applied Research Engineer" and various "Data Architect" roles, with salaries significantly higher than others. This indicates a strong market demand for expertise in data architecture and applied research, with the highest salary reaching $177,283 annually.
- **Location Specificity:** High-salary jobs are predominantly located in urban centers like Hyderabad, Bengaluru, and Gurugram, suggesting these are key hubs for tech and data-related industries in India.
- **Job Role Diversity:** Analyst roles tend to offer lower average salaries compared to architect or senior research positions, highlighting the salary disparity based on the level of responsibility, expertise, and perhaps the strategic importance of the role within the company.


| Job Title                              | Salary (Yearly Average) |
|----------------------------------------|--------------------------|
| Staff Applied Research Engineer        | 177283.0                |
| Technical Data Architect - Healthcare  | 165000.0                |
| Data Architect 2023                    | 165000.0                |
| Data Architect - Data Migration        | 165000.0                |
| Data Architect                         | 163782.0                |
| Data Architect                         | 163782.0                |
| Senior Business & Data Analyst         | 119250.0                |
| Sr. Enterprise Data Analyst            | 118140.0                |
| Data Analyst                           | 111175.0                |
| Data Analyst (Contractual Role)        | 111175.0                |

*Table of the top paying data analyst jobs*

### 2. Skills for Top Paying Jobs 
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
~~~sql
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
~~~

Here's the breakdown:
- **SQL and Python are the most common skills:** With SQL having the highest count and Python close behind, these skills are crucial in data-related jobs, indicating their importance in technical roles
- **Cloud technologies are in demand:** Skills in Azure and AWS reflect a growing emphasis on cloud platforms, which are essential for modern data solutions and scalable infrastructure in businesses.
- **Big Data tools show relevance:** Technologies like Spark, Databricks, and Hadoop appear multiple times, highlighting the increasing need for expertise in handling large datasets.

| Skill        | Count |
|--------------|-------|
| sql          | 9     |
| python       | 7     |
| mongodb      | 6     |
| oracle       | 4     |
| azure        | 3     |
| aws          | 3     |
| spark        | 3     |
| databricks   | 2     |
| hadoop       | 2     |
| gdpr         | 2     |

*Table of the count of skills for the top 10 paying jobs for data analysts.*

### 3. In-Demand Skills for Data Analysts 
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

~~~sql
SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_location LIKE '%India' AND
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5; 
~~~
Here's the breakdown of the most demanded skills for data analysts in India 2023:

- **SQL and Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like **Python, Tableau, and Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills    | Demand Count |
|-----------|--------------|
| SQL       | 2561         |
| Python    | 1802         |
| Excel     | 1718         |
| Tableau   | 1346         |
| Power BI  | 1043         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
~~~sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_location LIKE '%India' AND
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25; 
~~~

Here’s the analysis based on the top 10 skills with the highest average salaries:
- **High Demand for Infrastructure and Data Engineering Skills:** Skills like PySpark, GitLab, PostgreSQL, Linux, and MySQL are all valued at a high average salary, indicating a strong demand for infrastructure, database management, and big data engineering roles.
- **Emerging Skills with Competitive Salaries:** Neo4j, GDPR, and Airflow are emerging skills with salaries close to the top-tier skills. This suggests their growing importance in data governance, workflow automation, and managing big data systems.
- **Data-Centric Roles Continue to Drive High Salaries:** Tools related to big data processing (such as Spark and Scala) and database management (like PostgreSQL and MongoDB) dominate the list, reflecting the high value of these skills in data-centric and software development roles.

| Skills      | Average Salary ($) |
|-------------|--------------------|
| PySpark     | 165000             |
| GitLab      | 165000             |
| PostgreSQL  | 165000             |
| Linux       | 165000             |
| MySQL       | 165000             |
| Neo4j       | 163782             |
| GDPR        | 163782             |
| Airflow     | 138088             |
| MongoDB     | 135994             |
| Scala       | 135994             |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

~~~sql
WITH skills_demand AS(
    SELECT
        skills_job_dim.skill_id, 
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_location LIKE '%India' AND
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
), average_salary AS( 
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_location LIKE '%India' AND
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC
~~~
Here’s the breakdown: 
- **SQL and Python** are in high demand but offer relatively lower salaries compared to other skills in the list. This suggests that these skills are widely used and are fundamental, which could mean more competition for positions.
- **Spark and Power BI** stand out with high salaries despite having a moderate demand count. These skills seem to be specialized, which makes them more valuable but less commonly required in the job market.
- Skills like **Tableau, AWS, and Oracle** strike a balance between moderate demand and good salaries. These are likely to be in demand for specific roles but might not be as competitive as highly in-demand skills like **SQL and Python**.

| Skills     | Demand Count | Avg Salary ($) |
|------------|--------------|----------------|
| Spark      | 11           | 118,332        |
| Power BI   | 17           | 109,832        |
| Oracle     | 11           | 104,260        |
| Python     | 36           | 95,933         |
| Tableau    | 20           | 95,103         |
| AWS        | 12           | 95,333         |
| Azure      | 15           | 98,570         |
| SQL        | 46           | 92,984         |
| R          | 18           | 86,609         |
| Excel      | 39           | 88,519         |

*Table of the most optimal skills for data analyst sorted by salary*

# Conclusion
This project significantly enhanced my SQL skills, particularly in writing complex queries for large datasets. It also provided valuable insights into the data analyst job market, helping me identify key skills that align with high demand and high salaries. The findings serve as a guide for prioritizing skill development and focusing job search efforts. This exploration underscores the importance of continuous learning and staying adaptable to emerging trends in the field of data analytics.