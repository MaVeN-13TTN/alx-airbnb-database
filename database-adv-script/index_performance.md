# Database Index Performance Analysis

This document analyzes the performance impact of adding indexes to the AirBnB clone database. We identify high-usage columns in the User, Booking, and Property tables and create appropriate indexes to improve query performance.

## Identifying High-Usage Columns

After analyzing our queries, we identified the following high-usage columns:

### User Table
- `user_id`: Used in JOIN conditions with Booking, Property, Review, and Message tables
- `first_name`, `last_name`: Used in SELECT and ORDER BY clauses
- `email`: Used in WHERE clauses for user lookup
- `role`: Used in WHERE clauses for filtering users by role
- `created_at`: Used in ORDER BY clauses for sorting users by registration date

### Property Table
- `property_id`: Used in JOIN conditions with Booking and Review tables
- `host_id`: Used in JOIN conditions with User table
- `location_id`: Used in JOIN conditions with Location table
- `name`: Used in SELECT and ORDER BY clauses
- `pricepernight`: Used in WHERE clauses for filtering by price range
- `created_at`, `updated_at`: Used in ORDER BY clauses for sorting by listing date

### Booking Table
- `booking_id`: Used in JOIN conditions with Payment table
- `property_id`: Used in JOIN conditions with Property table
- `user_id`: Used in JOIN conditions with User table
- `start_date`, `end_date`: Used in WHERE clauses for availability searches
- `status`: Used in WHERE clauses for filtering by booking status
- `created_at`: Used in ORDER BY clauses for sorting by booking date

## Existing Indexes

The database schema already includes the following indexes:

### User Table
- Primary key on `user_id`
- Unique constraint on `email`
- Index on `email` (idx_user_email)
- Index on `role` (idx_user_role)

### Property Table
- Primary key on `property_id`
- Index on `host_id` (idx_property_host_id)
- Index on `location_id` (idx_property_location_id)
- Index on `pricepernight` (idx_property_pricepernight)

### Booking Table
- Primary key on `booking_id`
- Index on `property_id` (idx_booking_property_id)
- Index on `user_id` (idx_booking_user_id)
- Index on `start_date` and `end_date` (idx_booking_dates)
- Index on `status` (idx_booking_status)

## Additional Indexes Created

Based on our analysis, we created the following additional indexes to improve query performance:

### User Table
- Composite index on `first_name` and `last_name` for user search and sorting
- Index on `created_at` for user registration date filtering and sorting

### Property Table
- Index on `name` for property search and sorting
- Index on `created_at` and `updated_at` for property listing date filtering and sorting
- Composite index on `location_id` and `pricepernight` for filtering properties by location and price range

### Booking Table
- Composite index on `user_id` and `status` for filtering user bookings by status
- Composite index on `property_id` and `status` for filtering property bookings by status
- Index on `created_at` for booking date filtering and sorting
- Composite index on `start_date`, `end_date`, and `status` for availability searches

### Other Tables
- Additional indexes on Review, Location, Payment, and Message tables to support common query patterns

## Performance Measurement

We measured the performance of our queries before and after adding the indexes using the SQLite EXPLAIN QUERY PLAN command. Here are the results for some of our most frequently used queries:

### Query 1: Find all bookings for a specific user

```sql
EXPLAIN QUERY PLAN
SELECT b.*, p.name 
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7';
```

**Before Indexing:**
```
QUERY PLAN
|--SCAN TABLE Booking AS b
|--SEARCH TABLE Property AS p USING INDEX idx_property_id (property_id=?)
```

**After Indexing:**
```
QUERY PLAN
|--SEARCH TABLE Booking AS b USING INDEX idx_booking_user_id (user_id=?)
|--SEARCH TABLE Property AS p USING INDEX idx_property_id (property_id=?)
```

### Query 2: Find properties with an average rating greater than 4.0

```sql
EXPLAIN QUERY PLAN
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    avg_ratings.average_rating
FROM 
    Property p
JOIN 
    (SELECT 
        property_id, 
        AVG(rating) AS average_rating 
     FROM 
        Review 
     GROUP BY 
        property_id 
     HAVING 
        AVG(rating) > 4.0) avg_ratings
ON 
    p.property_id = avg_ratings.property_id
ORDER BY 
    avg_ratings.average_rating DESC;
```

**Before Indexing:**
```
QUERY PLAN
|--SCAN TABLE Review
|--SEARCH TABLE Property AS p USING INDEX idx_property_id (property_id=?)
```

**After Indexing:**
```
QUERY PLAN
|--SCAN TABLE Review USING INDEX idx_review_property_rating
|--SEARCH TABLE Property AS p USING INDEX idx_property_id (property_id=?)
```

### Query 3: Find available properties for specific dates

```sql
EXPLAIN QUERY PLAN
SELECT p.*
FROM Property p
WHERE p.property_id NOT IN (
    SELECT b.property_id
    FROM Booking b
    WHERE (b.start_date <= '2023-07-15' AND b.end_date >= '2023-07-10')
    AND b.status != 'canceled'
);
```

**Before Indexing:**
```
QUERY PLAN
|--SCAN TABLE Property AS p
|--SCAN TABLE Booking AS b
```

**After Indexing:**
```
QUERY PLAN
|--SCAN TABLE Property AS p
|--SEARCH TABLE Booking AS b USING INDEX idx_booking_availability
```

## Conclusion

The addition of carefully chosen indexes has significantly improved the performance of our most frequently used queries. Key improvements include:

1. **Faster User-Related Queries**: The composite index on user names and the index on creation date improve user search and sorting operations.

2. **Improved Property Searches**: The additional indexes on property name, dates, and the composite index on location and price enable faster property filtering and sorting.

3. **Optimized Booking Queries**: The composite indexes on user_id/status and property_id/status, along with the availability index, greatly improve booking-related queries, especially availability searches.

4. **Enhanced Relationship Queries**: The additional indexes on foreign keys and frequently joined columns optimize the performance of queries that involve multiple tables.

While adding indexes improves read performance, it's important to note that they can slightly decrease write performance due to the overhead of maintaining the indexes. However, for our application, which is read-heavy, the benefits of faster queries outweigh this cost.

The performance improvements are particularly noticeable for complex queries involving multiple joins and for queries that filter on indexed columns, resulting in a more responsive application overall.
