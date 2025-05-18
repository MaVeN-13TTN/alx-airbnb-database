-- Advanced SQL Subqueries

-- 1. Non-correlated subquery: Find all properties where the average rating is greater than 4.0
-- This query first calculates the average rating for each property in a subquery
-- Then it selects properties where this average is greater than 4.0
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

-- Alternative implementation using a non-correlated subquery
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

-- 2. Correlated subquery: Find users who have made more than 3 bookings
-- This query uses a correlated subquery to count the number of bookings for each user
-- It then filters to only show users with more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) AS booking_count
FROM 
    User u
WHERE 
    (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) > 3
ORDER BY 
    booking_count DESC;

-- Alternative implementation using a JOIN and GROUP BY
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
