# AirBnB Clone Database Sample Data

This directory contains SQL scripts to populate the AirBnB clone database with realistic sample data for testing and development purposes.

## Overview

The `seed.sql` script inserts sample data into all seven tables of the database:

1. **User**: 7 users with different roles (hosts, guests, admin)
2. **Location**: 7 locations in different cities and countries
3. **Property**: 7 properties of various types and price points
4. **Booking**: 8 bookings with different statuses (confirmed, pending, canceled)
5. **Payment**: 5 payments using different payment methods
6. **Review**: 6 reviews with ratings and comments
7. **Message**: 10 messages between users and hosts

## Sample Data Details

### Users

The sample data includes:
- 2 hosts (John Doe, Emily Williams)
- 4 guests (Jane Smith, Michael Johnson, David Brown, Sarah Davis)
- 1 admin (Admin User)

### Properties

The properties are located in different cities around the world:
- New York, USA
- Los Angeles, USA
- Chicago, USA
- Miami, USA
- London, UK
- Paris, France
- Tokyo, Japan

Property types include apartments, villas, lofts, condos, flats, and studios with prices ranging from $120 to $350 per night.

### Bookings

The bookings span different time periods throughout 2023 and have different statuses:
- 5 confirmed bookings
- 2 pending bookings
- 1 canceled booking

### Payments

Payments are made using different methods:
- Credit card
- PayPal
- Stripe

### Reviews

Reviews include ratings (on a scale of 1-5) and detailed comments about the properties. All properties have at least one review, with some having multiple reviews.

### Messages

The sample data includes conversations between guests and hosts, covering common inquiries about properties such as:
- Availability
- Amenities (BBQ grill, parking, beach towels)
- Location details (proximity to public transportation)

## Data Relationships

The sample data demonstrates the relationships between entities:

1. **User to Property**: Hosts own multiple properties
2. **User to Booking**: Guests make multiple bookings
3. **Property to Booking**: Properties have multiple bookings
4. **Booking to Payment**: Confirmed bookings have payments
5. **User to Review**: Guests write reviews for properties they've booked
6. **Property to Review**: Properties receive multiple reviews
7. **User to Message**: Users send and receive messages

## Usage

To populate the database with sample data, run the following command:

```bash
sqlite3 airbnb.db < seed.sql
```

This assumes you have already created the database schema using the `schema.sql` script from the `database-script-0x01` directory.

## Notes

- All primary keys use UUIDs in the format of CHAR(36)
- The sample data maintains referential integrity with appropriate foreign key relationships
- Timestamps follow the format 'YYYY-MM-DD HH:MM:SS'
- Password hashes are simulated and not actual hashed passwords
- The data is designed to showcase various scenarios and relationships in the AirBnB clone application

## Sample Queries

Here are some example queries you can run to explore the sample data:

### Find all properties in a specific location
```sql
SELECT p.* FROM Property p
JOIN Location l ON p.location_id = l.location_id
WHERE l.city = 'New York';
```

### Get all bookings for a specific user
```sql
SELECT b.*, p.name FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7';
```

### Find the average rating for a property
```sql
SELECT p.name, AVG(r.rating) as average_rating
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id;
```

### Get all messages between a guest and host
```sql
SELECT m.*, u1.first_name as sender_name, u2.first_name as recipient_name
FROM Message m
JOIN User u1 ON m.sender_id = u1.user_id
JOIN User u2 ON m.recipient_id = u2.user_id
WHERE (m.sender_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7' AND m.recipient_id = 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6')
   OR (m.sender_id = 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6' AND m.recipient_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7')
ORDER BY m.sent_at;
```
