/*
================================================================================
MAGNITUDE ANALYSIS
================================================================================
Pattern: [Aggregation] [Measure] BY [Dimension]
Examples: 
  - Total Sales BY Country
  - Total Quantity BY Category
  - Average Price BY Product
================================================================================
*/

-- Total customers by country
SELECT 
    country,
    COUNT(customer_key) AS TotalCustomers 
FROM gold.dim_customers
GROUP BY country
ORDER BY TotalCustomers DESC;

-- Total customers by gender
SELECT 
    gender,
    COUNT(gender) AS TotalCustomers 
FROM gold.dim_customers
GROUP BY gender;

-- Total products by category
SELECT 
    category,
    COUNT(category) AS TotalProducts 
FROM gold.dim_products
GROUP BY category
ORDER BY TotalProducts DESC;

-- Average cost per category
SELECT 
    category, 
    AVG(cost) AS AvgCost,
    MIN(cost) AS MinCost,
    MAX(cost) AS MaxCost
FROM gold.dim_products
GROUP BY category
ORDER BY AvgCost DESC;

-- Total revenue by category
SELECT 
    dp.category, 
    SUM(fs.sales_amount) AS TotalRevenue,
    SUM(fs.quantity) AS TotalQuantity,
    COUNT(DISTINCT fs.order_number) AS TotalOrders
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
GROUP BY dp.category
ORDER BY TotalRevenue DESC;

-- Total revenue by customer (Top 20)
SELECT TOP 20
    dc.customer_key, 
    dc.first_name, 
    dc.last_name,
    dc.country,
    SUM(fs.sales_amount) AS TotalRevenue,
    COUNT(DISTINCT fs.order_number) AS TotalOrders
FROM gold.fact_sales fs
LEFT JOIN gold.dim_customers dc ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name, dc.country
ORDER BY TotalRevenue DESC;

-- Distribution of sold items across countries
SELECT 
    dc.country, 
    SUM(fs.quantity) AS TotalItemsSold,
    SUM(fs.sales_amount) AS TotalRevenue,
    COUNT(DISTINCT fs.customer_key) AS UniqueCustomers
FROM gold.dim_customers dc
INNER JOIN gold.fact_sales fs ON dc.customer_key = fs.customer_key
GROUP BY dc.country
ORDER BY TotalItemsSold DESC;

-- Sales by category and subcategory
SELECT 
    dp.category,
    dp.subcategory,
    SUM(fs.sales_amount) AS TotalRevenue,
    SUM(fs.quantity) AS TotalQuantity
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
GROUP BY dp.category, dp.subcategory
ORDER BY dp.category, TotalRevenue DESC;
