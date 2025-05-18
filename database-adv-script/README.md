# Advanced SQL Queries

This directory contains SQL queries demonstrating advanced SQL concepts including different types of joins, subqueries, aggregations, and window functions.

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

## Aggregations and Window Functions

### 1. Aggregation Functions
- Functions that perform calculations on a set of values and return a single value
- Used to find the total number of bookings made by each user using COUNT and GROUP BY
- Provides summary statistics about the data

### 2. Window Functions
- Functions that perform calculations across a set of rows related to the current row
- Used to rank properties based on the total number of bookings they have received
- Examples include:
  - ROW_NUMBER(): Assigns a unique sequential number to each row
  - RANK(): Assigns the same rank to rows with the same values, leaving gaps in the sequence
  - DENSE_RANK(): Assigns the same rank to rows with the same values, without leaving gaps

## File Structure

- `joins_queries.sql`: Contains SQL queries implementing different types of joins
- `subqueries.sql`: Contains SQL queries implementing different types of subqueries
- `aggregations_and_window_functions.sql`: Contains SQL queries implementing aggregations and window functions

## Database Schema Overview

The queries work with the following tables:
- `User`: Contains user information
- `Property`: Contains property listings
- `Booking`: Contains booking information
- `Review`: Contains property reviews
- `Location`: Contains location information

## Usage

To run these queries, use the following commands:

```bash
sqlite3 airbnb.db < joins_queries.sql
sqlite3 airbnb.db < subqueries.sql
sqlite3 airbnb.db < aggregations_and_window_functions.sql
```

Note: Make sure the database schema has been created and populated with data before running these queries.
