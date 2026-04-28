CREATE DATABASE Zepto_SQL_Project;

use Zepto_SQL_Project;

CREATE TABLE zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(10,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(10,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

-- data Exploration --

SELECT * FROM zepto;

SELECT outOfStock, COUNT(*)
FROM zepto
GROUP BY outOfStock;

SELECT COUNT(*) FROM zepto;

-- null values
SELECT * FROM zepto 
WHERE name IS NULL
OR 
category IS NULL
OR 
mrp IS NULL
OR 
discountPercent IS NULL
OR 
discountedSellingPrice IS NULL
OR 
weightInGms IS NULL
OR 
availableQuantity IS NULL
OR 
outOfStock IS NULL
OR   
quantity IS NULL;

-- Explore Product Categories
SELECT DISTINCT category
FROM zepto 
ORDER BY category;

-- product in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto 
GROUP BY outOfStock;

-- Product Names present multiple times
SELECT name, COUNT(sku_id) as "Number of SKU's"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

-- Data Cleaning

-- Products where price might be 0
SELECT * FROM zepto
WHERE mrp = 0 or discountedSellingPrice = 0;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM zepto 
WHERE mrp = 0;
SET SQL_SAFE_UPDATES = 1;

-- Converting paise into rupees
SET SQL_SAFE_UPDATES = 0;
UPDATE zepto 
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;
SET SQL_SAFE_UPDATES = 1;

SELECT mrp, discountedSellingPrice FROM zepto;

-- Q.1. Find the top 10 best value products on the basis of discount percentage.
SELECT DISTINCT name, mrp, discountPercent 
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q.2. What are the products with high MRP but out of stock.
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE  and mrp > 300
ORDER BY mrp DESC;

-- Q.3. Calculate estimated revenue for each category.
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS Total_Revenue
FROM zepto
GROUP BY category
ORDER BY Total_Revenue;

-- Q.4. Find all products where MRP is greate rthan 500 and discount is less than 100.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 and discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q.5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS Average_Discount
FROM zepto
GROUP BY category
ORDER BY Average_Discount DESC
LIMIT 5; 

-- Q.6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice, 
ROUND(discountedSellingPRice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE WeightInGms >= 100
ORDER BY price_per_gram;

-- Q.7. Group the products into categories like low, medium and high.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightIngms < 1000 THEN 'Low'
WHEN weightInGms < 5000 THEN 'Medium'
ELSE 'Bulk'
END AS weight_category
FROM zepto;

-- Q.8. What is the total inventory weight per category.
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;