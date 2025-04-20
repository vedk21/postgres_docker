-- Employees Table --
SELECT *
FROM employee;

-- Find all employees who earn more than the
-- average salary of their department
SELECT e1.*
FROM employee e1
  JOIN (
    SELECT dept,
      ROUND(AVG(salary), 2) AS avg_salary
    FROM employee
    GROUP BY dept
  ) e2 ON e1.dept = e2.dept
  AND e1.salary > e2.avg_salary;

-- Find most frequently occurring salary --
SELECT salary,
  COUNT(*) AS freq
FROM employee
GROUP BY salary
ORDER BY freq DESC
LIMIT 1;

-- Find all employess who share same salary --
SELECT DISTINCT e1.id AS id
FROM employee e1
  JOIN employee e2 ON e1.salary = e2.salary
  AND e1.id != e2.id;

-- Find median salary --
WITH ordered_salaries AS (
  SELECT salary,
    ROW_NUMBER() OVER(
      ORDER BY salary
    ) AS row_num,
    COUNT(*) OVER() AS total_salaries
  FROM employee
)
SELECT CASE
    WHEN (total_salaries % 2) = 1 THEN (
      SELECT salary
      FROM ordered_salaries
      WHERE row_num = CEIL(total_salaries / 2.0)
    )
    ELSE (
      SELECT ROUND(AVG(salary), 2)
      FROM ordered_salaries
      WHERE row_num IN (
          total_salaries / 2,
          total_salaries / 2 + 1
        )
    )
  END AS median_salary
FROM ordered_salaries
LIMIT 1;