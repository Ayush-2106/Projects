CREATE SCHEMA MYNTRA;

DROP DATABASE if exists MYNTRA;
CREATE DATABASE if not exists MYNTRA;

USE MYNTRA;

SELECT * FROM PRODUCTS;

SELECT MAX(discounted_price), MAX(marked_price), MIN(discounted_price), MIN(marked_price), AVG(discounted_price), AVG(marked_price) FROM PRODUCTS;

SELECT (brand_tag)
FROM PRODUCTS;
SELECT * FROM PRODUCTS WHERE (discounted_price=45900);

SELECT MAX(discounted_price), MIN(discounted_price), AVG(discounted_price), AVG(marked_price) FROM PRODUCTS
WHERE (brand_tag= 'adidas');

SELECT SUM(discounted_price*rating_count) as 'revenue'
FROM PRODUCTS;

SELECT SUM(discounted_price*rating_count), MAX(discounted_price*rating_count), brand_name
FROM PRODUCTS;

SELECT count(brand_tag) as 'Total Products' FROM PRODUCTS;

-- UNIQUE BRAND AND THEIR COUNT--
SELECT count(DISTINCT(brand_tag)) as 'Total Products' FROM PRODUCTS;


SELECT COUNT(DISTINCT(product_tag)) FROM PRODUCTS
WHERE (brand_name='Nike');

SELECT Distinct(product_tag) FROM PRODUCTS
WHERE (brand_name='Nike');


# 1 Finding the 10 most expensive products on myntra
USE MYNTRA;
SELECT * FROM PRODUCTS
ORDER BY discounted_price DESC; 
 
 SELECT *
# 2 Find the Least Expensive product on Myntra

USE MYNTRA;
SELECT * FROM PRODUCTS 
ORDER BY discounted_price ASC LIMIT 6;

# 3 Finding the top 5 most expensive product on MYNTRA
SELECT * FROM PRODUCTS ORDER BY discounted_price desc LIMIT 5;

# 4 Top 5 products based on best rating | rating*rating count
SELECT *, (rating*rating_count) as 'Best Rating'
FROM PRODUCTS
ORDER BY 'Best Rating' desc LIMIT 5;

## Products with atleast 50% discount and order them insert
## desc based on discount percentage

SELECT * FROM PRODUCTS 
WHERE (discount_percent>50)
ORDER BY discount_percent desc;


## Find top 10 Best_selling products based on (rating count>500)
SELECT * FROM PRODUCTS
WHERE (rating_count>500)
ORDER BY rating_count desc;

## LIMIT TILL 10
SELECT * FROM PRODUCTS
WHERE (rating_count>500)
ORDER BY rating_count desc LIMIT 10;


## Find the top 10 details of the product with category as 'tshirts'
## based on rating*count column

SELECT * FROM PRODUCTS
WHERE (product_tag='tshirts')
ORDER BY product_tag desc LIMIT 10;

## my mistake
SELECT * FROM PRODUCTS
WHERE (product_tag='tshirts') and (rating*rating_count) as 'Rating Average'
ORDER BY 'Rating Average' desc LIMIT 10;
## RIGHT WAY
SELECT *, (rating*rating_count) as Ratings
FROM PRODUCTS
WHERE product_tag='tshirts'
ORDER BY Ratings desc LIMIT 10;



# 5. Finding the second most expensive product

## RIGHT WAY
SELECT product_name, rating, rating_count, discounted_price FROM PRODUCTS
ORDER BY discounted_price desc LIMIT 1,1;

## Finding the second least expensive product

SELECT product_name, rating, rating_count, discounted_price FROM PRODUCTS
ORDER BY discounted_price asc LIMIT 1,1;
## RIGHT WAY
SELECT *
FROM PRODUCTS
ORDER BY discounted_price asc LIMIT 1,1;

## Find the 10th most expensive product
SELECT * 
FROM PRODUCTS
ORDER BY discounted_percentage desc LIMIT 9,1;

## Find the worst rated product by NIKE
SELECT *
FROM PRODUCTS
WHERE brand_tag = 'nike'
ORDER BY rating_count asc LIMIT 5;

## Find the BEST rated product by NIKE
SELECT *
FROM PRODUCTS
WHERE brand_tag = 'nike'
ORDER BY rating_count desc LIMIT 5;

# 9 Finding the worst rated product by nike & rating is not zero
# 10 Finding the top 10 best rated tshirt from nike or adidas based on rating*rating count

SELECT * 
FROM PRODUCTS
WHERE brand_tag = 'nike' and rating != 0
ORDER BY rating asc LIMIT 1;

SELECT *, (rating*rating_count) as Ratings
FROM PRODUCTS
WHERE brand_tag IN ('nike', 'adidas') and product_tag = 'tshirts'
ORDER BY Ratings desc LIMIT 10;


# 11 Worst rated 10 products based on the rating of 100 people atleast

SELECT * 
FROM PRODUCTS
WHERE rating_count > 100
ORDER BY rating asc LIMIT 10;

# 12 10 worst rated tshirt based on the rating of 100 people atleast

SELECT * 
FROM PRODUCTS
WHERE (rating_count > 100) and product_tag = 'tshirts'
ORDER BY rating asc LIMIT 10;

SELECT *, (discounted_price/rating_count) as 'price_per_sale' 
FROM PRODUCTS
WHERE rating_count > 100
ORDER BY 'price_per_sale' desc LIMIT 5;
