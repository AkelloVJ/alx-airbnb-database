-- Database Index Optimization Script
-- This script creates indexes for high-usage columns and measures performance

-- Performance measurement queries with EXPLAIN ANALYZE
-- Test queries before adding indexes

-- 1. Test user lookup by email (before index)
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'john.smith@email.com';

-- 2. Test booking lookup by user_id (before index)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = '550e8400-e29b-41d4-a716-446655440002';

-- 3. Test property lookup by host_id (before index)
EXPLAIN ANALYZE
SELECT * FROM properties WHERE host_id = '550e8400-e29b-41d4-a716-446655440001';

-- 4. Test booking lookup by status (before index)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE status = 'confirmed';

-- 5. Test booking lookup by date range (before index)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date >= '2024-01-01' AND end_date <= '2024-12-31';

-- CREATE INDEX commands for high-usage columns
-- Indexes for User table
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- Indexes for Property table
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price_per_night ON properties(price_per_night);

-- Indexes for Booking table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- Performance measurement queries with EXPLAIN ANALYZE
-- Test queries after adding indexes

-- 1. Test user lookup by email (after index)
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'john.smith@email.com';

-- 2. Test booking lookup by user_id (after index)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = '550e8400-e29b-41d4-a716-446655440002';

-- 3. Test property lookup by host_id (after index)
EXPLAIN ANALYZE
SELECT * FROM properties WHERE host_id = '550e8400-e29b-41d4-a716-446655440001';

-- 4. Test booking lookup by status (after index)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE status = 'confirmed';

-- 5. Test booking lookup by date range (after index)
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date >= '2024-01-01' AND end_date <= '2024-12-31';

-- Performance comparison queries
-- Compare execution times and query plans

-- Example: Complex query with joins (before and after indexes)
EXPLAIN ANALYZE
SELECT 
    u.first_name,
    u.last_name,
    p.name as property_name,
    b.start_date,
    b.total_price
FROM users u
JOIN bookings b ON u.user_id = b.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
  AND b.start_date >= '2024-01-01'
ORDER BY b.total_price DESC; 