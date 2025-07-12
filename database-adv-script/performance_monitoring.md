# Database Performance Monitoring and Refinement Guide

## Overview

This guide provides comprehensive instructions for monitoring and refining database performance using SQL commands like `EXPLAIN ANALYZE`, `SHOW PROFILE`, and other analysis tools. The goal is to identify bottlenecks and implement improvements for optimal database performance.

## Performance Monitoring Tools

### 1. EXPLAIN ANALYZE

**Purpose**: Analyze query execution plans and performance metrics

```sql
-- Basic EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, COUNT(b.booking_id) as booking_count
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.role = 'guest'
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(b.booking_id) > 0;

-- Example Output Analysis:
-- Planning time: 0.123 ms
-- Execution time: 45.678 ms
-- Actual vs Estimated rows comparison
-- Index usage verification
```

### 2. SHOW PROFILE (MySQL)

**Purpose**: Monitor query performance in MySQL

```sql
-- Enable profiling
SET profiling = 1;

-- Run your query
SELECT * FROM bookings WHERE user_id = 'user-uuid';

-- Check profile
SHOW PROFILES;
SHOW PROFILE FOR QUERY 1;
```

### 3. PostgreSQL Performance Views

```sql
-- Check table sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Check index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;

-- Check table statistics
SELECT 
    schemaname,
    tablename,
    attname,
    n_distinct,
    correlation
FROM pg_stats
WHERE tablename IN ('users', 'bookings', 'properties')
ORDER BY tablename, attname;
```

## Frequently Used Queries for Performance Analysis

### 1. User Booking Analysis
```sql
-- Query to monitor
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_price) as total_spent,
    AVG(b.total_price) as avg_booking_value
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.role = 'guest'
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(b.booking_id) > 0
ORDER BY total_spent DESC;

-- Performance analysis
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_price) as total_spent,
    AVG(b.total_price) as avg_booking_value
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
WHERE u.role = 'guest'
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(b.booking_id) > 0
ORDER BY total_spent DESC;
```

### 2. Property Performance Analysis
```sql
-- Query to monitor
SELECT 
    p.property_id,
    p.name,
    p.location,
    COUNT(b.booking_id) as booking_count,
    AVG(r.rating) as avg_rating,
    SUM(b.total_price) as total_revenue
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON p.property_id = r.property_id
WHERE b.status = 'confirmed'
GROUP BY p.property_id, p.name, p.location
ORDER BY total_revenue DESC;

-- Performance analysis
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    p.location,
    COUNT(b.booking_id) as booking_count,
    AVG(r.rating) as avg_rating,
    SUM(b.total_price) as total_revenue
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON p.property_id = r.property_id
WHERE b.status = 'confirmed'
GROUP BY p.property_id, p.name, p.location
ORDER BY total_revenue DESC;
```

### 3. Date Range Queries
```sql
-- Query to monitor
SELECT 
    DATE_TRUNC('month', start_date) as month,
    COUNT(*) as booking_count,
    SUM(total_price) as revenue
FROM bookings
WHERE start_date >= '2024-01-01'
  AND start_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY month;

-- Performance analysis
EXPLAIN ANALYZE
SELECT 
    DATE_TRUNC('month', start_date) as month,
    COUNT(*) as booking_count,
    SUM(total_price) as revenue
FROM bookings
WHERE start_date >= '2024-01-01'
  AND start_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY month;
```

## Bottleneck Identification

### Common Performance Issues

1. **Sequential Scans**
   - **Issue**: Full table scans instead of index usage
   - **Solution**: Create appropriate indexes
   - **Detection**: Look for "Seq Scan" in EXPLAIN output

2. **Inefficient Joins**
   - **Issue**: Nested loops instead of hash/merge joins
   - **Solution**: Optimize join conditions and indexes
   - **Detection**: Check join types in execution plan

