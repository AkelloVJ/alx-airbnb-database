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

## Key Indexes Created

### User Table Indexes
- `idx_users_email` - For fast user lookup by email
- `idx_users_role` - For filtering users by role

### Property Table Indexes
- `idx_properties_host_id` - For finding properties by host
- `idx_properties_location` - For location-based searches
- `idx_properties_price_per_night` - For price-based filtering

### Booking Table Indexes
- `idx_bookings_user_id` - For finding bookings by user
- `idx_bookings_property_id` - For finding bookings by property
- `idx_bookings_status` - For filtering by booking status
- `idx_bookings_dates` - For date range queries

## Performance Measurement Queries

The following queries are used to measure performance:

1. **User Lookup by Email**
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM users WHERE email = 'john.smith@email.com';
   ```

2. **Booking Lookup by User ID**
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM bookings WHERE user_id = '550e8400-e29b-41d4-a716-446655440002';
   ```

3. **Property Lookup by Host ID**
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM properties WHERE host_id = '550e8400-e29b-41d4-a716-446655440001';
   ```

4. **Booking Lookup by Status**
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM bookings WHERE status = 'confirmed';
   ```

5. **Date Range Queries**
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM bookings WHERE start_date >= '2024-01-01' AND end_date <= '2024-12-31';
   ```

## Expected Performance Improvements

- **Email lookups**: 95% improvement (from sequential scan to index scan)
- **User booking queries**: 90% improvement with proper indexing
- **Date range queries**: 80% improvement with composite date index
- **Status filtering**: 85% improvement with status index

## Tips
- Use realistic queries that reflect actual application usage.
- Test with and without indexes for fair comparison.
- Try different columns and combinations (e.g., composite indexes).
- Document your findings for each query tested.
- Monitor index usage and maintenance overhead.

## Conclusion
Indexes can dramatically improve query performance, especially for large tables and frequent queries. Use this template to demonstrate and justify your indexing strategy. The performance improvements should be measurable and significant for high-traffic applications. 