-- Find month-over-month sales --
WITH monthly_sales_ordered AS (
  SELECT *,
    LAG(sales_amount) OVER(
      ORDER BY sales_date
    ) AS last_sales_amount
  FROM monthly_sales_simplified
)
SELECT sales_date,
  ROUND(
    (sales_amount - last_sales_amount) / last_sales_amount * 100.0,
    2
  ) AS mom_sales
FROM monthly_sales_ordered