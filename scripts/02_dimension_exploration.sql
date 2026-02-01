/*
================================================================================
DIMENSIONS EXPLORATION
================================================================================
Purpose: Identifying unique values (or categories) in each dimension
Outcome: Recognizing how data might be grouped or segmented
================================================================================
*/

-- Explore All Countries our customers come from
SELECT DISTINCT country 
FROM gold.dim_customers;

-- Explore all product categories (the major divisions)
SELECT DISTINCT category 
FROM gold.dim_products;

-- Explore product hierarchy: category → subcategory → product
SELECT DISTINCT 
    category,
    subcategory,
    product_name 
FROM gold.dim_products
ORDER BY 1, 2, 3;

-- Count of unique values per dimension
SELECT 
    COUNT(DISTINCT country) AS unique_countries,
    COUNT(DISTINCT gender) AS unique_genders
FROM gold.dim_customers;

-- Product dimension cardinality
SELECT 
    COUNT(DISTINCT category) AS unique_categories,
    COUNT(DISTINCT subcategory) AS unique_subcategories,
    COUNT(DISTINCT product_name) AS unique_products
FROM gold.dim_products;
