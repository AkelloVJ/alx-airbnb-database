-- Create partitioned booking table based on start_date
-- This assumes we're working with a large booking table

-- Step 1: Create the partitioned table structure
CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (start_date < end_date),
    CONSTRAINT chk_total_price CHECK (total_price > 0)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for different date ranges
-- 2024 partitions
CREATE TABLE bookings_2024_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE bookings_2024_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE bookings_2024_q3 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE bookings_2024_q4 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- 2025 partitions
CREATE TABLE bookings_2025_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE bookings_2025_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

-- Default partition for future dates
CREATE TABLE bookings_future PARTITION OF bookings_partitioned
    DEFAULT;

-- Step 3: Create indexes on partitioned table
CREATE INDEX idx_bookings_partitioned_user_id ON bookings_partitioned(user_id);
CREATE INDEX idx_bookings_partitioned_property_id ON bookings_partitioned(property_id);
CREATE INDEX idx_bookings_partitioned_status ON bookings_partitioned(status);
CREATE INDEX idx_bookings_partitioned_dates ON bookings_partitioned(start_date, end_date);

-- Step 4: Sample queries to test partitioning performance

-- Query 1: Find bookings in a specific date range (should use partition pruning)
SELECT 
    booking_id,
    start_date,
    end_date,
    total_price,
    status
FROM bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY start_date;

-- Query 2: Find all bookings for a specific user in 2024 Q1
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    p.name AS property_name
FROM bookings_partitioned b
JOIN properties p ON b.property_id = p.property_id
WHERE b.user_id = '550e8400-e29b-41d4-a716-446655440002'
  AND b.start_date >= '2024-01-01' 
  AND b.start_date < '2024-04-01';

-- Query 3: Count bookings by quarter
SELECT 
    CASE 
        WHEN start_date >= '2024-01-01' AND start_date < '2024-04-01' THEN '2024 Q1'
        WHEN start_date >= '2024-04-01' AND start_date < '2024-07-01' THEN '2024 Q2'
        WHEN start_date >= '2024-07-01' AND start_date < '2024-10-01' THEN '2024 Q3'
        WHEN start_date >= '2024-10-01' AND start_date < '2025-01-01' THEN '2024 Q4'
        ELSE 'Other'
    END AS quarter,
    COUNT(*) as booking_count,
    SUM(total_price) as total_revenue
FROM bookings_partitioned
WHERE start_date >= '2024-01-01'
GROUP BY quarter
ORDER BY quarter; 