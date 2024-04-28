COPY (
WITH temp AS (
  SELECT DISTINCT
    a.customer_id,
    a.timestamp as event_time,
    'appointments_table' as _source,
    a.type as event_name
  FROM './input_data/appointments.csv' as a
  --filter out missing timestamp and customer_id
  WHERE a.timestamp IS NOT NULL AND a.customer_id IS NOT NULL

  UNION ALL

  SELECT
    customer_id,
    order_time AS event_time,
    'orders_table' as _source,
    'first_order' as event_name
  FROM './orders_table.csv'
  --filter out missing customer_id
  WHERE customer_id IS NOT NULL
),

temp2 AS (
  -- populate missing event names if possible
  SELECT
    customer_id,
    event_time,
    _source,
    LAG(event_name) OVER (PARTITION BY customer_id ORDER BY event_time) AS lag_event_name,
    --returns first non-null value in list
    COALESCE(event_name, CASE
        WHEN lag_event_name = 'first_order' THEN 'on_site_appointment'
        WHEN lag_event_name = 'on_site_appointment' THEN 'project_call'
        WHEN lag_event_name = 'project_call' THEN 'final_call'
        ELSE 'event_name_unknown'
    END) AS event_name
  FROM temp
)

SELECT
  customer_id,
  event_time,
  event_name,
  _source,
  LAG(event_time) OVER (PARTITION BY customer_id ORDER BY event_time) AS lag_event_time,
  ROUND(
    EXTRACT(
      EPOCH FROM (
        event_time
        - LAG(event_time) OVER (
          PARTITION BY customer_id ORDER BY event_time
        )
      )
    ) / ( 24 * 60 * 60 ),
    2
  ) AS time_difference_events,
  -- populate lag_event_name again to check if some can be identified since missing event_name has been added for some in temp2
  LAG(event_name) OVER (PARTITION BY customer_id ORDER BY event_time) AS lag_event_name,
FROM temp2
)
TO 'events_table.csv' (HEADER, DELIMITER ',')
