WITH students AS(
    SELECT * FROM {{ref('stg_students')}}
),

courses AS(
    SELECT * FROM {{ref("stg_courses")}}
),

enrollments AS(
    SELECT * FROM {{ref('stg_enrollments')}}
),


Final AS(
    SELECT s.*,e.enrollment_ID FROM students s
    LEFT JOIN enrollments e
    ON s.student_id = e.student_id
)

SELECT * FROM Final
