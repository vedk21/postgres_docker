WITH logins_list AS (
  SELECT user_id,
    login_timestamp::DATE AS login_date,
    LEAD(login_timestamp::DATE) OVER(
      PARTITION BY user_id
      ORDER BY login_timestamp
    ) AS next_day_login,
    LEAD(login_timestamp::DATE, 2) OVER(
      PARTITION BY user_id
      ORDER BY login_timestamp
    ) AS next_2_day_login
  FROM user_sessions
),
only_consecutive_logins AS (
  SELECT *,
    (next_day_login - login_date) AS diff1,
    (next_2_day_login - next_day_login) AS diff2
  FROM logins_list
  WHERE (next_day_login - login_date) = 1
    AND (next_2_day_login - next_day_login) = 1
)
SELECT DISTINCT user_id
FROM only_consecutive_logins;