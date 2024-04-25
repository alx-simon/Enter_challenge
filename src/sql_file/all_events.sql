COPY (
  WITH temp as (
  SELECT
    a.customer_id,
    a.timestamp as event_time,
    'appointments_table' as _source,
    a.type as event_name,
  FROM './input_data/appointments.csv' as a
  WHERE a.timestamp IS NOT NULL AND a.customer_id IS NOT NULL

  UNION ALL

  SELECT
    customer_id,
    event_time,
    'orders_table' as _source,
    event_name,
  FROM './orders_table.csv'
  WHERE customer_id IS NOT NULL
),

temp2 AS (
  SELECT
    customer_id,
    event_time,
    _source,
    LAG(event_name) OVER (PARTITION BY customer_id ORDER BY event_time) AS lag_event_name,
    COALESCE(event_name, CASE
        WHEN lag_event_name = 'first_order' THEN 'on_site_appointment'
        WHEN lag_event_name = 'on_site_appointment' THEN 'project_call'
        WHEN lag_event_name = 'project_call' THEN 'final_call'
        ELSE 'no_prior_event'
    END) AS event_name,
  FROM temp
)

SELECT
  customer_id,
  event_time,
  event_name,
  _source,
  LAG(event_time) OVER (PARTITION BY customer_id ORDER BY event_time) AS lag_event_time,
  (EXTRACT(EPOCH FROM event_time - lag_event_time)/60) AS time_difference_events,
  LAG(event_name) OVER (PARTITION BY customer_id ORDER BY event_time) AS lag_event_name,
FROM temp2

Order BY customer_id, event_time
)
TO 'events_table.csv' (HEADER, DELIMITER ',')
