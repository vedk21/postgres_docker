-- CREATE TABLE sequential_numbers (
--     seq_id SERIAL PRIMARY KEY,        -- Auto-incrementing primary key (optional, for table ID)
--     seq_val INTEGER NOT NULL UNIQUE   -- The sequential number column itself, enforcing uniqueness
--     -- Add other relevant columns if needed
-- );
-- -- 2. INSERT statements to populate 'sequential_numbers' with data containing gaps
-- INSERT INTO sequential_numbers (seq_val) VALUES
-- (1),
-- (2),
-- (3),
-- -- Gap: Missing 4, 5
-- (6),
-- (7),
-- -- Gap: Missing 8, 9
-- (10),
-- (11),
-- (12),
-- -- Gap: Missing 13, 14, 15, 16, 17, 18, 19
-- (20),
-- (21);
WITH seq_list AS (
  SELECT seq_val,
    LEAD(seq_val) OVER(
      ORDER BY seq_val
    ) AS next_seq_val
  FROM sequential_numbers
)
SELECT seq_val,
  next_seq_val
FROM seq_list
WHERE next_seq_val - seq_val > 1;