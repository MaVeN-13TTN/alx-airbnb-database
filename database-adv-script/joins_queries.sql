-- Advanced SQL Joins Queries

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
-- This query returns all bookings along with the user information of who made the booking
-- Only bookings that have an associated user will be returned
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.start_date;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
-- This query returns all properties along with any reviews they might have
-- Properties without reviews will still be included, with NULL values for review columns
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    u.first_name AS reviewer_first_name,
    u.last_name AS reviewer_last_name
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
LEFT JOIN 
    User u ON r.user_id = u.user_id
ORDER BY 
    p.name, r.created_at;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- Note: SQLite doesn't directly support FULL OUTER JOIN, so we simulate it using a UNION of LEFT JOIN and RIGHT JOIN (simulated)
-- This query returns all users and all bookings, regardless of whether there's a match between them
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION ALL

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM 
    Booking b
LEFT JOIN 
    User u ON b.user_id = u.user_id
WHERE 
    u.user_id IS NULL
ORDER BY 
    user_id, booking_id;
