/*
================================================================================
DATE EXPLORATION
================================================================================
Purpose: Identify temporal boundaries and timespan
Outcome: Understand data coverage period and customer demographics
================================================================================
*/

-- Find the date of the first and last order
SELECT 
    MIN(order_date) AS MinDate, 
    MAX(order_date) AS MaxDate, 
    DATEDIFF(year, MIN(order_date), MAX(order_date)) AS DateDiffYears,
    DATEDIFF(day, MIN(order_date), MAX(order_date)) AS DateDiffDays
FROM gold.fact_sales;

-- Find the youngest and oldest customer
SELECT 
    MIN(birth_date) AS OldestCustomerBirthDate, 
    DATEDIFF(year, MIN(birth_date), GETDATE()) AS OldestCustomerAge, 
    MAX(birth_date) AS YoungestCustomerBirthDate, 
    DATEDIFF(year, MAX(birth_date), GETDATE()) AS YoungestCustomerAge
FROM gold.dim_customers;

-- Order distribution by year
SELECT 
    YEAR(order_date) AS OrderYear,
    COUNT(DISTINCT order_number) AS TotalOrders,
    SUM(sales_amount) AS TotalSales
FROM gold.fact_sales
GROUP BY YEAR(order_date)
ORDER BY OrderYear;

-- Order distribution by month (recent year)
SELECT 
    YEAR(order_date) AS OrderYear,
    MONTH(order_date) AS OrderMonth,
    COUNT(DISTINCT order_number) AS TotalOrders,
    SUM(sales_amount) AS TotalSales
FROM gold.fact_sales
WHERE YEAR(order_date) = (SELECT MAX(YEAR(order_date)) FROM gold.fact_sales)
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY OrderYear, OrderMonth;
