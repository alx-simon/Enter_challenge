COPY (
  SELECT
    c.customer_id,
    c.postal_code,
    FLOOR(c.postal_code / 10000) AS postal_code_group
  FROM './input_data/orders.csv' c
  WHERE customer_id IS NOT NULL
  -- Force filter out any duplicates on customer_id (take only most recent reference)
  QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1
)
TO 'customers_table.csv' (HEADER, DELIMITER ',')
