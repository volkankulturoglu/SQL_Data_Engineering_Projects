/*
Question: What are the most in-demand skills for data engineers?

- Identify the top 10 in-demand skills for data engineers.
- Focus on remote job postings.

Why?

- Retrieves the top 10 skills with the highest demand in the remote job market,
  providing insights into the most valuable skills for data engineers seeking
  remote work.
*/



SELECT 
    sd.skills,
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
ORDER BY 
    demand_count DESC
LIMIT 10; 


/*
Here's the breakdown of the most in-demand skills for remote Data Engineers:

- SQL and Python dominate the market, each appearing in approximately 29,000 job postings—nearly twice as often as the next most requested skill.
- AWS is the leading cloud platform, followed by Azure, highlighting the industry's strong reliance on cloud technologies.
- Spark ranks fifth with nearly 13,000 postings, reinforcing the importance of large-scale data processing.
- Airflow, Snowflake, and Databricks demonstrate the growing demand for modern data pipeline and cloud data platform expertise.

Key takeaways:

- SQL and Python remain the core technical skills for Data Engineers.
- Cloud expertise, particularly AWS and Azure, is a fundamental requirement in today's job market.
- Big data technologies such as Spark continue to be highly valued.
- Modern data engineering tools, including Airflow, Snowflake, and Databricks, have become mainstream requirements rather than niche skills.

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
  */