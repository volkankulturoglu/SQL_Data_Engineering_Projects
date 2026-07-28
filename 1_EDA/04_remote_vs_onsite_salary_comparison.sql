/*
Question: Do remote roles offer higher median salaries than on-site roles?

- Compare median salaries between remote and on-site positions for each job category.
- Include the number of job postings to provide context for each comparison.

Why?

- Helps evaluate whether remote work is associated with higher compensation
  across different job categories.

- Combining salary data with posting counts provides additional context,
  making it easier to distinguish broad market trends from categories with
  relatively few job postings.

- The median is used instead of the average to reduce the influence of
  salary outliers.
*/

WITH salary_comparison AS (
    SELECT
        job_title_short,
        job_work_from_home,
        COUNT(*) AS posting_count,
        MEDIAN(salary_year_avg) AS median_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY
        job_title_short,
        job_work_from_home
)

SELECT
    r.job_title_short,

    r.posting_count AS remote_postings,
    o.posting_count AS onsite_postings,

    ROUND(r.median_salary, 0) AS remote_median_salary,
    ROUND(o.median_salary, 0) AS onsite_median_salary,

    ROUND(
        r.median_salary - o.median_salary,
        0
    ) AS salary_difference,

    ROUND(
        (
            r.median_salary - o.median_salary
        ) / o.median_salary * 100,
        2
    ) AS difference_percent

FROM salary_comparison AS r
JOIN salary_comparison AS o
    ON r.job_title_short = o.job_title_short

WHERE
    r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
    

ORDER BY
    difference_percent DESC;
    

/*

Here's the breakdown of remote vs. on-site salaries across job categories:

- Remote roles do not consistently offer higher salaries across all positions.
- Software Engineers show the largest remote salary advantage, with a median salary nearly 38% higher than on-site roles.
- Data Scientists and Data Engineers also earn modest salary premiums when working remotely.
- In contrast, Senior Data Engineers, Data Analysts, Business Analysts, and Senior Data Analysts have slightly higher median salaries in on-site positions.

Key takeaways:

- The impact of remote work on compensation varies by job category rather than following a universal trend.
- Most salary differences are relatively small, with Software Engineer being the most notable exception.
- Including job posting counts provides important context, helping distinguish broad market trends from categories with fewer opportunities.
- Median salaries provide a more representative comparison by reducing the influence of unusually high or low salaries.

┌───────────────────────────┬─────────────────┬─────────────────┬──────────────────────┬──────────────────────┬───────────────────┬────────────────────┐
│      job_title_short      │ remote_postings │ onsite_postings │ remote_median_salary │ onsite_median_salary │ salary_difference │ difference_percent │
│          varchar          │      int64      │      int64      │        double        │        double        │      double       │       double       │
├───────────────────────────┼─────────────────┼─────────────────┼──────────────────────┼──────────────────────┼───────────────────┼────────────────────┤
│ Software Engineer         │             448 │            1130 │             180000.0 │             130000.0 │           50000.0 │              38.46 │
│ Cloud Engineer            │              45 │             174 │             132000.0 │             117625.0 │           14375.0 │              12.22 │
│ Data Scientist            │            1949 │           10676 │             132500.0 │             125000.0 │            7500.0 │                6.0 │
│ Data Engineer             │            1576 │            8975 │             135000.0 │             130000.0 │            5000.0 │               3.85 │
│ Senior Data Scientist     │             635 │            2636 │             160000.0 │             155000.0 │            5000.0 │               3.23 │
│ Machine Learning Engineer │             169 │            1165 │             138434.0 │             135000.0 │            3434.0 │               2.54 │
│ Senior Data Engineer      │             518 │            2765 │             145000.0 │             147500.0 │           -2500.0 │              -1.69 │
│ Business Analyst          │             270 │            1692 │              90000.0 │              92500.0 │           -2500.0 │               -2.7 │
│ Data Analyst              │            1212 │           12388 │              87500.0 │              90000.0 │           -2500.0 │              -2.78 │
│ Senior Data Analyst       │             311 │            2292 │             105000.0 │             110433.0 │           -5433.0 │              -4.92 │
└───────────────────────────┴─────────────────┴─────────────────┴──────────────────────┴──────────────────────┴───────────────────┴────────────────────┘*/