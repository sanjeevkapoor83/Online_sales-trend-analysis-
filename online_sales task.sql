-- Create database
CREATE DATABASE sales_analysis;
USE sales_analysis;

-- Create table with more detailed columns
CREATE TABLE online_sales (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    product_category VARCHAR(50),
    amount DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    payment_method VARCHAR(20),
    region VARCHAR(50)
);

-- Insert sample data (20 rows across 6 months)
INSERT INTO online_sales 
(order_id, order_date, customer_id, product_id, product_category, amount, quantity, payment_method, region) 
VALUES
(1, '2024-01-05', 101, 201, 'Electronics', 500.00, 1, 'Credit Card', 'North'),
(2, '2024-01-12', 102, 202, 'Clothing', 1200.00, 3, 'UPI', 'South'),
(3, '2024-01-20', 103, 203, 'Furniture', 2500.00, 2, 'Cash', 'West'),
(4, '2024-02-02', 104, 201, 'Electronics', 800.00, 2, 'Credit Card', 'East'),
(5, '2024-02-15', 105, 204, 'Kitchen', 950.00, 5, 'UPI', 'North'),
(6, '2024-02-25', 106, 205, 'Sports', 600.00, 4, 'Net Banking', 'South'),
(7, '2024-03-01', 107, 206, 'Books', 300.00, 6, 'Cash', 'East'),
(8, '2024-03-10', 108, 202, 'Clothing', 1500.00, 5, 'Credit Card', 'West'),
(9, '2024-03-18', 109, 201, 'Electronics', 2200.00, 3, 'UPI', 'North'),
(10, '2024-03-28', 110, 207, 'Beauty', 750.00, 4, 'Cash', 'South'),
(11, '2024-04-05', 111, 208, 'Toys', 1250.00, 6, 'Credit Card', 'East'),
(12, '2024-04-12', 112, 203, 'Furniture', 3500.00, 2, 'Net Banking', 'West'),
(13, '2024-04-20', 113, 204, 'Kitchen', 1450.00, 5, 'UPI', 'North'),
(14, '2024-04-25', 114, 205, 'Sports', 900.00, 3, 'Cash', 'South'),
(15, '2024-05-01', 115, 206, 'Books', 450.00, 8, 'Credit Card', 'East'),
(16, '2024-05-10', 116, 208, 'Toys', 1750.00, 7, 'UPI', 'North'),
(17, '2024-05-18', 117, 207, 'Beauty', 1100.00, 3, 'Cash', 'West'),
(18, '2024-06-02', 118, 202, 'Clothing', 2000.00, 6, 'Credit Card', 'South'),
(19, '2024-06-12', 119, 201, 'Electronics', 2800.00, 4, 'UPI', 'East'),
(20, '2024-06-25', 120, 205, 'Sports', 950.00, 2, 'Net Banking', 'North');

---monthly revenue and order volume---
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

---top 3 months by revenue---
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS monthly_revenue
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY monthly_revenue DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

---monthly orders and average order value--- 
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(amount) / COUNT(order_id), 2) AS avg_order_value
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

---category-wise monthly revenue---
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    product_category,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date), product_category
ORDER BY year, month, total_revenue DESC;