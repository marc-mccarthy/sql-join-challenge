-- Tasks for the SQL Join CHallenge

-- BASE TASKS
-- 1. Get all customers and their addresses.
SELECT * FROM customers JOIN addresses ON customers.id = addresses.customer_id;

-- 2. Get all orders and their line items (orders, quantity and product).
SELECT * FROM orders JOIN line_items ON orders.id = line_items.order_id JOIN products ON products.id = line_items.product_id;

-- 3. Which warehouses have cheetos?
SELECT * FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'cheetos';

-- 4. Which warehouses have diet pepsi?
SELECT * FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

-- 5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT COUNT(orders.id), customers.first_name, customers.last_name FROM orders
JOIN addresses ON addresses.id = orders.address_id
JOIN customers ON customers.id = addresses.customer_id
GROUP BY customers.first_name, customers.last_name;

-- 6. How many customers do we have?
SELECT COUNT(id) FROM customers;

-- 7. How many products do we carry?
SELECT COUNT(id) FROM products;

-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT COUNT(on_hand) FROM warehouse_product
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

-- STRETCH TASKS
-- 9. How much was the total cost for each order?
SELECT SUM(products.unit_price), orders.order_date, orders.id FROM orders
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY orders.order_date, orders.id;

-- 10. How much has each customer spent in total?
SELECT SUM(products.unit_price), customers.first_name FROM customers
JOIN addresses ON addresses.customer_id = customers.id
JOIN orders ON orders.address_id = addresses.id
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY customers.first_name;

-- 11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT COALESCE(SUM(products.unit_price),0), customers.first_name FROM customers
JOIN addresses ON addresses.customer_id = customers.id
LEFT JOIN orders ON orders.address_id = addresses.id
LEFT JOIN line_items ON line_items.order_id = orders.id
LEFT JOIN products ON products.id = line_items.product_id
GROUP BY customers.first_name;
