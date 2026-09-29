-- Question: For user_id = 1 , find all dates between 2024-01-01 and 2024-01-10 where the user did
-- NOT log in.

CREATE TABLE user_logins (
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

WITH dates AS (
    SELECT CAST('2024-01-01' AS DATE) AS missing_date

    UNION ALL

    SELECT DATEADD(DAY, 1, missing_date)
    FROM dates
    WHERE missing_date < CAST('2024-01-10' AS DATE)
)
SELECT d.missing_date
FROM dates d
LEFT JOIN user_logins u
    ON CAST(u.login_date AS DATE) = d.missing_date
    AND u.user_id = 1
WHERE u.user_id IS NULL
ORDER BY d.missing_date
-- OPTION (MAXRECURSION 100);
