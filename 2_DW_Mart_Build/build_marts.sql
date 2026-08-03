--duckdb dw_marts.ducdb -c ".read build_marts.sql"




-- Step 1: DW - Create star schema tables (Data Warehouse)
.read 01_create_tables_dw.sql

--Step 2 :DW - Load data from CSV files into star schema tables (Data Warehouse)
.read 02_load_schema_dw.sql


SELECT *
FROM job_postings_fact
LIMIT 10;