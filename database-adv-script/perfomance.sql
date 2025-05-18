-- Initial Complex Query
-- This query retrieves all bookings along with user details, property details, and payment details

-- Enable timing to measure query performance
\timing on

-- Initial complex query (before optimization)
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,

    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at,

    p.property_id,
    p.name AS property_name,
    p.description,
    p.street_address,
    p.zip_code,
    p.pricepernight,
    p.created_at AS property_created_at,
    p.updated_at AS property_updated_at,

    l.city,
    l.state,
    l.country,

    h.user_id AS host_id,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    h.email AS host_email,
    h.phone_number AS host_phone_number,

    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method,

    (SELECT COUNT(*) FROM Review r WHERE r.property_id = p.property_id) AS review_count,
    (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating
FROM
    Booking b
JOIN
    "User" u ON b.user_id = u.user_id
JOIN
    Property p ON b.property_id = p.property_id
JOIN
    Location l ON p.location_id = l.location_id
JOIN
    "User" h ON p.host_id = h.user_id
LEFT JOIN
    Payment pay ON b.booking_id = pay.booking_id
WHERE
    b.start_date >= '2023-01-01' AND b.end_date <= '2023-12-31'
ORDER BY
    b.start_date DESC,
    b.created_at DESC;

-- Optimized query (after analysis)
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,

    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,

    p.property_id,
    p.name AS property_name,
    p.pricepernight,

    l.city,
    l.state,
    l.country,

    h.first_name AS host_first_name,
    h.last_name AS host_last_name,

    pay.payment_id,
    pay.amount,
    pay.payment_method,

    pr.review_count,
    pr.average_rating
FROM
    Booking b
JOIN
    "User" u ON b.user_id = u.user_id
JOIN
    Property p ON b.property_id = p.property_id
JOIN
    Location l ON p.location_id = l.location_id
JOIN
    "User" h ON p.host_id = h.user_id
LEFT JOIN
    Payment pay ON b.booking_id = pay.booking_id
LEFT JOIN
    (
        SELECT
            property_id,
            COUNT(*) AS review_count,
            AVG(rating) AS average_rating
        FROM
            Review
        GROUP BY
            property_id
    ) pr ON p.property_id = pr.property_id
WHERE
    b.status != 'canceled'
ORDER BY
    b.start_date DESC,
    b.created_at DESC
LIMIT 100;
