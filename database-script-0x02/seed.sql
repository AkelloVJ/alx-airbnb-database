-- Airbnb Clone Database Seed Data
-- This script populates the database with realistic sample data

-- Insert Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Smith', 'john.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0101', 'host'),
('550e8400-e29b-41d4-a716-446655440002', 'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0102', 'guest'),
('550e8400-e29b-41d4-a716-446655440003', 'Michael', 'Brown', 'michael.brown@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0103', 'host'),
('550e8400-e29b-41d4-a716-446655440004', 'Emily', 'Davis', 'emily.davis@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0104', 'guest'),
('550e8400-e29b-41d4-a716-446655440005', 'David', 'Wilson', 'david.wilson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0105', 'host'),
('550e8400-e29b-41d4-a716-446655440006', 'Lisa', 'Anderson', 'lisa.anderson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0106', 'guest'),
('550e8400-e29b-41d4-a716-446655440007', 'Robert', 'Taylor', 'robert.taylor@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0107', 'admin'),
('550e8400-e29b-41d4-a716-446655440008', 'Jennifer', 'Martinez', 'jennifer.martinez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0108', 'host'),
('550e8400-e29b-41d4-a716-446655440009', 'Christopher', 'Garcia', 'christopher.garcia@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0109', 'guest'),
('550e8400-e29b-41d4-a716-446655440010', 'Amanda', 'Rodriguez', 'amanda.rodriguez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbQJ8qKGi', '+1-555-0110', 'host');

-- Insert Properties
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night) VALUES
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Apartment', 'Beautiful 2-bedroom apartment in the heart of downtown. Walking distance to restaurants, shops, and public transportation.', 'Downtown, City Center', 150.00),
('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', 'Luxury Beach House', 'Stunning beachfront property with ocean views. 3 bedrooms, 2 bathrooms, private beach access.', 'Beachfront, Coastal Area', 350.00),
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005', 'Mountain Cabin Retreat', 'Peaceful mountain cabin with scenic views. Perfect for nature lovers and outdoor enthusiasts.', 'Mountain View, Highlands', 200.00),
('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440008', 'Modern City Loft', 'Contemporary loft with high ceilings and modern amenities. Located in the trendy arts district.', 'Arts District, Downtown', 180.00),
('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010', 'Historic Townhouse', 'Charming historic townhouse with original features. 4 bedrooms, garden, and parking included.', 'Historic District, Old Town', 250.00),
('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Riverside Cottage', 'Quaint cottage by the river with fishing access. Perfect for a relaxing getaway.', 'Riverside, Countryside', 120.00),
('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', 'Ski Resort Condo', 'Ski-in/ski-out condo with mountain views. Fully equipped kitchen and fireplace.', 'Ski Resort, Mountains', 280.00),
('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440008', 'Urban Garden Studio', 'Bright studio apartment with private garden. Perfect for solo travelers or couples.', 'Garden District, Suburbs', 95.00);

-- Insert Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '2024-01-15', '2024-01-20', 750.00, 'confirmed'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', '2024-02-10', '2024-02-15', 1750.00, 'confirmed'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440006', '2024-03-05', '2024-03-10', 1000.00, 'pending'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', '2024-01-25', '2024-01-30', 900.00, 'confirmed'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002', '2024-02-20', '2024-02-25', 1250.00, 'canceled'),
('770e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440004', '2024-03-15', '2024-03-20', 600.00, 'confirmed'),
('770e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440006', '2024-02-05', '2024-02-10', 1400.00, 'confirmed'),
('770e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440009', '2024-01-30', '2024-02-02', 285.00, 'pending');

-- Insert Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 750.00, 'credit_card'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 1750.00, 'stripe'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440004', 900.00, 'paypal'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440006', 600.00, 'credit_card'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440007', 1400.00, 'stripe');

-- Insert Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 5, 'Excellent location and very clean apartment. The host was very responsive and helpful. Would definitely recommend!'),
('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', 4, 'Beautiful beach house with amazing ocean views. The property was well-maintained and had everything we needed.'),
('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 5, 'Perfect loft in a great neighborhood. Modern amenities and comfortable space. Highly recommend!'),
('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440004', 4, 'Peaceful cottage with beautiful river views. Great for a relaxing weekend getaway.'),
('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440006', 5, 'Amazing ski condo with perfect location. The views were spectacular and the amenities were top-notch.'),
('990e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440009', 3, 'Nice studio with garden access. The space was a bit small but clean and well-located.'),
('990e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 4, 'Cozy mountain cabin with great hiking trails nearby. Perfect for nature lovers.'),
('990e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440004', 5, 'Charming historic townhouse with character. The garden was beautiful and the location was perfect.');

-- Insert Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Hi! I have a question about check-in time for the downtown apartment.'),
('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Hello! Check-in is at 3 PM. I can arrange early check-in if needed.'),
('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', 'Is parking available at the beach house?'),
('aa0e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', 'Yes, there are 2 parking spots included with the rental.'),
('aa0e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005', 'What activities are available near the mountain cabin?'),
('aa0e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440006', 'There are hiking trails, fishing spots, and scenic viewpoints nearby.'),
('aa0e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440008', 'Is the loft pet-friendly?'),
('aa0e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440009', 'Yes, pets are welcome with a small additional fee.'),
('aa0e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440002', 'What is the cancellation policy for the townhouse?'),
('aa0e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', 'Full refund if canceled 7 days before check-in.');

-- Display sample queries to verify data
SELECT 'Users count:' as info, COUNT(*) as count FROM users
UNION ALL
SELECT 'Properties count:', COUNT(*) FROM properties
UNION ALL
SELECT 'Bookings count:', COUNT(*) FROM bookings
UNION ALL
SELECT 'Payments count:', COUNT(*) FROM payments
UNION ALL
SELECT 'Reviews count:', COUNT(*) FROM reviews
UNION ALL
SELECT 'Messages count:', COUNT(*) FROM messages;
