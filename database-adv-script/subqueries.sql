-- 1. Find all properties where the average rating is greater than 4.0 (non-correlated subquery)
SELECT p.*
FROM properties p
WHERE (
    SELECT AVG(r.rating)
    FROM reviews r
    WHERE r.property_id = p.property_id
) > 4.0;

-- 2. Find users who have made more than 3 bookings (correlated subquery)
SELECT u.*
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;