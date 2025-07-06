# Airbnb Clone Database Schema

## Overview

This directory contains the SQL schema definition for the Airbnb clone database. The schema is designed to support a comprehensive vacation rental platform with user management, property listings, bookings, payments, reviews, and messaging functionality.

## Database Design

### Tables Overview

1. **users** - User account management
2. **properties** - Property listings
3. **bookings** - Reservation management
4. **payments** - Payment processing
5. **reviews** - User reviews and ratings
6. **messages** - User-to-user messaging

### Key Features

- **UUID Primary Keys**: All tables use UUID primary keys for scalability and security
- **Foreign Key Constraints**: Proper referential integrity across all related tables
- **Indexing Strategy**: Optimized indexes for common query patterns
- **Data Validation**: CHECK constraints ensure data integrity
- **Audit Trails**: Timestamp fields for tracking creation and updates

## Schema Details

### Users Table
- Stores user account information
- Supports multiple roles (guest, host, admin)
- Email uniqueness enforced
- Password hashing for security

### Properties Table
- Property listings with host association
- Location and pricing information
- Automatic timestamp tracking

### Bookings Table
- Reservation management with date validation
- Status tracking (pending, confirmed, canceled)
- Price calculation and validation

### Payments Table
- Payment processing with multiple methods
- Links to booking records
- Amount validation

### Reviews Table
- User feedback system
- Rating validation (1-5 scale)
- Property and user associations

### Messages Table
- User-to-user communication
- Sender and recipient tracking
- Timestamp for message ordering

## Performance Optimizations

### Indexes
- Primary key indexes (automatic)
- Foreign key indexes for join performance
- Composite indexes for common query patterns
- Email index for user lookups
- Date range indexes for booking queries

### Constraints
- Foreign key constraints with CASCADE delete
- CHECK constraints for data validation
- UNIQUE constraints where appropriate

## Usage

To create the database schema:

```sql
-- Run the schema file
\i schema.sql
```

## Dependencies

- PostgreSQL with UUID extension
- MySQL/MariaDB compatible syntax (with minor adjustments)

## Notes

- The schema is designed for PostgreSQL but can be adapted for other databases
- UUID generation requires the `uuid-ossp` extension in PostgreSQL
- All timestamps use UTC timezone for consistency
- Foreign key constraints include CASCADE delete for data integrity
