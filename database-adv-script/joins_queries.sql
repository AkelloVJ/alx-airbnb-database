-- INNER JOIN to retrieve all bookings and the respective users who made those bookings
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
    u.role
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
ORDER BY b.start_date DESC;

-- Additional INNER JOIN examples for comprehensive booking information
-- Get bookings with user and property details
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
    p.price_per_night
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.status IN ('confirmed', 'pending')
ORDER BY b.start_date DESC;

-- Get bookings with payment information
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC; 