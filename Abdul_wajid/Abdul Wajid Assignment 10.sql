-- ============================================================
--  ASSIGNMENT 10 — Group By & Subqueries  (SUBMISSION)
--  Database : BikeStores (SQL Server)
-- ============================================================
USE BikeStores;
GO


-- ============================================================
--  Question 1 — Aggregate Functions
-- ============================================================
SELECT COUNT(*)         AS total_order_lines,
       SUM(quantity)    AS total_units_sold,
       AVG(list_price)  AS avg_list_price,
       MIN(list_price)  AS min_list_price,
       MAX(list_price)  AS max_list_price
FROM   sales.order_items;


-- ============================================================
--  Question 2 — COUNT(*) vs COUNT(column)
--  COUNT(*) counts every row; COUNT(column) skips NULLs.
-- ============================================================
-- Part a:
SELECT COUNT(*) AS total_customers
FROM   sales.customers;
-- Result: 1445 customers

-- Part b:
SELECT COUNT(email) AS customers_with_email,
       COUNT(phone) AS customers_with_phone
FROM   sales.customers;
-- Result: 1445 have an email, 178 have a phone

-- Part c:
-- From parts a and b: 1445 - 178 = 1267 customers have no phone
SELECT COUNT(*) AS customers_without_phone
FROM   sales.customers
WHERE  phone IS NULL;
-- Result: 1267 (matches the calculation)


-- ============================================================
--  Question 3 — GROUP BY
-- ============================================================
-- Part a: total units sold per product
SELECT   product_id,
         SUM(quantity) AS total_units_sold
FROM     sales.order_items
GROUP BY product_id
ORDER BY total_units_sold DESC;

-- Part b: customers per state
SELECT   state,
         COUNT(*) AS customer_count
FROM     sales.customers
GROUP BY state
ORDER BY customer_count DESC;

-- Part c: orders per staff member and order status
SELECT   staff_id,
         order_status,
         COUNT(*) AS order_count
FROM     sales.orders
GROUP BY staff_id, order_status
ORDER BY staff_id, order_status;


-- ============================================================
--  Question 4 — GROUP BY with Joins
-- ============================================================
-- Part a: average price per category
SELECT   c.category_name,
         ROUND(AVG(p.list_price), 2) AS avg_list_price
FROM     production.products   AS p
JOIN     production.categories AS c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_list_price DESC;

-- Part b: number of products per brand
SELECT   b.brand_name,
         COUNT(p.product_id) AS product_count
FROM     production.products AS p
JOIN     production.brands   AS b ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY product_count DESC;

-- Part c: order count and total spent per customer
-- COUNT(DISTINCT o.order_id) is used because the join with
-- order_items repeats each order once per item.
SELECT   c.customer_id,
         c.first_name,
         c.last_name,
         COUNT(DISTINCT o.order_id) AS order_count,
         SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
FROM     sales.customers   AS c
JOIN     sales.orders      AS o  ON c.customer_id = o.customer_id
JOIN     sales.order_items AS oi ON o.order_id    = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;


-- ============================================================
--  Question 5 — HAVING
-- ============================================================
-- Part a: model years with more than 50 products
SELECT   model_year,
         COUNT(*) AS product_count
FROM     production.products
GROUP BY model_year
HAVING   COUNT(*) > 50;

-- Part b: customers with 2 or more orders
SELECT   customer_id,
         COUNT(*) AS order_count
FROM     sales.orders
GROUP BY customer_id
HAVING   COUNT(*) >= 2
ORDER BY order_count DESC;

-- Part c: products that sold more than 100 units
SELECT   product_id,
         SUM(quantity) AS total_units_sold
FROM     sales.order_items
GROUP BY product_id
HAVING   SUM(quantity) > 100
ORDER BY total_units_sold DESC;

-- Part d:
-- WHERE is applied to individual rows BEFORE the rows are
-- grouped, so at that point COUNT(*) per model_year does not
-- exist yet. Aggregate functions are not allowed in WHERE.
-- HAVING is applied AFTER GROUP BY, when each group's count
-- is known, so the condition COUNT(*) > 50 must go in HAVING.


-- ============================================================
--  Question 6 — WHERE + GROUP BY + HAVING Together
-- ============================================================
SELECT   o.store_id,
         SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM     sales.orders      AS o
JOIN     sales.order_items AS oi ON o.order_id = oi.order_id
WHERE    YEAR(o.order_date) = 2017                -- row filter (before grouping)
GROUP BY o.store_id
HAVING   SUM(oi.quantity * oi.list_price * (1 - oi.discount)) > 100000  -- group filter
ORDER BY total_revenue DESC;


-- ============================================================
--  Question 7 — Subquery in WHERE (IN)
-- ============================================================
-- Part a: orders by customers living in New York (city)
SELECT *
FROM   sales.orders
WHERE  customer_id IN (SELECT customer_id
                       FROM   sales.customers
                       WHERE  city = 'New York');

