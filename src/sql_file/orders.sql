COPY (SELECT
  CONCAT(customer_id,order_date) as order_id,
  customer_id,
  order_date as event_time,
  postal_code,
  'first_order' as event_name
FROM './input_data/orders.csv') TO 'orders_table.csv' (HEADER, DELIMITER ',')
