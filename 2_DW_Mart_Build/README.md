## Progress

### Completed

- Built the dimensional data warehouse schema.
- Implemented a denormalized Flat Mart for analytics.
- Created a Skills Demand Mart with dimension and fact tables.
- Validated SQL scripts and data loading process.

### Next Steps

The following marts will be implemented next:

- `05_create_priority_mart.sql`
  - Create a business-focused priority jobs mart to identify high-value job opportunities based on salary, demand, and remote availability.

- `06_update_priority_mart.sql`
  - Implement an incremental update process using `MERGE` to efficiently refresh the priority mart without rebuilding it from scratch.


  ## Roadmap

- [x] Data Warehouse
- [x] Flat Mart
- [x] Skills Mart
- [ ] Priority Jobs Mart
- [ ] Incremental MERGE Pipeline
- [ ] Documentation Improvements