-- Part b: products in Electric Bikes or Cruisers Bicycles
SELECT product_id,
       product_name
FROM   production.products
WHERE  category_id IN (SELECT category_id
                       FROM   production.categories
                       WHERE  category_name IN ('Electric Bikes',
                                                'Cruisers Bicycles'));

-- Part c: customers who have placed at least one order
SELECT first_name,
       last_name,
       city
FROM   sales.customers
WHERE  customer_id IN (SELECT customer_id
                       FROM   sales.orders);


-- ============================================================
--  Question 8 — Subquery in WHERE (Scalar & NOT IN)
-- ============================================================
-- Part a: products above the average price
SELECT product_id,
       product_name,
       list_price
FROM   production.products
WHERE  list_price > (SELECT AVG(list_price)
                     FROM   production.products)
ORDER BY list_price DESC;

-- Part b: products below the average price
SELECT product_id,
       product_name,
       list_price
FROM   production.products
WHERE  list_price < (SELECT AVG(list_price)
                     FROM   production.products)
ORDER BY list_price;

-- count of products below the average price
SELECT COUNT(*) AS products_below_avg
FROM   production.products
WHERE  list_price < (SELECT AVG(list_price)
                     FROM   production.products);

-- Part c: customers who have never placed an order
-- (NULLs filtered out: if the subquery returned a NULL,
--  NOT IN would return no rows at all)
SELECT customer_id,
       first_name,
       last_name
FROM   sales.customers
WHERE  customer_id NOT IN (SELECT customer_id
                           FROM   sales.orders
                           WHERE  customer_id IS NOT NULL);

-- Part d: products that have never been ordered
SELECT product_id,
       product_name
FROM   production.products
WHERE  product_id NOT IN (SELECT product_id
                          FROM   sales.order_items
                          WHERE  product_id IS NOT NULL);


-- ============================================================
--  Question 9 — Subquery in FROM (Derived Table)
-- ============================================================
-- Part a: statistics of orders handled per staff member
SELECT AVG(order_count * 1.0) AS avg_orders_per_staff,   -- *1.0 avoids integer division
       MIN(order_count)       AS min_orders_per_staff,
       MAX(order_count)       AS max_orders_per_staff
FROM  (SELECT   staff_id,
                COUNT(*) AS order_count
       FROM     sales.orders
       GROUP BY staff_id) AS staff_orders;

-- Part b: average total spent across all customers
SELECT AVG(total_spent) AS avg_total_spent
FROM  (SELECT   o.customer_id,
                SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
       FROM     sales.orders      AS o
       JOIN     sales.order_items AS oi ON o.order_id = oi.order_id
       GROUP BY o.customer_id) AS customer_totals;


-- ============================================================
--  Question 10 — Subquery in SELECT
-- ============================================================
-- Part a: units sold per product (correlated subquery)
-- ISNULL turns NULL into 0 for products never sold
SELECT p.product_id,
       p.product_name,
       p.list_price,
       ISNULL((SELECT SUM(oi.quantity)
               FROM   sales.order_items AS oi
               WHERE  oi.product_id = p.product_id), 0) AS units_sold
FROM   production.products AS p
ORDER BY units_sold DESC;

-- Part b: item count and highest item price per order
SELECT o.order_id,
       o.order_date,
       (SELECT COUNT(*)
        FROM   sales.order_items AS oi
        WHERE  oi.order_id = o.order_id) AS item_count,
       (SELECT MAX(oi.list_price)
        FROM   sales.order_items AS oi
        WHERE  oi.order_id = o.order_id) AS max_item_price
FROM   sales.orders AS o
ORDER BY o.order_id;

-- Part c: difference from the average price
SELECT product_id,
       product_name,
       list_price,
       list_price - (SELECT AVG(list_price)
                     FROM   production.products) AS price_difference
FROM   production.products
ORDER BY price_difference DESC;


-- ============================================================
--  Question 11 — Challenge
-- ============================================================
SELECT   c.customer_id,
         c.first_name,
         c.last_name,
         SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spent
FROM     sales.customers   AS c
JOIN     sales.orders      AS o  ON c.customer_id = o.customer_id
JOIN     sales.order_items AS oi ON o.order_id    = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING   SUM(oi.quantity * oi.list_price * (1 - oi.discount)) >
         (SELECT AVG(total_spent)
          FROM  (SELECT   o2.customer_id,
                          SUM(oi2.quantity * oi2.list_price * (1 - oi2.discount)) AS total_spent
                 FROM     sales.orders      AS o2
                 JOIN     sales.order_items AS oi2 ON o2.order_id = oi2.order_id
                 GROUP BY o2.customer_id) AS customer_totals)
ORDER BY total_spent DESC;
