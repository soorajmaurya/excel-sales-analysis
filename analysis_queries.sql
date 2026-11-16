-- Retail Sales Performance Analysis
-- Dataset: simulated practice data (300 orders, Jan-Dec 2025)
-- Table assumed: sales_data

-- 1. Overall KPIs
SELECT
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales_INR) AS total_sales_inr,
    SUM(Profit_INR) AS total_profit_inr,
    ROUND(SUM(Profit_INR) / NULLIF(SUM(Sales_INR), 0) * 100, 2) AS profit_margin_pct
FROM sales_data;

-- 2. Sales and profit by region
SELECT Region, SUM(Sales_INR) AS sales_inr, SUM(Profit_INR) AS profit_inr,
       COUNT(DISTINCT Order_ID) AS orders
FROM sales_data
GROUP BY Region
ORDER BY sales_inr DESC;

-- 3. Category performance
SELECT Category, SUM(Sales_INR) AS sales_inr, SUM(Profit_INR) AS profit_inr,
       SUM(Quantity) AS units_sold
FROM sales_data
GROUP BY Category
ORDER BY sales_inr DESC;

-- 4. Monthly sales trend (date functions vary by SQL platform)
SELECT EXTRACT(YEAR FROM Order_Date) AS sales_year,
       EXTRACT(MONTH FROM Order_Date) AS sales_month,
       SUM(Sales_INR) AS monthly_sales_inr,
       SUM(Profit_INR) AS monthly_profit_inr
FROM sales_data
GROUP BY EXTRACT(YEAR FROM Order_Date), EXTRACT(MONTH FROM Order_Date)
ORDER BY sales_year, sales_month;

-- 5. Top products by sales
SELECT Product, SUM(Quantity) AS units_sold,
       SUM(Sales_INR) AS sales_inr, SUM(Profit_INR) AS profit_inr
FROM sales_data
GROUP BY Product
ORDER BY sales_inr DESC
LIMIT 10;

-- 6. Payment method mix
SELECT Payment_Method, COUNT(*) AS order_count, SUM(Sales_INR) AS sales_inr
FROM sales_data
GROUP BY Payment_Method
ORDER BY sales_inr DESC;
