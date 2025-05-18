# Advanced SQL Queries

This directory contains SQL queries demonstrating advanced SQL concepts including different types of joins and subqueries.

## Types of Joins Implemented

### 1. INNER JOIN
- Retrieves records that have matching values in both tables
- Used to get all bookings and the respective users who made those bookings
- Only returns records where there is a match in both tables

### 2. LEFT JOIN (LEFT OUTER JOIN)
- Retrieves all records from the left table and matching records from the right table
- Used to get all properties and their reviews, including properties that have no reviews
- If there's no match in the right table, NULL values are returned for right table columns

### 3. FULL OUTER JOIN
- Retrieves all records when there is a match in either the left or right table
- Used to get all users and all bookings, even if a user has no booking or a booking is not linked to a user
- If there's no match in one table, NULL values are returned for that table's columns

## Types of Subqueries Implemented

### 1. Non-correlated Subquery
- A subquery that can be executed independently of the outer query
- Used to find all properties where the average rating is greater than 4.0
- The subquery calculates the average rating for each property, and the outer query filters based on this result

### 2. Correlated Subquery
- A subquery that depends on the outer query for its values
- Used to find users who have made more than 3 bookings
- The subquery references the outer query's table to count bookings for each user

## File Structure

- `joins_queries.sql`: Contains SQL queries implementing different types of joins
- `subqueries.sql`: Contains SQL queries implementing different types of subqueries

## Database Schema Overview

The queries work with the following tables:
- `User`: Contains user information
- `Property`: Contains property listings
- `Booking`: Contains booking information
- `Review`: Contains property reviews

## Usage

To run these queries, use the following commands:

```bash
sqlite3 airbnb.db < joins_queries.sql
sqlite3 airbnb.db < subqueries.sql
```

Note: Make sure the database schema has been created and populated with data before running these queries.
