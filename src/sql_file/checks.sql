SELECT
  customer_id,
  order_date,
FROM './input_data/orders.csv'
GROUP BY customer_id, order_date
HAVING COUNT(*) > 1;


SELECT
  customer_id,
  event_time,
  event_name
FROM './events_table.csv'
GROUP BY customer_id, event_time, event_name
HAVING COUNT(*) > 1;
