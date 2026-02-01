/*
================================================================================
SCHEMA EXPLORATION
================================================================================
Purpose: Understand database structure and available objects
Use Case: Initial database discovery and documentation
================================================================================
*/

-- Explore All Objects in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore All Columns in the dim_customers table
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'dim_customers';

-- List all columns in fact_sales
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'fact_sales';

-- List all columns in dim_products
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'dim_products';
