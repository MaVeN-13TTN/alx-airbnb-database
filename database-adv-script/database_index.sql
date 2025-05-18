-- Advanced SQL Indexes for Optimization
-- This script creates additional indexes to improve query performance and measures their impact

-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Part 1: Measure query performance BEFORE adding indexes
-- ======================================================

-- Query 1: Find all bookings for a specific user
EXPLAIN QUERY PLAN
SELECT b.*, p.name
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7';

-- Query 2: Find properties with an average rating greater than 4.0
EXPLAIN QUERY PLAN
SELECT
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating
FROM
    Property p
WHERE
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) > 4.0
ORDER BY
    average_rating DESC;

-- Query 3: Find available properties for specific dates
EXPLAIN QUERY PLAN
SELECT p.*
FROM Property p
WHERE p.property_id NOT IN (
    SELECT b.property_id
    FROM Booking b
    WHERE (b.start_date <= '2023-07-15' AND b.end_date >= '2023-07-10')
    AND b.status != 'canceled'
);

-- Query 4: Find users who have made more than 3 bookings
EXPLAIN QUERY PLAN
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS booking_count
FROM
    User u
JOIN
    Booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email, u.role
HAVING
    COUNT(b.booking_id) > 3
ORDER BY
    booking_count DESC;

-- Query 5: Rank properties based on the total number of bookings
EXPLAIN QUERY PLAN
SELECT
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM
    Property p
LEFT JOIN
    Booking b ON p.property_id = b.property_id
GROUP BY
    p.property_id, p.name, p.description, p.pricepernight
ORDER BY
    total_bookings DESC, p.name;

-- Part 2: Create additional indexes
-- ================================

-- User table additional indexes
-- Index on first_name and last_name for user search and sorting
CREATE INDEX IF NOT EXISTS idx_user_name ON User(first_name, last_name);

-- Index on created_at for user registration date filtering and sorting
CREATE INDEX IF NOT EXISTS idx_user_created_at ON User(created_at);

-- Property table additional indexes
-- Composite index on name for property search and sorting
CREATE INDEX IF NOT EXISTS idx_property_name ON Property(name);

-- Index on created_at and updated_at for property listing date filtering and sorting
CREATE INDEX IF NOT EXISTS idx_property_dates ON Property(created_at, updated_at);

-- Composite index on location_id and pricepernight for filtering properties by location and price range
CREATE INDEX IF NOT EXISTS idx_property_location_price ON Property(location_id, pricepernight);

-- Booking table additional indexes
-- Composite index on user_id and status for filtering user bookings by status
CREATE INDEX IF NOT EXISTS idx_booking_user_status ON Booking(user_id, status);

-- Composite index on property_id and status for filtering property bookings by status
CREATE INDEX IF NOT EXISTS idx_booking_property_status ON Booking(property_id, status);

-- Index on created_at for booking date filtering and sorting
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON Booking(created_at);

-- Composite index on start_date, end_date, and status for availability searches
CREATE INDEX IF NOT EXISTS idx_booking_availability ON Booking(start_date, end_date, status);

-- Review table additional indexes
-- Composite index on property_id and rating for property rating filtering and sorting
CREATE INDEX IF NOT EXISTS idx_review_property_rating ON Review(property_id, rating);

-- Index on created_at for review date filtering and sorting
CREATE INDEX IF NOT EXISTS idx_review_created_at ON Review(created_at);

-- Location table indexes
-- Indexes on city, state, and country for location filtering
CREATE INDEX IF NOT EXISTS idx_location_city ON Location(city);
CREATE INDEX IF NOT EXISTS idx_location_state ON Location(state);
CREATE INDEX IF NOT EXISTS idx_location_country ON Location(country);

-- Payment table additional indexes
-- Index on payment_date for payment date filtering and sorting
CREATE INDEX IF NOT EXISTS idx_payment_date ON Payment(payment_date);

-- Composite index on booking_id and payment_method
CREATE INDEX IF NOT EXISTS idx_payment_booking_method ON Payment(booking_id, payment_method);

-- Message table additional indexes
-- Composite index for conversation queries (finding messages between two users)
CREATE INDEX IF NOT EXISTS idx_message_conversation ON Message(sender_id, recipient_id);

-- Index on sent_at for message date filtering and sorting
CREATE INDEX IF NOT EXISTS idx_message_sent_at_detailed ON Message(sent_at DESC);

-- Part 3: Measure query performance AFTER adding indexes
-- ====================================================

-- Query 1: Find all bookings for a specific user (after indexing)
EXPLAIN QUERY PLAN
SELECT b.*, p.name
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7';

-- Query 2: Find properties with an average rating greater than 4.0 (after indexing)
EXPLAIN QUERY PLAN
SELECT
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating
FROM
    Property p
WHERE
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) > 4.0
ORDER BY
    average_rating DESC;

-- Query 3: Find available properties for specific dates (after indexing)
EXPLAIN QUERY PLAN
SELECT p.*
FROM Property p
WHERE p.property_id NOT IN (
    SELECT b.property_id
    FROM Booking b
    WHERE (b.start_date <= '2023-07-15' AND b.end_date >= '2023-07-10')
    AND b.status != 'canceled'
);

-- Query 4: Find users who have made more than 3 bookings (after indexing)
EXPLAIN QUERY PLAN
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS booking_count
FROM
    User u
JOIN
    Booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email, u.role
HAVING
    COUNT(b.booking_id) > 3
ORDER BY
    booking_count DESC;

-- Query 5: Rank properties based on the total number of bookings (after indexing)
EXPLAIN QUERY PLAN
SELECT
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM
    Property p
LEFT JOIN
    Booking b ON p.property_id = b.property_id
GROUP BY
    p.property_id, p.name, p.description, p.pricepernight
ORDER BY
    total_bookings DESC, p.name;
