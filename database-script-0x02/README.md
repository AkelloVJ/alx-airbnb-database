# Airbnb Clone Database Seed Data

## Overview

This directory contains the SQL seed data for populating the Airbnb clone database with realistic sample data. The seed data simulates a real-world vacation rental platform with users, properties, bookings, payments, reviews, and messages.

## Data Overview

### Sample Data Included

1. **Users (10 records)**
   - Mix of hosts, guests, and admin users
   - Realistic names, emails, and phone numbers
   - Different user roles for testing various scenarios

2. **Properties (8 records)**
   - Diverse property types (apartments, houses, cabins, lofts)
   - Various locations and price points
   - Detailed descriptions for realistic listings

3. **Bookings (8 records)**
   - Different booking statuses (confirmed, pending, canceled)
   - Realistic date ranges and pricing
   - Links between users and properties

4. **Payments (5 records)**
   - Multiple payment methods (credit_card, paypal, stripe)
   - Various payment amounts
   - Linked to confirmed bookings

5. **Reviews (8 records)**
   - Ratings from 1-5 stars
   - Detailed, realistic comments
   - Covers different properties and experiences

6. **Messages (10 records)**
   - User-to-user communication
   - Questions about properties and bookings
   - Host responses to guest inquiries

## Data Characteristics

### Realistic Scenarios
- **Host-Guest Interactions**: Messages between hosts and potential guests
- **Booking Workflows**: Complete booking lifecycle from pending to confirmed
- **Payment Processing**: Multiple payment methods and amounts
- **Review System**: Honest feedback with varying ratings
- **Property Diversity**: Different types, locations, and price points

### Data Integrity
- **Foreign Key Relationships**: All relationships properly maintained
- **Realistic UUIDs**: Consistent UUID format across all tables
- **Date Consistency**: Logical date sequences for bookings
- **Price Validation**: Realistic pricing based on property types

## Usage

### Prerequisites
1. Ensure the database schema is created first (run `schema.sql`)
2. Have PostgreSQL or compatible database running

### Running the Seed Data
```sql
-- Connect to your database
\c your_database_name

-- Run the seed file
\i seed.sql
```

### Verification Queries
After running the seed data, you can verify the data with these queries:

```sql
-- Check record counts
SELECT 'Users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'Properties', COUNT(*) FROM properties
UNION ALL
SELECT 'Bookings', COUNT(*) FROM bookings
UNION ALL
SELECT 'Payments', COUNT(*) FROM payments
UNION ALL
SELECT 'Reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'Messages', COUNT(*) FROM messages;

-- Sample queries for testing relationships
SELECT 
    u.first_name, 
    u.last_name, 
    p.name as property_name,
    b.status,
    b.total_price
FROM users u
JOIN bookings b ON u.user_id = b.user_id
JOIN properties p ON b.property_id = p.property_id
LIMIT 5;

-- Check reviews with property details
SELECT 
    p.name as property_name,
    r.rating,
    r.comment,
    u.first_name as reviewer_name
FROM reviews r
JOIN properties p ON r.property_id = p.property_id
JOIN users u ON r.user_id = u.user_id
ORDER BY r.rating DESC;
```

## Data Relationships

### User Types
- **Hosts**: Users who own properties (John Smith, Michael Brown, David Wilson, Jennifer Martinez, Amanda Rodriguez)
- **Guests**: Users who book properties (Sarah Johnson, Emily Davis, Lisa Anderson, Christopher Garcia)
- **Admin**: System administrator (Robert Taylor)

### Property Types
- **Urban**: Downtown apartments, city lofts, garden studios
- **Luxury**: Beach houses, historic townhouses
- **Nature**: Mountain cabins, riverside cottages, ski condos

### Booking Statuses
- **Confirmed**: Completed bookings with payments
- **Pending**: Bookings awaiting confirmation
- **Canceled**: Cancelled bookings

## Testing Scenarios

The seed data supports testing of:

1. **User Authentication**: Different user roles and permissions
2. **Property Management**: Host property listings and updates
3. **Booking System**: Complete reservation workflow
4. **Payment Processing**: Multiple payment methods
5. **Review System**: Rating and feedback functionality
6. **Messaging**: Host-guest communication
7. **Search and Filtering**: Property discovery by location, price, type
8. **Admin Functions**: System administration tasks

## Notes

- All passwords are hashed using bcrypt (sample hash provided)
- UUIDs are pre-generated for consistency across relationships
- Dates are set in 2024 for realistic future bookings
- Prices reflect realistic market rates for different property types
- Messages simulate real host-guest interactions
- Reviews include both positive and constructive feedback

## Customization

To modify the seed data:
1. Update the UUIDs to maintain referential integrity
2. Adjust dates for current time periods
3. Modify prices to match your target market
4. Add more diverse property types or locations
5. Include additional user roles or booking statuses
