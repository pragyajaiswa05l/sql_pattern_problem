-- Question: Show each order with a running total of amount across all orders ordered by order_date

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
order_date DATE,
amount NUMERIC(10,2)
);
INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2024-01-05', 250.00),
(1, '2024-01-12', 180.00),
(1, '2024-01-20', 320.00),
(1, '2024-02-03', 150.00),
(2, '2024-01-08', 400.00),
(2, '2024-01-22', 275.00),
(2, '2024-02-10', 190.00),
(3, '2024-01-15', 500.00),
(3, '2024-01-30', 225.00);


-- SOLUTION:
select 
  order_id,
  order_date,
  amount,
  sum(amount) over(order by order_date asc) as running_total
from orders
