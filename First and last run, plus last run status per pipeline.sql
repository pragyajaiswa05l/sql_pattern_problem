-- Question: For each pipeline, show the first run time, last run time, and the status of the most recent run.

CREATE TABLE pipeline_runs (
run_id SERIAL PRIMARY KEY,
pipeline VARCHAR(50),
status VARCHAR(20),
run_at TIMESTAMP
);
INSERT INTO pipeline_runs (pipeline, status, run_at) VALUES
('etl_orders', 'SUCCESS', '2024-01-10 08:00:00'),
('etl_orders', 'FAILED', '2024-01-11 08:05:00'),
('etl_orders', 'SUCCESS', '2024-01-12 08:10:00'),
('etl_orders', 'SUCCESS', '2024-01-13 08:00:00'),
('etl_customers', 'SUCCESS', '2024-01-10 09:00:00'),
('etl_customers', 'SUCCESS', '2024-01-11 09:05:00'),
('etl_customers', 'FAILED', '2024-01-12 09:10:00'),
('etl_products', 'FAILED', '2024-01-10 10:00:00'),
('etl_products', 'FAILED', '2024-01-11 10:05:00'),
('etl_products', 'SUCCESS', '2024-01-12 10:10:00');



-- SOLUTION:

with cte as (Select
  pipeline,
  min(run_at) as first_run,
  max(run_at) as last_run
from pipeline_runs
group by pipeline)
select 
  c.pipeline,
  c.first_run,
  c.last_run,
  p.status as last_status
from cte c 
  inner join 
pipeline_runs p 
on c.pipeline = p.pipeline and c.last_run = p.run_at
