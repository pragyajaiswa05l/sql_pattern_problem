-- Question: For each user, identify each consecutive login streak — its start date, end date, and length in days.
CREATE TABLE user_logins (
login_id SERIAL PRIMARY KEY,
user_id INT,
login_date DATE
);
INSERT INTO user_logins (user_id, login_date) VALUES
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-03'),
(1, '2024-01-07'),
(1, '2024-01-08'),
(1, '2024-01-15'),
(2, '2024-01-01'),
(2, '2024-01-04'),
(2, '2024-01-05'),
(2, '2024-01-06');


-- SOLUTION:

with cte as (
  select 
    user_id,
    login_date,
    row_number() over(partition by user_id order by login_date asc) as rn
  from user_logins), 
  cte2 as (
    select
        user_id,
        login_date,
        rn,
        DATE_SUB(login_date,interval (rn) day) as subdate 
  from cte
  ) select 
    user_id, 
    min(login_date) as streak_start,
    max(login_date) as streak_end, 
    DATEDIFF(MAX(login_date), MIN(login_date)) + 1 AS streak_days 
  from cte2 
  group by user_id,subdate

