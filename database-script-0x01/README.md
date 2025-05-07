# AirBnB Clone Database Schema

This directory contains the SQL scripts to create the database schema for the AirBnB clone application. The schema is designed according to the Third Normal Form (3NF) to ensure data integrity and minimize redundancy.

## Schema Overview

The database consists of seven tables:

1. **User**: Stores user information including guests, hosts, and administrators
2. **Location**: Stores location information (city, state, country)
3. **Property**: Stores property listings with references to host and location
4. **Booking**: Stores booking information with references to property and user
5. **Payment**: Stores payment information with reference to booking
6. **Review**: Stores property reviews with references to property and user
7. **Message**: Stores messages between users

## Entity Relationship Diagram

```mermaid
erDiagram
    User {
        CHAR(36) user_id PK
        VARCHAR(50) first_name
        VARCHAR(50) last_name
        VARCHAR(100) email UK
        VARCHAR(255) password_hash
        VARCHAR(20) phone_number
        VARCHAR(10) role
        TIMESTAMP created_at
    }
    Location {
        CHAR(36) location_id PK
        VARCHAR(100) city
        VARCHAR(100) state
        VARCHAR(100) country
    }
    Property {
        CHAR(36) property_id PK
        CHAR(36) host_id FK
        CHAR(36) location_id FK
        VARCHAR(100) name
        TEXT description
        VARCHAR(255) street_address
        VARCHAR(20) zip_code
        DECIMAL(10,2) pricepernight
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    Booking {
        CHAR(36) booking_id PK
        CHAR(36) property_id FK
        CHAR(36) user_id FK
        DATE start_date
        DATE end_date
        DECIMAL(10,2) total_price
        VARCHAR(10) status
        TIMESTAMP created_at
    }
    Payment {
        CHAR(36) payment_id PK
        CHAR(36) booking_id FK
        DECIMAL(10,2) amount
        TIMESTAMP payment_date
        VARCHAR(20) payment_method
    }
    Review {
        CHAR(36) review_id PK
        CHAR(36) property_id FK
        CHAR(36) user_id FK
        INTEGER rating
        TEXT comment
        TIMESTAMP created_at
    }
    Message {
        CHAR(36) message_id PK
        CHAR(36) sender_id FK
        CHAR(36) recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }
    User ||--o{ Property : hosts
    Location ||--o{ Property : has
    User ||--o{ Booking : makes
    Property ||--o{ Booking : has
    Booking ||--|| Payment : has
    User ||--o{ Review : writes
    Property ||--o{ Review : receives
    User ||--o{ Message : sends
    User ||--o{ Message : receives
```

## Data Types and Constraints

### Primary Keys
- All tables use CHAR(36) for primary keys to store UUIDs

### Foreign Keys
- Appropriate foreign key constraints with ON DELETE actions:
  - CASCADE: When a parent record is deleted, related child records are also deleted
  - RESTRICT: Prevents deletion of a parent record if child records exist

### Check Constraints
- Role values in User table are restricted to 'guest', 'host', 'admin'
- Status values in Booking table are restricted to 'pending', 'confirmed', 'canceled'
- Payment method values in Payment table are restricted to 'credit_card', 'paypal', 'stripe'
- Rating values in Review table are restricted to integers between 1 and 5
- Price values must be greater than 0
- End date must be after start date in Booking table
- A user cannot send a message to themselves

### Unique Constraints
- Email in User table must be unique
- City, state, country combination in Location table must be unique
- A user can only review a property once
- A booking can only have one payment

## Indexes

Indexes are created on columns that are frequently used in WHERE clauses, JOIN conditions, and ORDER BY clauses:

- User table: email, role
- Property table: host_id, location_id, pricepernight
- Booking table: property_id, user_id, start_date/end_date, status
- Payment table: booking_id, payment_method
- Review table: property_id, user_id, rating
- Message table: sender_id, recipient_id, sent_at

## Triggers

- A trigger is created to automatically update the `updated_at` timestamp in the Property table whenever a property is updated

## Usage

To create the database schema, run the following command:

```bash
sqlite3 airbnb.db < schema.sql
```

This will create a new SQLite database file named `airbnb.db` with the schema defined in `schema.sql`.

## Notes

- The schema uses SQLite syntax, which may differ slightly from other database systems
- UUID generation is not handled by the database and should be implemented in the application layer
- The `updated_at` timestamp for the Property table is automatically updated using a trigger
- All tables have appropriate indexes for optimal query performance