3. **Sorting Operations**
   - **Issue**: Large sort operations in memory
   - **Solution**: Use indexed ORDER BY columns
   - **Detection**: Look for "Sort" operations in plan

4. **Aggregation Bottlenecks**
   - **Issue**: Large GROUP BY operations
   - **Solution**: Pre-aggregate data or use materialized views
   - **Detection**: Check for "HashAggregate" or "GroupAggregate"

## Performance Improvements

### 1. Index Optimization

```sql
-- Composite indexes for common query patterns
CREATE INDEX idx_bookings_user_status_date ON bookings(user_id, status, start_date);
CREATE INDEX idx_properties_location_price ON properties(location, price_per_night);
CREATE INDEX idx_reviews_property_rating ON reviews(property_id, rating);

-- Partial indexes for filtered queries
CREATE INDEX idx_bookings_confirmed_only ON bookings(user_id, start_date) 
WHERE status = 'confirmed';

-- Expression indexes for computed columns
CREATE INDEX idx_bookings_month ON bookings(DATE_TRUNC('month', start_date));
```

### 2. Query Optimization

```sql
-- Before: Inefficient query
SELECT * FROM bookings b
LEFT JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2024-01-01';

-- After: Optimized query
SELECT b.booking_id, b.start_date, b.total_price,
       u.first_name, u.last_name,
       p.name as property_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2024-01-01'
  AND b.status IN ('confirmed', 'pending')
ORDER BY b.start_date;
```

### 3. Schema Adjustments

```sql
-- Add computed columns for frequently accessed data
ALTER TABLE properties ADD COLUMN avg_rating DECIMAL(3,2);
ALTER TABLE properties ADD COLUMN booking_count INTEGER DEFAULT 0;

-- Create materialized views for complex aggregations
CREATE MATERIALIZED VIEW property_stats AS
SELECT 
    property_id,
    COUNT(booking_id) as total_bookings,
    AVG(rating) as avg_rating,
    SUM(total_price) as total_revenue
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON p.property_id = r.property_id
GROUP BY property_id;

-- Refresh materialized view
REFRESH MATERIALIZED VIEW property_stats;
```

## Monitoring Dashboard Queries

### 1. Performance Metrics
```sql
-- Query execution time trends
SELECT 
    query,
    mean_time,
    calls,
    total_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Index usage statistics
SELECT 
    indexrelname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
WHERE idx_scan > 0
ORDER BY idx_scan DESC;
```

### 2. Resource Usage
```sql
-- Table sizes and growth
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) as table_size,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - 
                   pg_relation_size(schemaname||'.'||tablename)) as index_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

## Implementation Checklist

### Before Optimization
- [ ] Identify slow queries using EXPLAIN ANALYZE
- [ ] Document current performance metrics
- [ ] Establish baseline measurements
- [ ] Identify most critical queries

### During Optimization
- [ ] Create necessary indexes
- [ ] Optimize query structure
- [ ] Test changes in development environment
- [ ] Measure performance improvements

### After Optimization
- [ ] Monitor performance in production
- [ ] Document improvements achieved
- [ ] Set up regular performance monitoring
- [ ] Plan for future optimizations

## Best Practices

1. **Regular Monitoring**: Set up automated performance monitoring
2. **Incremental Changes**: Make small, testable improvements
3. **Documentation**: Keep detailed records of all optimizations
4. **Testing**: Always test changes in development first
5. **Backup Strategy**: Ensure data safety before major changes

## Conclusion

Effective database performance monitoring and refinement requires:

- **Systematic Approach**: Regular monitoring and analysis
- **Proper Tools**: Use EXPLAIN ANALYZE and other profiling tools
- **Incremental Improvements**: Make small, measurable changes
- **Documentation**: Keep detailed records of all optimizations
- **Continuous Learning**: Stay updated with best practices

This monitoring and refinement process should be ongoing, with regular reviews and adjustments based on changing usage patterns and performance requirements. 