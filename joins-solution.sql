-- Tasks for the SQL Join Challenge
-- BASE TASKS
-- 1. Get all customers and their addresses.
SELECT * 
FROM customers 
LEFT JOIN addresses ON customers.id = addresses.customer_id;

-- 2. Get all orders and their line items (orders, quantity and product).
SELECT * 
FROM orders 
JOIN line_items ON orders.id = line_items.order_id 
JOIN products ON products.id = line_items.product_id;

-- 3. Which warehouses have cheetos?
SELECT * 
FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'cheetos';

-- 4. Which warehouses have diet pepsi?
SELECT * 
FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

-- 5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT customers.first_name, customers.last_name, COUNT(orders.id) 
FROM customers
JOIN addresses ON customers.id = addresses.customer_id
JOIN orders ON orders.address_id = addresses.id
GROUP BY customers.id, customers.first_name, customers.last_name;

-- 6. How many customers do we have?
SELECT COUNT(id) FROM customers;

-- 7. How many products do we carry?
SELECT COUNT(id) FROM products;

-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM(on_hand) 
FROM warehouse_product
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

-- STRETCH TASKS
-- 9. How much was the total cost for each order?
SELECT orders.id, orders.order_date, SUM(products.unit_price * line_items.quantity) as total_cost
FROM orders
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY orders.id, orders.order_date;

-- 10. How much has each customer spent in total?
SELECT customers.first_name, SUM(products.unit_price * line_items.quantity) as total_spent
FROM customers
JOIN addresses ON addresses.customer_id = customers.id
JOIN orders ON orders.address_id = addresses.id
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY customers.id, customers.first_name;

-- 11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT customers.first_name, COALESCE(SUM(products.unit_price * line_items.quantity), 0) as total_spent
FROM customers
LEFT JOIN addresses ON addresses.customer_id = customers.id
LEFT JOIN orders ON orders.address_id = addresses.id
LEFT JOIN line_items ON line_items.order_id = orders.id
LEFT JOIN products ON products.id = line_items.product_id
GROUP BY customers.id, customers.first_name;
