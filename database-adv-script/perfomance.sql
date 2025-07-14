-- Initial complex query that retrieves all bookings along with user details, property details, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM bookings b
LEFT JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31'
ORDER BY b.created_at DESC;

-- Analyze the query's performance using EXPLAIN and identify inefficiencies
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM bookings b
LEFT JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31'
ORDER BY b.created_at DESC;

-- Optimized version (with selective columns and better joins)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.amount,
    pay.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status IN ('confirmed', 'pending') AND b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31'
ORDER BY b.start_date DESC;

-- Analyze the optimized query's performance
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.amount,
    pay.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status IN ('confirmed', 'pending') AND b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31'
ORDER BY b.start_date DESC; 