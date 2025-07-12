# Advanced SQL Scripts for Airbnb Clone Database

This directory contains advanced SQL scripts and documentation for practicing subqueries, aggregations, window functions, query optimization, table partitioning, and performance monitoring on the Airbnb clone database.

## Directory Overview

### Core SQL Practice Files

#### 1. `subqueries.sql`
**Purpose**: Practice writing both correlated and non-correlated subqueries
**Contents**:
- **Non-correlated subquery**: Find properties where average rating > 4.0
- **Correlated subquery**: Find users who have made more than 3 bookings
**Learning Objectives**:
- Understand the difference between correlated and non-correlated subqueries
- Practice subquery syntax and execution
- Learn when to use subqueries vs. joins

#### 2. `aggregations_and_window_functions.sql`
**Purpose**: Practice SQL aggregation and window functions
**Contents**:
- **Aggregation query**: Count total bookings per user using COUNT and GROUP BY
- **Window function query**: Rank properties by total bookings using RANK()
**Learning Objectives**:
- Master GROUP BY with aggregation functions
- Understand window functions for ranking and analysis
- Learn to combine subqueries with window functions

### Performance Optimization Files

#### 3. `perfomance.sql`
**Purpose**: Demonstrate query optimization techniques
**Contents**:
- **Initial query**: Complex query with multiple LEFT JOINs (inefficient)
- **Optimized query**: Refactored with INNER JOINs, selective columns, and filtering
**Learning Objectives**:
- Identify performance bottlenecks in complex queries
- Learn optimization strategies (join types, column selection, filtering)
- Understand the impact of query structure on performance

#### 4. `database_index.sql`
**Purpose**: Create indexes for query performance optimization
**Contents**:
- Indexes for User table (email, role)
- Indexes for Property table (host_id, location, price_per_night)
- Indexes for Booking table (user_id, property_id, status, dates)
**Learning Objectives**:
- Understand which columns need indexing
- Learn index creation strategies
- Practice index optimization techniques

### Documentation and Analysis Files

#### 5. `optimization_report.md`
**Purpose**: Comprehensive analysis of query optimization process
**Contents**:
- Detailed performance issue identification
- Optimization strategies and rationale
- Expected performance improvements
- Additional index recommendations
- Monitoring and testing methodology
**Key Sections**:
- Initial query analysis with EXPLAIN
- Join type optimization (LEFT → INNER)
- Column selection optimization
- WHERE clause addition
- ORDER BY optimization

#### 6. `index_performance.md`
**Purpose**: Guide for measuring index performance impact
**Contents**:
- Step-by-step performance measurement process
- Sample EXPLAIN output analysis
- Performance comparison tables
- Tips for effective index testing
**Learning Objectives**:
- Use EXPLAIN ANALYZE to measure performance
- Compare before/after index performance
- Document performance improvements

### Table Partitioning Files

#### 7. `partitioning.sql`
**Purpose**: Implement table partitioning for large datasets
**Contents**:
- Partitioned booking table structure
- Quarterly partitions (2024 Q1-Q4, 2025 Q1-Q2)
- Indexes on partitioned table
- Sample queries to test partitioning performance
**Learning Objectives**:
- Understand table partitioning concepts
- Implement range partitioning by date
- Test partition pruning effectiveness

#### 8. `partition_performance.md`
**Purpose**: Document partitioning performance improvements
**Contents**:
- Partitioning strategy explanation
- Performance testing methodology
- Expected improvements (50-90% for date queries)
- Monitoring and maintenance guidelines
**Key Benefits**:
- Partition pruning for date-based queries
- Parallel processing capabilities
- Reduced I/O operations
- Better storage efficiency

### Performance Monitoring Files

#### 9. `performance_monitoring.md`
**Purpose**: Comprehensive guide for database performance monitoring
**Contents**:
- Performance monitoring tools (EXPLAIN ANALYZE, SHOW PROFILE)
- Frequently used query analysis
- Bottleneck identification techniques
- Performance improvement strategies
- Monitoring dashboard queries
**Learning Objectives**:
- Use SQL tools for performance analysis
- Identify common performance issues
- Implement monitoring strategies
- Apply optimization techniques

## Usage Instructions

### Getting Started
1. **Prerequisites**: Ensure the database schema is created and populated with sample data
2. **File Order**: Start with basic practice files, then move to optimization
3. **Testing**: Run each SQL file and observe the results
4. **Documentation**: Review the corresponding .md files for detailed explanations

### Practice Sequence
1. **Basic Practice**: Start with `subqueries.sql` and `aggregations_and_window_functions.sql`
2. **Performance Analysis**: Use `perfomance.sql` with `optimization_report.md`
3. **Indexing**: Apply `database_index.sql` and measure with `index_performance.md`
4. **Advanced Optimization**: Study `partitioning.sql` with `partition_performance.md`
5. **Monitoring**: Implement `performance_monitoring.md` strategies

### Testing Methodology
- Run queries before and after optimizations
- Use EXPLAIN ANALYZE to measure performance
- Document improvements in the respective .md files
- Compare execution times and resource usage

## Key Learning Outcomes

### SQL Skills
- **Subqueries**: Correlated vs. non-correlated subqueries
- **Aggregations**: GROUP BY with various aggregation functions
- **Window Functions**: RANK(), ROW_NUMBER() for data analysis
- **Complex Queries**: Multi-table joins and optimizations

### Performance Skills
- **Query Optimization**: Identify and fix performance bottlenecks
- **Indexing**: Create and optimize database indexes
- **Partitioning**: Implement table partitioning for large datasets
- **Monitoring**: Use SQL tools for performance analysis

### Database Management
- **Performance Tuning**: Optimize queries and database structure
- **Monitoring**: Track and analyze database performance
- **Documentation**: Document optimization processes and results
- **Best Practices**: Apply industry-standard optimization techniques

## File Dependencies

- **Schema Required**: All SQL files depend on the database schema from `database-script-0x01/`
- **Sample Data**: Queries assume populated data from `database-script-0x02/`
- **Cross-References**: .md files provide detailed explanations for corresponding .sql files

## Notes

- All queries are designed for PostgreSQL but can be adapted for other databases
- Performance measurements should be conducted on realistic data volumes
- Regular monitoring and maintenance are essential for production environments
- These scripts serve as both learning tools and production-ready optimization examples