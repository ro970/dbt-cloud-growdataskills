{{
    config(
        database='STAGING_DB',
        schema='stg',
        materialized='table'
    )
}}


WITH CTE AS
(
    SELECT * FROM {{source("snowflake_source","raw_payments")}}

),
Final AS (

    SELECT  
        ID AS PAYMENT_ID,
        ORDER_ID,
        PAYMENT_METHOD AS PAYMENT_MODE,
        AMOUNT/100 AS SALES_AMOUNT
    FROM CTE

)

SELECT * FROM Final