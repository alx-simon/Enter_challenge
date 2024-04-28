COPY (
SELECT
  t.customer_id,
  t.event_time,
  t.event_name,
  t._source,
  t.lag_event_time,
  t.time_difference_events,
  t.lag_event_name,
  c.postal_code_group
FROM './events_table.csv' AS t
LEFT JOIN './customers_table.csv' AS c ON c.customer_id = t.customer_id
ORDER BY
  t.customer_id, t.event_time
)
TO 'analysis_table.csv' (HEADER, DELIMITER ',')
