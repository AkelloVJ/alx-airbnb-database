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

-- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CASE 
        WHEN b.booking_id IS NULL THEN 'No bookings'
        WHEN u.user_id IS NULL THEN 'Orphaned booking'
        ELSE 'Valid booking'
    END AS booking_status
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id
ORDER BY u.user_id, b.start_date; 