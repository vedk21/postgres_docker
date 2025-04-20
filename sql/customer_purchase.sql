-- Customer purchase table --
SELECT *
FROM customer_purchases;

-- Find all customer whose first purchase is in last 6 months --
WITH purchase_in_last_6 AS (
  SELECT customer_id
  FROM customer_purchases
  WHERE purchase_date >= DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '6 MONTHS')
),
purchase_before_6 AS (
  SELECT customer_id
  FROM customer_purchases
  WHERE purchase_date < DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '6 MONTHS')
)
SELECT DISTINCT p.customer_id
FROM purchase_in_last_6 p
  LEFT JOIN purchase_before_6 c ON c.customer_id = p.customer_id
WHERE c.customer_id IS NULL;