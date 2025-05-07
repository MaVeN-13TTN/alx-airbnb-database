-- AirBnB Clone Database Sample Data
-- This script populates the database with sample data for testing and development

-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Clear existing data (in reverse order of dependencies)
DELETE FROM Message;
DELETE FROM Review;
DELETE FROM Payment;
DELETE FROM Booking;
DELETE FROM Property;
DELETE FROM Location;
DELETE FROM User;

-- Insert sample users
-- Format: user_id, first_name, last_name, email, password_hash, phone_number, role, created_at
INSERT INTO User VALUES
('u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'John', 'Doe', 'john.doe@example.com', '$2a$10$Ks9hCxr5Gv.vCn/jYnJme.zxQOhxX2h8PYiQzk5vOLSYlcCYpxzfO', '123-456-7890', 'host', '2023-01-01 10:00:00'),
('u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'Jane', 'Smith', 'jane.smith@example.com', '$2a$10$Qwerty1234567890QwertyQwerty1234567890Qwerty', '234-567-8901', 'guest', '2023-01-02 11:00:00'),
('u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'Michael', 'Johnson', 'michael.johnson@example.com', '$2a$10$Asdfgh1234567890AsdfghAsdfgh1234567890Asdfgh', '345-678-9012', 'guest', '2023-01-03 12:00:00'),
('u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'Emily', 'Williams', 'emily.williams@example.com', '$2a$10$Zxcvbn1234567890ZxcvbnZxcvbn1234567890Zxcvbn', '456-789-0123', 'host', '2023-01-04 13:00:00'),
('u5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'David', 'Brown', 'david.brown@example.com', '$2a$10$Poiuyt1234567890PoiuytPoiuyt1234567890Poiuyt', '567-890-1234', 'guest', '2023-01-05 14:00:00'),
('u6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'Sarah', 'Davis', 'sarah.davis@example.com', '$2a$10$Lkjhgf1234567890LkjhgfLkjhgf1234567890Lkjhgf', '678-901-2345', 'guest', '2023-01-06 15:00:00'),
('u7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'Admin', 'User', 'admin@airbnb-clone.com', '$2a$10$Admin1234567890AdminAdmin1234567890Admin', '789-012-3456', 'admin', '2023-01-07 16:00:00');

-- Insert sample locations
-- Format: location_id, city, state, country
INSERT INTO Location VALUES
('l1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'New York', 'New York', 'USA'),
('l2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'Los Angeles', 'California', 'USA'),
('l3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'Chicago', 'Illinois', 'USA'),
('l4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'Miami', 'Florida', 'USA'),
('l5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'London', 'England', 'UK'),
('l6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'Paris', 'Île-de-France', 'France'),
('l7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'Tokyo', 'Tokyo', 'Japan');

-- Insert sample properties
-- Format: property_id, host_id, location_id, name, description, street_address, zip_code, pricepernight, created_at, updated_at
INSERT INTO Property VALUES
('p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'l1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'Cozy Manhattan Apartment', 'A beautiful apartment in the heart of Manhattan with stunning views of the city skyline.', '123 Broadway', '10001', 150.00, '2023-02-01 10:00:00', '2023-02-01 10:00:00'),
('p2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'l2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'Hollywood Hills Villa', 'Luxurious villa with a pool and panoramic views of Los Angeles.', '456 Hollywood Blvd', '90028', 350.00, '2023-02-02 11:00:00', '2023-02-02 11:00:00'),
('p3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'l3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'Downtown Chicago Loft', 'Modern loft in downtown Chicago with easy access to public transportation.', '789 Michigan Ave', '60601', 120.00, '2023-02-03 12:00:00', '2023-02-03 12:00:00'),
('p4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'l4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'Miami Beach Condo', 'Beachfront condo with direct access to Miami Beach.', '101 Ocean Drive', '33139', 200.00, '2023-02-04 13:00:00', '2023-02-04 13:00:00'),
('p5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'l5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'Central London Flat', 'Charming flat in central London, walking distance to major attractions.', '10 Baker Street', 'W1U 6TW', 180.00, '2023-02-05 14:00:00', '2023-02-05 14:00:00'),
('p6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'l6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'Parisian Studio', 'Cozy studio in the heart of Paris with a view of the Eiffel Tower.', '20 Rue de Rivoli', '75004', 160.00, '2023-02-06 15:00:00', '2023-02-06 15:00:00'),
('p7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'l7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'Tokyo Modern Apartment', 'Modern apartment in Tokyo with traditional Japanese elements.', '30 Shibuya', '150-0043', 140.00, '2023-02-07 16:00:00', '2023-02-07 16:00:00');

-- Insert sample bookings
-- Format: booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at
INSERT INTO Booking VALUES
('b1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', '2023-03-10', '2023-03-15', 750.00, 'confirmed', '2023-02-15 10:00:00'),
('b2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'p2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', '2023-04-05', '2023-04-10', 1750.00, 'confirmed', '2023-03-01 11:00:00'),
('b3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'p3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'u5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', '2023-05-15', '2023-05-20', 600.00, 'confirmed', '2023-04-01 12:00:00'),
('b4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'p4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'u6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', '2023-06-20', '2023-06-25', 1000.00, 'confirmed', '2023-05-01 13:00:00'),
('b5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'p5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', '2023-07-01', '2023-07-07', 1260.00, 'confirmed', '2023-06-01 14:00:00'),
('b6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'p6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', '2023-08-10', '2023-08-15', 800.00, 'pending', '2023-07-15 15:00:00'),
('b7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'p7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'u5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', '2023-09-05', '2023-09-10', 700.00, 'canceled', '2023-08-01 16:00:00'),
('b8h9i0j1-k2l3-m4n5-o6p7-q8r9s0t1u2v3', 'p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', '2023-10-15', '2023-10-20', 750.00, 'pending', '2023-09-15 17:00:00');

-- Insert sample payments
-- Format: payment_id, booking_id, amount, payment_date, payment_method
INSERT INTO Payment VALUES
('py1a2b3c-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'b1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 750.00, '2023-02-15 10:30:00', 'credit_card'),
('py2b3c4d-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'b2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 1750.00, '2023-03-01 11:30:00', 'paypal'),
('py3c4d5e-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'b3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 600.00, '2023-04-01 12:30:00', 'credit_card'),
('py4d5e6f-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'b4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 1000.00, '2023-05-01 13:30:00', 'stripe'),
('py5e6f7g-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'b5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 1260.00, '2023-06-01 14:30:00', 'credit_card');

-- Insert sample reviews
-- Format: review_id, property_id, user_id, rating, comment, created_at
INSERT INTO Review VALUES
('r1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 5, 'Amazing apartment with a great view! The location is perfect for exploring Manhattan.', '2023-03-16 10:00:00'),
('r2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'p2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 4, 'Beautiful villa with a stunning view. The pool was great, but the air conditioning was a bit noisy.', '2023-04-11 11:00:00'),
('r3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'p3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'u5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 5, 'Perfect location in downtown Chicago. The loft is spacious and modern.', '2023-05-21 12:00:00'),
('r4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'p4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'u6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 5, 'Amazing beachfront condo! We loved waking up to the sound of the ocean every morning.', '2023-06-26 13:00:00'),
('r5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'p5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 4, 'Great location in London. The flat was clean and comfortable, but a bit smaller than expected.', '2023-07-08 14:00:00'),
('r6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'p1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 5, 'Second time staying here and it was just as amazing as the first time!', '2023-08-01 15:00:00');

-- Insert sample messages
-- Format: message_id, sender_id, recipient_id, message_body, sent_at
INSERT INTO Message VALUES
('m1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'Hi, I''m interested in your Manhattan apartment. Is it available for the dates I selected?', '2023-02-10 10:00:00'),
('m2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'Yes, the apartment is available for those dates. Let me know if you have any questions!', '2023-02-10 10:30:00'),
('m3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'Hello, does the Hollywood Hills Villa have a BBQ grill?', '2023-02-25 11:00:00'),
('m4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u3c4d5e6-f7g8-h9i0-j1k2-l3m4n5o6p7q8', 'Yes, there is a BBQ grill on the patio that you are welcome to use!', '2023-02-25 11:30:00'),
('m5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'u5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'Is parking available at the Chicago loft?', '2023-03-15 12:00:00'),
('m6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'u5e6f7g8-h9i0-j1k2-l3m4-n5o6p7q8r9s0', 'There is a paid parking garage next door, but no free parking on-site.', '2023-03-15 12:30:00'),
('m7g8h9i0-j1k2-l3m4-n5o6-p7q8r9s0t1u2', 'u6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'Do you provide beach towels at the Miami condo?', '2023-04-20 13:00:00'),
('m8h9i0j1-k2l3-m4n5-o6p7-q8r9s0t1u2v3', 'u4d5e6f7-g8h9-i0j1-k2l3-m4n5o6p7q8r9', 'u6f7g8h9-i0j1-k2l3-m4n5-o6p7q8r9s0t1', 'Yes, we provide beach towels, chairs, and an umbrella for your use during your stay!', '2023-04-20 13:30:00'),
('m9i0j1k2-l3m4-n5o6-p7q8-r9s0t1u2v3w4', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'Is there a tube station near the London flat?', '2023-05-25 14:00:00'),
('m10j1k2l-m4n5-o6p7-q8r9-s0t1u2v3w4x5', 'u1a2b3c4-d5e6-f7g8-h9i0-j1k2l3m4n5o6', 'u2b3c4d5-e6f7-g8h9-i0j1-k2l3m4n5o6p7', 'Yes, Baker Street station is just a 2-minute walk away!', '2023-05-25 14:30:00');
