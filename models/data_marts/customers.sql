{{
    config(
        database='GOLDEN_LAYER_DB',
        schema='GOLD',
        materialized='table'
    )
}}

with customers AS (
    SELECT * FROM {{ref('stg_customers')}}
),

orders AS(
    SELECT * FROM {{ref('stg_orders')}}
),

payments AS(
    SELECT * FROM {{ref('stg_payments')}}    
),


customer_level_details AS (
  SELECT 
     c.FIRST_NAME,
     c.CUSTOMER_ID,
     MIN(o.ORDER_DATE) AS first_order,
     MAX(o.ORDER_DATE) AS most_recent_order
  FROM customers c
  LEFT JOIN orders o 
  ON c.Customer_ID = o.CUSTOMER_ID   
  GROUP BY c.FIRST_NAME, c.LAST_NAME, c.CUSTOMER_ID 
),


payment_details AS
(
    SELECT 
        o.Customer_ID,
        SUM(p.SALES_AMOUNT) AS Amount,
    FROM payments p
    LEFT JOIN orders o
    ON p.ORDER_ID = o.ORDER_ID
    GROUP BY o.Customer_ID
),

Final AS(
    SELECT 
        cl.FIRST_NAME,
        cl.CUSTOMER_ID,
        cl.first_order,
        cl.most_recent_order,
        pd.Amount
    FROM customer_level_details cl
    LEFT JOIN payment_details pd
    ON cl.CUSTOMER_ID = pd.Customer_ID
)

SELECT * FROM Final
