# Index Performance Analysis

## Overview

This document provides instructions and examples for measuring query performance before and after adding indexes to the Airbnb clone database. Use this as a template to record your findings and demonstrate the impact of indexing on query speed.

## Steps to Measure Performance

1. **Choose a Query to Analyze**
   - Example: Find all bookings for a specific user ordered by start date.

2. **Run the Query Without Indexes**
   - Use the `EXPLAIN ANALYZE` command to measure performance.
   - Example:
     ```sql
     EXPLAIN ANALYZE
     SELECT * FROM bookings WHERE user_id = 'some-uuid' ORDER BY start_date;
     ```
   - Record the output (execution time, query plan).

3. **Add the Relevant Index**
   - Example:
     ```sql
     CREATE INDEX idx_bookings_user_id ON bookings(user_id);
     CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
     ```

4. **Re-run the Query With Indexes**
   - Use `EXPLAIN ANALYZE` again.
   - Compare the new output to the previous one.

5. **Document the Results**
   - Note the difference in execution time and query plan.
   - Example table:

| Query | Indexes | Execution Time | Notes |
|-------|---------|---------------|-------|
| SELECT * FROM bookings WHERE user_id = ... | None | 120 ms | Seq Scan |
| SELECT * FROM bookings WHERE user_id = ... | user_id | 5 ms | Index Scan |

## Sample EXPLAIN Output

**Before Index:**
```
Seq Scan on bookings  (cost=0.00..100.00 rows=1000 width=...) (actual time=...)
Filter: (user_id = '...')
... (other details)
Total runtime: 120 ms
```

**After Index:**
```
Index Scan using idx_bookings_user_id on bookings  (cost=0.00..10.00 rows=10 width=...)
Index Cond: (user_id = '...')
... (other details)
Total runtime: 5 ms
```

## Tips
- Use realistic queries that reflect actual application usage.
- Test with and without indexes for fair comparison.
- Try different columns and combinations (e.g., composite indexes).
- Document your findings for each query tested.

## Conclusion
Indexes can dramatically improve query performance, especially for large tables and frequent queries. Use this template to demonstrate and justify your indexing strategy. 