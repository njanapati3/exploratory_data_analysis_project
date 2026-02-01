/*
================================================================================
RANKING ANALYSIS
================================================================================
Purpose: Order values of dimensions by measure to find top/bottom performers
Pattern: Rank [Dimension] BY [Aggregation] [Measure]
Examples:
  - TOP 5 Products BY Revenue
  - Bottom 3 Customers BY Total Orders
  - Rank Countries BY Total Sales
================================================================================
*/

-- TOP 5: Products generating the highest revenue
SELECT TOP 5 
    dp.product_name,
    dp.category,
    SUM(fs.sales_amount) AS total_revenue,
    SUM(fs.quantity) AS total_quantity
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
GROUP BY dp.product_name, dp.category
ORDER BY total_revenue DESC;

-- BOTTOM 5: Worst-performing products by sales quantity
SELECT TOP 5 
    dp.product_name,
    dp.category,
    SUM(fs.quantity) AS total_quantity,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
GROUP BY dp.product_name, dp.category
ORDER BY total_quantity ASC;

-- TOP 10: Customers by total revenue
SELECT TOP 10
    dc.customer_key,
    dc.first_name + ' ' + dc.last_name AS customer_name,
    dc.country,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT fs.order_number) AS order_count
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name, dc.country
ORDER BY total_revenue DESC;

-- TOP 5: Countries by revenue
SELECT TOP 5
    dc.country,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT fs.customer_key) AS unique_customers,
    SUM(fs.quantity) AS total_items_sold
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc ON fs.customer_key = dc.customer_key
GROUP BY dc.country
ORDER BY total_revenue DESC;

-- TOP 3: Categories by average order value
SELECT TOP 3
    dp.category,
    SUM(fs.sales_amount) / COUNT(DISTINCT fs.order_number) AS avg_order_value,
    SUM(fs.sales_amount) AS total_revenue,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
GROUP BY dp.category
ORDER BY avg_order_value DESC;

-- Products ranked by profitability (assuming cost is available)
SELECT TOP 10
    dp.product_name,
    dp.category,
    SUM(fs.sales_amount) AS total_revenue,
    SUM(fs.quantity * dp.cost) AS total_cost,
    SUM(fs.sales_amount) - SUM(fs.quantity * dp.cost) AS total_profit,
    (SUM(fs.sales_amount) - SUM(fs.quantity * dp.cost)) / NULLIF(SUM(fs.sales_amount), 0) * 100 AS profit_margin_pct
FROM gold.fact_sales fs
INNER JOIN gold.dim_products dp ON fs.product_key = dp.product_key
GROUP BY dp.product_name, dp.category
ORDER BY total_profit DESC;

-- Customers ranked by number of orders
SELECT TOP 10
    dc.customer_key,
    dc.first_name + ' ' + dc.last_name AS customer_name,
    COUNT(DISTINCT fs.order_number) AS order_count,
    SUM(fs.sales_amount) AS total_revenue,
    AVG(fs.sales_amount) AS avg_transaction_value
FROM gold.fact_sales fs
INNER JOIN gold.dim_customers dc ON fs.customer_key = dc.customer_key
GROUP BY dc.customer_key, dc.first_name, dc.last_name
ORDER BY order_count DESC;
