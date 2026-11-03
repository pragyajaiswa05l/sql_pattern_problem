-- Question: Calculate the 3-day moving average of close_price for AAPL ordered by price_date .

CREATE TABLE stock_prices (
price_id SERIAL PRIMARY KEY,
stock VARCHAR(10),
price_date DATE,
close_price NUMERIC(10,2)
);
INSERT INTO stock_prices (stock, price_date, close_price) VALUES
('AAPL', '2024-01-01', 185.20),
('AAPL', '2024-01-02', 187.50),
('AAPL', '2024-01-03', 183.80),
('AAPL', '2024-01-04', 189.00),
('AAPL', '2024-01-05', 192.30),
('AAPL', '2024-01-08', 190.10),
('AAPL', '2024-01-09', 194.50),
('MSFT', '2024-01-01', 375.00),
('MSFT', '2024-01-02', 378.20),
('MSFT', '2024-01-03', 372.50),
('MSFT', '2024-01-04', 380.00),
('MSFT', '2024-01-05', 383.70);


-- SOLUTION:

select
  price_date,
  close_price,
  round(avg(close_price) over(PARTITION BY stock
  ORDER BY price_date asc
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ),2) as moving_avg_3
from stock_prices
where stock = 'AAPL'
