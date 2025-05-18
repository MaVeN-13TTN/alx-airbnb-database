-- Table Partitioning for Booking Table
-- This script implements partitioning on the Booking table based on the start_date column

-- Enable timing to measure query performance
\timing on

-- First, let's create a new partitioned table structure
-- Note: PostgreSQL is used for this implementation as SQLite doesn't support table partitioning

-- 1. Create the partitioned table
CREATE TABLE Booking_Partitioned (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 2. Create partitions by quarter
-- Past bookings (historical data)
CREATE TABLE booking_2022_q1 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2022-04-01');

CREATE TABLE booking_2022_q2 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2022-04-01') TO ('2022-07-01');

CREATE TABLE booking_2022_q3 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2022-07-01') TO ('2022-10-01');

CREATE TABLE booking_2022_q4 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2022-10-01') TO ('2023-01-01');

-- Current year bookings (2023)
CREATE TABLE booking_2023_q1 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-04-01');

CREATE TABLE booking_2023_q2 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-04-01') TO ('2023-07-01');

CREATE TABLE booking_2023_q3 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-07-01') TO ('2023-10-01');

CREATE TABLE booking_2023_q4 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-10-01') TO ('2024-01-01');

-- Future bookings
CREATE TABLE booking_2024_q1 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE booking_2024_q2 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE booking_future PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-07-01') TO (MAXVALUE);

-- 3. Create indexes on each partition
-- Primary key
ALTER TABLE Booking_Partitioned ADD PRIMARY KEY (booking_id, start_date);

-- Foreign keys
ALTER TABLE Booking_Partitioned ADD CONSTRAINT fk_booking_property
    FOREIGN KEY (property_id) REFERENCES Property(property_id);

ALTER TABLE Booking_Partitioned ADD CONSTRAINT fk_booking_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id);

-- Additional indexes for common query patterns
CREATE INDEX idx_booking_part_property_id ON Booking_Partitioned(property_id, start_date);
CREATE INDEX idx_booking_part_user_id ON Booking_Partitioned(user_id, start_date);
CREATE INDEX idx_booking_part_dates ON Booking_Partitioned(start_date, end_date);
CREATE INDEX idx_booking_part_status ON Booking_Partitioned(status, start_date);

-- 4. Migrate data from the original table to the partitioned table
INSERT INTO Booking_Partitioned
SELECT * FROM Booking;

-- 5. Performance testing queries

-- Test Query 1: Find all bookings for a specific date range (Q1 2023)
-- Before partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE start_date >= '2023-01-01' AND start_date < '2023-04-01'
ORDER BY start_date;

-- After partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE start_date >= '2023-01-01' AND start_date < '2023-04-01'
ORDER BY start_date;

-- Test Query 2: Find all bookings for a specific property in a date range
-- Before partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE property_id = 'p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6'
AND start_date >= '2023-01-01' AND start_date < '2023-07-01'
ORDER BY start_date;

-- After partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE property_id = 'p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6'
AND start_date >= '2023-01-01' AND start_date < '2023-07-01'
ORDER BY start_date;

-- Test Query 3: Find all bookings for a specific user across multiple quarters
-- Before partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE user_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7'
AND start_date >= '2022-10-01' AND start_date < '2023-10-01'
ORDER BY start_date;

-- After partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE user_id = 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7'
AND start_date >= '2022-10-01' AND start_date < '2023-10-01'
ORDER BY start_date;

-- Test Query 4: Count bookings by status for each quarter of 2023
-- Before partitioning
EXPLAIN ANALYZE
SELECT 
    CASE 
        WHEN start_date >= '2023-01-01' AND start_date < '2023-04-01' THEN 'Q1'
        WHEN start_date >= '2023-04-01' AND start_date < '2023-07-01' THEN 'Q2'
        WHEN start_date >= '2023-07-01' AND start_date < '2023-10-01' THEN 'Q3'
        WHEN start_date >= '2023-10-01' AND start_date < '2024-01-01' THEN 'Q4'
    END AS quarter,
    status,
    COUNT(*) as booking_count
FROM Booking
WHERE start_date >= '2023-01-01' AND start_date < '2024-01-01'
GROUP BY quarter, status
ORDER BY quarter, status;

-- After partitioning
EXPLAIN ANALYZE
SELECT 
    CASE 
        WHEN start_date >= '2023-01-01' AND start_date < '2023-04-01' THEN 'Q1'
        WHEN start_date >= '2023-04-01' AND start_date < '2023-07-01' THEN 'Q2'
        WHEN start_date >= '2023-07-01' AND start_date < '2023-10-01' THEN 'Q3'
        WHEN start_date >= '2023-10-01' AND start_date < '2024-01-01' THEN 'Q4'
    END AS quarter,
    status,
    COUNT(*) as booking_count
FROM Booking_Partitioned
WHERE start_date >= '2023-01-01' AND start_date < '2024-01-01'
GROUP BY quarter, status
ORDER BY quarter, status;
