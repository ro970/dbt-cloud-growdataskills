{{
    config(
        database='STAGING_DB',
        schema='stg',
        materialized='table'
    )
}}


WITH CTE AS
(

    SELECT * FROM {{source("snowflake_source","raw_orders")}}
),

Final AS
(
    SELECT 
        ID AS ORDER_ID,
        USER_ID AS CUSTOMER_ID,
        ORDER_DATE,
        STATUS      
    FROM CTE
)

SELECT  * FROM Final