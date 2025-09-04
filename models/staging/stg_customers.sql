{{
    config(
        database='STAGING_DB',
        schema='stg',
        materialized='table'
    )
}}

WITH CTE AS
(

    SELECT * FROM {{source("snowflake_source","raw_customers")}}
),

Final AS
(
    SELECT 
     ID AS Customer_ID,
     FIRST_NAME,
     LAST_NAME
    
     FROM CTE
)

SELECT * FROM Final