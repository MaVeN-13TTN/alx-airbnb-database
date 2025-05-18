-- Advanced SQL Aggregations and Window Functions

-- 1. Find the total number of bookings made by each user
-- This query uses COUNT function and GROUP BY clause to count bookings per user
-- It joins with the User table to include user details in the results
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email, u.role
ORDER BY 
    total_bookings DESC, u.first_name, u.last_name;

-- 2. Rank properties based on the total number of bookings they have received
-- This query uses the ROW_NUMBER() window function to assign a unique rank to each property
-- Properties with the same number of bookings will have different ranks
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.description, p.pricepernight
ORDER BY 
    total_bookings DESC, p.name;

-- 3. Rank properties based on the total number of bookings they have received (using RANK)
-- This query uses the RANK() window function to assign ranks to properties
-- Properties with the same number of bookings will have the same rank
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

-- 4. Rank properties based on the total number of bookings they have received (using DENSE_RANK)
-- This query uses the DENSE_RANK() window function to assign ranks to properties
-- Properties with the same number of bookings will have the same rank
-- Unlike RANK(), DENSE_RANK() doesn't leave gaps in the ranking sequence
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.pricepernight,
    COUNT(b.booking_id) AS total_bookings,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.description, p.pricepernight
ORDER BY 
    total_bookings DESC, p.name;

-- 5. Rank properties by number of bookings within each location
-- This query uses window functions with PARTITION BY to rank properties within each location
SELECT 
    l.city,
    l.state,
    l.country,
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (PARTITION BY l.location_id ORDER BY COUNT(b.booking_id) DESC) AS location_rank
FROM 
    Property p
JOIN 
    Location l ON p.location_id = l.location_id
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    l.city, l.state, l.country, p.property_id, p.name
ORDER BY 
    l.country, l.state, l.city, location_rank;
