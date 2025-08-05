CREATE DATABASE IF NOT EXISTS sneakers;

USE sneakers;

SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM sales;
SELECT * FROM sales_reprentative;
SELECT * FROM suppliers;

### Objective 2: Customer and Product Analysis
-- 1. What is the average spending per customer?
SELECT customers.CustomerID,
AVG(sales.TotalAmount) as avg_spending
FROM sales
JOIN customers ON sales.CustomerID = customers.CustomerID
GROUP BY customers.CustomerID;

-- 2. Which product is the most frequently purchased by customers?
SELECT products.ProductName, COUNT(sales.ProductID) as purchase_count
FROM sales
JOIN products ON sales.ProductID = products.ProductID
GROUP BY products.ProductName
ORDER BY purchase_count
LIMIT 1;

-- 3. How many unique Customers made purchases in each city?
SELECT customers.city, COUNT(DISTINCT sales.CustomerID) as unique_customers
FROM sales
JOIN customers ON sales.CustomerID = customers.CustomerID
GROUP BY customers.city;

-- 4. What is the distribution of product categories purchased by customers?
SELECT products.Category, COUNT(*) as purchases
FROM sales
JOIN products ON sales.ProductID = Products.ProductID
GROUP BY products.Category;

-- 5. How many repeat customers are there in the dataset?
SELECT count(DISTINCT sales.CustomerID) as repeat_customers
FROM sales
JOIN customers ON sales.CustomerID = customers.CustomerID
GROUP BY sales.CustomerID;

-- 6. What is the average unit price of products purchased by customers?
SELECT AVG(products.UnitPrice) as avg_unit_price
FROM sales
JOIN products ON sales.ProductID = products.ProductID;

-- 7. How does the spending behaviour differ between customers from different states?
SELECT customers.State, AVG(sales.TotalAmount) as avg_spending
FROM sales
JOIN customers ON sales.CustomerID = customers.CustomerID
GROUP BY customers.State;

-- 8. Which supplier provides the most popular products?
SELECT suppliers.SupplierName, count(products.ProductID) as product_count
FROM products
JOIN suppliers ON products.SupplierID = suppliers.SupplierID
GROUP BY suppliers.SupplierName
ORDER BY product_count
LIMIT 1;
-- 9. What is the most common product category purchased by customers?
SELECT products.Category, COUNT(sales.ProductID) as purchase_count
FROM sales
JOIN products ON sales.ProductID = products.ProductID
GROUP BY products.Category
ORDER BY purchase_count DESC
LIMIT 1;

-- 10. How many customers purchased more than one type of product?
SELECT COUNT(DISTINCT sales.CustomerID) as multi_product_customers
FROM sales
JOIN products ON sales.ProductID = Products.ProductID
GROUP BY sales.CustomerID
ORDER BY multi_product_customers;


