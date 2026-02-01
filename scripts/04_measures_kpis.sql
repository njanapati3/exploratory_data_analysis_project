/*
================================================================================
MEASURES EXPLORATION - KEY PERFORMANCE INDICATORS (KPIs)
================================================================================
Purpose: Calculate the key metrics of the business (Big Numbers)
Level: Highest Level of Aggregation
================================================================================
*/

-- Find the total sales amount
SELECT SUM(sales_amount) AS TotalSalesAmount 
FROM gold.fact_sales;

-- Find how many items are sold
SELECT SUM(quantity) AS TotalItemsSold 
FROM gold.fact_sales;

-- Find the average selling price
SELECT AVG(price) AS AvgSellingPrice 
FROM gold.fact_sales;

-- Find the total number of orders (WRONG - counts duplicates)
SELECT COUNT(order_number) AS TotalOrderLines 
FROM gold.fact_sales;

-- Find the total number of orders (CORRECT - uses DISTINCT)
SELECT COUNT(DISTINCT order_number) AS TotalOrders 
FROM gold.fact_sales;

-- Find the total number of products (WRONG - may have duplicates)
SELECT COUNT(product_key) AS ProductCount 
FROM gold.dim_products;

-- Find the total number of products (CORRECT)
SELECT COUNT(DISTINCT product_key) AS TotalProducts 
FROM gold.dim_products;

-- Find the total number of customers
SELECT COUNT(customer_key) AS TotalCustomers 
FROM gold.dim_customers;

-- Find the total number of customers that have placed an order
SELECT COUNT(DISTINCT fs.customer_key) AS ActiveCustomers
FROM gold.dim_customers dc 
INNER JOIN gold.fact_sales fs ON dc.customer_key = fs.customer_key;

-- Alternative (simpler) approach
SELECT COUNT(DISTINCT customer_key) AS ActiveCustomers
FROM gold.fact_sales;


-- ============================================================================
-- EXECUTIVE SUMMARY REPORT
-- ============================================================================
-- Purpose: All KPIs in a single result set

SELECT 'Total Sales' AS measure_name, 
       CAST(SUM(sales_amount) AS DECIMAL(18,2)) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', 
       SUM(quantity) 
FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', 
       CAST(AVG(price) AS DECIMAL(18,2))
FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', 
       COUNT(DISTINCT order_number) 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', 
       COUNT(DISTINCT product_key) 
FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', 
       COUNT(DISTINCT customer_key) 
FROM gold.dim_customers
UNION ALL
SELECT 'Active Customers', 
       COUNT(DISTINCT customer_key) 
FROM gold.fact_sales;
