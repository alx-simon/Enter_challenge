COPY (
  SELECT
    CONCAT(customer_id, order_date) as order_id,
    customer_id,
    order_date as order_time,
    postal_code
  FROM './input_data/orders.csv'
  WHERE CONCAT(customer_id, order_date) IS NOT NULL
) TO 'orders_table.csv' (HEADER, DELIMITER ',')
