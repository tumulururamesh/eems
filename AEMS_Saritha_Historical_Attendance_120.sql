
-- ============================================================
-- AEMS Pilot Demo Data
-- Saritha Cluster - Historical Attendance
--
-- Centres:
--   26KP06 - 24 students
--   26KP07 - 18 students
--
-- Adds:
--   4 days x 42 students = 168? 
--
-- NOTE:
-- This script is intentionally limited to 26KP06 and 26KP07.
-- Existing 26KP08 historical data is NOT touched.
-- Existing 04-Sep-2026 actual attendance is NOT touched.
-- ============================================================

INSERT INTO public.student_attendance
    (student_id, attendance_date, attendance_status, remarks, center_id)

SELECT
    s.student_id,
    d.attendance_date,

    CASE

        -- ----------------------------------------------------
        -- 31-Aug-2026
        -- 26KP06: 22 Present, 2 Absent
        -- 26KP07: 16 Present, 2 Absent
        -- ----------------------------------------------------
        WHEN d.attendance_date = DATE '2026-08-31'
             AND s.center_code = '26KP06'
             AND s.rn > 22
            THEN 'Absent'

        WHEN d.attendance_date = DATE '2026-08-31'
             AND s.center_code = '26KP07'
             AND s.rn > 16
            THEN 'Absent'


        -- ----------------------------------------------------
        -- 01-Sep-2026
        -- 26KP06: 23 Present, 1 Absent
        -- 26KP07: 17 Present, 1 Absent
        -- ----------------------------------------------------
        WHEN d.attendance_date = DATE '2026-09-01'
             AND s.center_code = '26KP06'
             AND s.rn > 23
            THEN 'Absent'

        WHEN d.attendance_date = DATE '2026-09-01'
             AND s.center_code = '26KP07'
             AND s.rn > 17
            THEN 'Absent'


        -- ----------------------------------------------------
        -- 02-Sep-2026
        -- 26KP06: 21 Present, 3 Absent
        -- 26KP07: 15 Present, 3 Absent
        -- ----------------------------------------------------
        WHEN d.attendance_date = DATE '2026-09-02'
             AND s.center_code = '26KP06'
             AND s.rn > 21
            THEN 'Absent'

        WHEN d.attendance_date = DATE '2026-09-02'
             AND s.center_code = '26KP07'
             AND s.rn > 15
            THEN 'Absent'


        -- ----------------------------------------------------
        -- 03-Sep-2026
        -- 26KP06: 22 Present, 2 Absent
        -- 26KP07: 16 Present, 2 Absent
        -- ----------------------------------------------------
        WHEN d.attendance_date = DATE '2026-09-03'
             AND s.center_code = '26KP06'
             AND s.rn > 22
            THEN 'Absent'

        WHEN d.attendance_date = DATE '2026-09-03'
             AND s.center_code = '26KP07'
             AND s.rn > 16
            THEN 'Absent'

        ELSE 'Present'

    END AS attendance_status,

    'Demo historical attendance' AS remarks,

    s.center_id

FROM
(
    SELECT
        sm.student_id,
        sm.center_id,
        tc.center_code,

        ROW_NUMBER() OVER (
            PARTITION BY sm.center_id
            ORDER BY sm.student_id
        ) AS rn

    FROM public.student_master sm

    JOIN public.tuition_center tc
        ON tc.center_id = sm.center_id

    WHERE tc.center_code IN ('26KP06', '26KP07')
      AND sm.active_flag = TRUE
) s

CROSS JOIN
(
    VALUES
        (DATE '2026-08-31'),
        (DATE '2026-09-01'),
        (DATE '2026-09-02'),
        (DATE '2026-09-03')
) AS d(attendance_date)

ON CONFLICT (student_id, attendance_date)
DO NOTHING;