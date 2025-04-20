SELECT original_table.id,
  original_table.product_name,
  split_value
FROM product_tags AS original_table,
  UNNEST(string_to_array(original_table.tags_column, ',')) AS split_value
ORDER BY original_table.id -- unnested_value.position;