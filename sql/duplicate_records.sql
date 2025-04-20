-- Orders Table
SELECT *
FROM orders;

-- Find all duplicate order_id's --
SELECT order_id
FROM orders
GROUP BY order_id
HAVING COUNT(order_id) > 1;

-- Find all occurences of duplicate order_id's
SELECT order_id,
  occurrence_count
FROM (
    SELECT order_id,
      COUNT(*) AS occurrence_count
    FROM orders
    GROUP BY order_id
  ) AS order_counts
WHERE occurrence_count > 1;

-- Find all rows with duplicate order_id's --
SELECT *
FROM orders
WHERE order_id IN (
    SELECT o1.order_id
    FROM orders o1
      JOIN orders o2 ON o1.order_id = o2.order_id
    GROUP BY o1.order_id
    HAVING COUNT(o2.order_id) > 1
  );

-- Find duplicate based on order_id's and cust_id's --
SELECT cust_id,
  order_id
FROM orders
GROUP BY cust_id,
  order_id
HAVING COUNT(*) > 1;

-- Second orders table for delete records query --
DROP TABLE IF EXISTS orders_delete;

CREATE TABLE if not exists orders_delete (
  cust_id INTEGER,
  order_id INTEGER,
  order_ts TIMESTAMP,
  region VARCHAR(50)
);

INSERT INTO orders_delete (cust_id, order_id, order_ts, region)
VALUES (1, 101, '2023-01-15 10:00:00', 'North'),
  (2, 102, '2023-01-15 11:30:00', 'South'),
  (3, 103, '2023-01-15 12:45:00', 'East'),
  (4, 104, '2023-01-15 14:00:00', 'West'),
  (5, 105, '2023-01-15 15:15:00', 'Central'),
  (6, 101, '2023-01-15 16:30:00', 'North'),
  -- Duplicate cust_id, order_id
  (2, 106, '2023-01-16 09:00:00', 'South'),
  (3, 107, '2023-01-16 10:15:00', 'East'),
  (4, 108, '2023-01-16 11:30:00', 'West'),
  (5, 109, '2023-01-16 12:45:00', 'Central'),
  (1, 110, '2023-01-16 14:00:00', 'North'),
  (2, 102, '2023-01-16 15:15:00', 'South'),
  -- Duplicate cust_id, order_id
  (3, 103, '2023-01-17 10:00:00', 'East'),
  -- Duplicate cust_id, order_id
  (4, 111, '2023-01-17 11:30:00', 'West'),
  (5, 112, '2023-01-17 12:45:00', 'Central'),
  (1, 113, '2023-01-17 14:00:00', 'North'),
  (2, 114, '2023-01-17 15:15:00', 'South'),
  (3, 115, '2023-01-18 09:00:00', 'East'),
  (4, 104, '2023-01-18 10:15:00', 'West'),
  -- Duplicate cust_id, order_id
  (5, 105, '2023-01-18 11:30:00', 'Central'),
  -- Duplicate cust_id, order_id
  (1, 116, '2023-01-18 12:45:00', 'North'),
  (2, 117, '2023-01-18 14:00:00', 'South'),
  (3, 118, '2023-01-19 10:00:00', 'East'),
  (4, 119, '2023-01-19 11:30:00', 'West'),
  (5, 120, '2023-01-19 12:45:00', 'Central');

-- Delete record/s with duplicate order_id's --
-- WITH duplicate_orders AS (
--   SELECT cust_id,
--     order_id
--   FROM orders_delete
--   GROUP BY cust_id,
--     order_id
--   HAVING COUNT(*) > 1
-- )
-- DELETE FROM orders_delete
-- WHERE order_id IN (
--     SELECT order_id
--     FROM duplicate_orders
--   )
--   AND cust_id IN (
--     SELECT cust_id
--     FROM duplicate_orders
--   );
-- -- Orders Table
-- SELECT *
-- FROM orders_delete;
-- Delete duplicate entry only --
WITH duplicate_records_row_num AS (
  SELECT *,
    ROW_NUMBER() OVER(
      PARTITION BY order_id,
      cust_id
      ORDER BY order_ts
    ) AS row_num
  FROM orders_delete
)
DELETE FROM orders_delete USING (
    SELECT *
    FROM duplicate_records_row_num
  ) AS dp
WHERE orders_delete.cust_id = dp.cust_id
  AND orders_delete.order_id = dp.order_id
  AND dp.row_num > 1
  AND orders_delete.order_ts = dp.order_ts;

-- Orders Table
SELECT *
FROM orders_delete;