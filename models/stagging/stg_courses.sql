
WITH RAW AS(

SELECT * FROM {{ source('SF_SOURCES', 'courses') }}

),

Final AS(

-- level of course
-- is the course still running
-- how many days have passed since the course started


    SELECT *,
        CASE WHEN Credits = 3 THEN 'Beginner'
             WHEN Credits = 4 THEN 'Advanced'
            ELSE 'More Advanced'
        END AS Course_Description ,     -- level of course

        CASE 
            WHEN CURRENT_DATE () BETWEEN START_DATE AND END_DATE THEN 'Active'
                ELSE 'Inactive'
        END AS Active_Flag,  -- is the course still running
        
        DATEDIFF('DAY',START_DATE,CURRENT_DATE()) AS Total_Days_Passed  -- how many days have passed since the course started        
        
         FROM RAW

     ORDER BY Credits,Total_Days_Passed    


)


SELECT * FROM Final


