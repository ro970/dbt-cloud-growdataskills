WITH RAW AS
(
SELECT * FROM {{source("SF_SOURCES",'students')}}
),

FINAL AS 
(
    SELECT *,  DATEDIFF(YEAR,DATE_OF_BIRTH,CURRENT_DATE()) AS Age,  -- Age 
               YEAR(ENROLLMENT_DATE) AS Enrollment_Year,             -- Enrollment year
               CONCAT_WS(' ',first_name,last_name) AS Full_Name,      -- Full Name
               DATEDIFF(DAY,ENROLLMENT_DATE,CURRENT_DATE()) AS Total_Day_Of_Enrollment -- Total Days Of Enrollment     

    
     FROM RAW

)

SELECT * FROM FINAL




