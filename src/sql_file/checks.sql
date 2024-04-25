SELECT
  customer_id,
  order_date,
FROM './input_data/orders.csv'
GROUP BY customer_id, order_date
HAVING COUNT(*) > 1;
