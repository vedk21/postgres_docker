WITH RECURSIVE category_hierarchy AS (
  -- Base Case: Select top-level categories (those with NULL parent_category_id)
  SELECT category_id,
    category_name,
    parent_category_id,
    1 AS level,
    -- Starting level for top-level categories
    CAST(category_name AS TEXT) AS path_name -- Path for top level is just category name
  FROM categories -- Replace 'categories' with your actual category table name
  WHERE parent_category_id IS NULL
  UNION ALL
  -- Recursive Case: Join with the CTE itself to find children of categories from the previous level
  SELECT c.category_id,
    c.category_name,
    c.parent_category_id,
    ch.level + 1 AS level,
    -- Increment level for children
    CAST(ch.path_name || ' / ' || c.category_name AS TEXT) AS path_name -- Append child category to path
  FROM categories AS c -- Original category table (aliased as 'c' for clarity)
    INNER JOIN category_hierarchy AS ch ON c.parent_category_id = ch.category_id -- Join condition: child's parent_id matches parent's category_id in CTE
    -- WHERE condition can be added here if you need to limit recursion or filter further
) -- Final SELECT statement to display the hierarchical structure
SELECT category_id,
  category_name,
  parent_category_id,
  level,
  path_name,
  REPEAT('  ', level - 1) || category_name AS indented_category_name -- Indentation for visual hierarchy
FROM category_hierarchy
ORDER BY level,
  path_name;