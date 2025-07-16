-- 1. Find the total number of bookings made by each user
-- Using COUNT function and GROUP BY clause
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- 2. Rank properties based on the total number of bookings they have received
-- Using RANK() window function
SELECT 
    property_id, 
    name, 
    total_bookings, 
    RANK() OVER (ORDER BY total_bookings DESC) AS property_rank
FROM (
    SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN bookings b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
) ranked_properties;

-- 3. Use ROW_NUMBER() to assign sequential row numbers to properties based on booking count
SELECT 
    property_id, 
    name, 
    total_bookings, 
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number
FROM (
    SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN bookings b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
) ranked_properties; 