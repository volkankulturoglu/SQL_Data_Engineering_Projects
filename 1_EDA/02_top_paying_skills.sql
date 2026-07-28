/*
Question: What are the highest-paying skills for data engineers?

- Calculate the median salary for each skill required in data engineer positions.
- Focus on remote positions with specified salaries.
- Include skill frequency to identify both salary and demand.

Why?

- Helps identify which skills command the highest compensation while also
  showing how common those skills are, providing a more complete picture for
  skill development priorities.

- The median is used instead of the average to reduce the impact of
  outlier salaries.
*/



SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
    FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id  
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND 
    jpf.job_work_from_home = 'True'
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    median_salary DESC
LIMIT 25; 

/*
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ ruby       │      150000.0 │          736 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
  */

  SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
    FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id  
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND 
    jpf.job_work_from_home = 'True'
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    demand_count DESC
LIMIT 5 ; 
/*


Here's the breakdown of the highest-paying skills for remote Data Engineers:

- Rust offers the highest median salary at $210K, although demand remains relatively low compared to more established technologies.
- Terraform and Golang combine exceptionally high salaries with stronger market demand, making them attractive specialization areas.
- Kubernetes, Airflow, and Terraform stand out by balancing both high salaries and substantial demand, indicating strong long-term market value.
- While SQL, Python, AWS, Azure, and Spark are not the absolute highest-paying skills, they remain the most widely requested technologies across remote Data Engineer roles.

Key takeaways:

- Niche technologies often command the highest salaries but typically appear in fewer job postings.
- Core technologies such as SQL, Python, AWS, Azure, and Spark continue to dominate the job market while offering competitive compensation.
- Skills that combine strong salaries with high demand generally provide the best long-term career opportunities.
- Using the median salary provides a more reliable measure of compensation by minimizing the influence of salary outliers.


┌─────────┬───────────────┬──────────────┐
│ skills  │ median_salary │ demand_count │
│ varchar │    double     │    int64     │
├─────────┼───────────────┼──────────────┤
│ sql     │      130000.0 │        29221 │
│ python  │      135000.0 │        28776 │
│ aws     │      137320.0 │        17823 │
│ azure   │      128000.0 │        14143 │
│ spark   │      140000.0 │        12799 │
└─────────┴───────────────┴──────────────┘
*/