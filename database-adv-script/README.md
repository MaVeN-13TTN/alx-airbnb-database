# Advanced SQL Joins Queries

This directory contains SQL queries demonstrating different types of joins in SQL.

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

## File Structure

- `joins_queries.sql`: Contains the SQL queries implementing the different types of joins

## Database Schema Overview

The queries work with the following tables:
- `User`: Contains user information
- `Property`: Contains property listings
- `Booking`: Contains booking information
- `Review`: Contains property reviews

## Usage

To run these queries, use the following command:

```bash
sqlite3 airbnb.db < joins_queries.sql
```

Note: Make sure the database schema has been created and populated with data before running these queries.
