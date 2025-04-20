-- Orders table --
SELECT *
FROM orders;

-- Find all orders for last three days from '2023-01-19' --
SELECT *
FROM orders
WHERE order_ts BETWEEN TO_DATE('2023-01-19', 'YYYY-MM-DD') - INTERVAL '3 days'
  AND TO_DATE('2023-01-19', 'YYYY-MM-DD')