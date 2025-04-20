-- Products table --
SELECT *
FROM products;

-- Orders table --
SELECT *
FROM product_orders;

-- Find all products that were never sold --
SELECT p.product_id,
  p.product_name
FROM products p
  LEFT JOIN product_orders po ON p.product_id = po.product_id
WHERE po.order_id IS NULL;