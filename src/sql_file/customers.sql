COPY (
SELECT c.customer_id, c.postal_code
FROM './input_data/orders.csv' c
LEFT JOIN(
  SELECT customer_id, MAX(order_date) AS latest_order
  FROM './input_data/orders.csv'
  GROUP BY customer_id) latest ON c.customer_id = latest.customer_id AND c.order_date=latest.latest_order)
  TO 'customers_table.csv' (HEADER, DELIMITER ',')
