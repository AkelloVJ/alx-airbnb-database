# Entity-Relationship Diagram (ERD) Requirements

## Overview

This document outlines the requirements for creating a comprehensive Entity-Relationship Diagram (ERD) for the Airbnb clone database. The ERD should visually represent all entities, their attributes, and relationships in the database design.

## Required Entities

### 1. User Entity
**Primary Attributes:**
- user_id (Primary Key, UUID)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest, host, admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Key Characteristics:**
- Central entity for user management
- Supports multiple user roles
- Email uniqueness constraint
- Password security through hashing

### 2. Property Entity
**Primary Attributes:**
- property_id (Primary Key, UUID)
- host_id (Foreign Key, references User)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- price_per_night (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

**Key Characteristics:**
- Belongs to a host (User)
- Contains property details and pricing
- Tracks creation and update timestamps

### 3. Booking Entity
**Primary Attributes:**
- booking_id (Primary Key, UUID)
- property_id (Foreign Key, references Property)
- user_id (Foreign Key, references User)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending, confirmed, canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Key Characteristics:**
- Links guests to properties
- Tracks booking status and dates
- Calculates total price for stay

### 4. Payment Entity
**Primary Attributes:**
- payment_id (Primary Key, UUID)
- booking_id (Foreign Key, references Booking)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

**Key Characteristics:**
- Links to specific bookings
- Supports multiple payment methods
- Tracks payment amounts and dates

### 5. Review Entity
**Primary Attributes:**
- review_id (Primary Key, UUID)
- property_id (Foreign Key, references Property)
- user_id (Foreign Key, references User)
- rating (INTEGER, CHECK: 1-5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Key Characteristics:**
- User feedback on properties
- Rating system (1-5 stars)
- Links users to properties they've stayed at

### 6. Message Entity
**Primary Attributes:**
- message_id (Primary Key, UUID)
- sender_id (Foreign Key, references User)
- recipient_id (Foreign Key, references User)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Key Characteristics:**
- User-to-user communication
- Tracks sender and recipient
- Timestamps for message ordering

## Required Relationships

### 1. User Relationships
- **User → Property**: One-to-Many (A user can host multiple properties)
- **User → Booking**: One-to-Many (A user can make multiple bookings)
- **User → Review**: One-to-Many (A user can write multiple reviews)
- **User → Message (as sender)**: One-to-Many (A user can send multiple messages)
- **User → Message (as recipient)**: One-to-Many (A user can receive multiple messages)

### 2. Property Relationships
- **Property → Booking**: One-to-Many (A property can have multiple bookings)
- **Property → Review**: One-to-Many (A property can have multiple reviews)

### 3. Booking Relationships
- **Booking → Payment**: One-to-Many (A booking can have multiple payments)

### 4. Cross-Entity Relationships
- **User ↔ User** (through Message): Many-to-Many (Users can message each other)
- **User ↔ Property** (through Booking): Many-to-Many (Users book properties)
- **User ↔ Property** (through Review): Many-to-Many (Users review properties)

## ERD Design Requirements

### Visual Elements
1. **Entity Boxes**: Clearly labeled with entity names
2. **Attribute Lists**: All primary attributes listed within entity boxes
3. **Relationship Lines**: Connect related entities with proper notation
4. **Cardinality Indicators**: Show one-to-many, many-to-many relationships
5. **Primary Keys**: Clearly marked (PK)
6. **Foreign Keys**: Clearly marked (FK)

### Relationship Notation
- Use standard ERD notation (crow's foot, etc.)
- Indicate mandatory vs. optional participation
- Show cardinality (1:1, 1:N, M:N)

### Design Principles
1. **Clarity**: Easy to understand relationships
2. **Completeness**: All entities and relationships included
3. **Accuracy**: Reflect actual database design
4. **Professional Appearance**: Clean, organized layout

## Technical Specifications

### Tools
- **Recommended**: Draw.io (diagrams.net)
- **Alternative**: Lucidchart, Visio, or similar
- **Format**: Export as PNG, PDF, or SVG

### File Requirements
- **Filename**: `airbnb_erd.png` or `airbnb_erd.pdf`
- **Resolution**: High quality for printing and digital viewing
- **Size**: A4 or letter size, landscape orientation recommended

### Documentation
- Include legend explaining notation used
- Add brief description of each entity's purpose
- Note any business rules or constraints

## Validation Checklist

Before submission, ensure the ERD includes:

- [ ] All 6 entities (User, Property, Booking, Payment, Review, Message)
- [ ] All primary attributes for each entity
- [ ] All relationships between entities
- [ ] Proper cardinality notation
- [ ] Primary and foreign key indicators
- [ ] Clear, readable layout
- [ ] Professional appearance
- [ ] Legend or notation explanation

## Business Rules to Represent

1. **User Roles**: Users can be guests, hosts, or admins
2. **Booking Constraints**: Start date must be before end date
3. **Review Constraints**: Rating must be between 1-5
4. **Payment Methods**: Limited to credit_card, paypal, stripe
5. **Booking Status**: Limited to pending, confirmed, canceled
6. **Email Uniqueness**: Each user must have a unique email
7. **Price Validation**: All prices must be positive values

## Submission Guidelines

1. Create the ERD using the specified tool
2. Ensure all requirements are met
3. Export in appropriate format
4. Place file in the ERD/ directory
5. Update this README with any additional notes
6. Verify relationships match the database schema

## Notes

- The ERD should match the database schema exactly
- Focus on clarity and completeness over artistic design
- Use consistent notation throughout
- Consider the audience (developers, stakeholders)
- Include any additional business rules discovered during design
