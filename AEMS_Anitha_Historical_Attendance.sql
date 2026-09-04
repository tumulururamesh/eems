
-- =========================================================
-- AEMS PILOT
-- MACHERLA ANITHA - HISTORICAL DEMO ATTENDANCE
--
-- Centres:
-- 26AG08 - 25 students
-- 26AG09 - 17 students
-- 26AG10 - 24 students
--
-- Historical dates:
-- 31 Aug 2026
-- 01 Sep 2026
-- 02 Sep 2026
-- 03 Sep 2026
--
-- 04 Sep 2026 is REAL attendance and is NOT touched.
-- =========================================================


-- =========================================================
-- 26AG08
-- =========================================================

INSERT INTO public.student_attendance
    (student_id, attendance_date, attendance_status, remarks, center_id)

SELECT
    s.student_id,
    d.attendance_date,

    CASE
        WHEN ROW_NUMBER() OVER (
            PARTITION BY d.attendance_date
            ORDER BY s.student_id
        ) <= d.absent_count
        THEN 'Absent'
        ELSE 'Present'
    END,

    'Demo historical attendance',

    s.center_id

FROM public.student_master s

JOIN public.tuition_center tc
    ON tc.center_id = s.center_id

CROSS JOIN (
    VALUES
        ('2026-08-31'::date, 3),
        ('2026-09-01'::date, 2),
        ('2026-09-02'::date, 4),
        ('2026-09-03'::date, 3)
) AS d(attendance_date, absent_count)

WHERE tc.center_code = '26AG08'
  AND s.active_flag = TRUE

ON CONFLICT (student_id, attendance_date)
DO NOTHING;


-- =========================================================
-- 26AG09
-- =========================================================

INSERT INTO public.student_attendance
    (student_id, attendance_date, attendance_status, remarks, center_id)

SELECT
    s.student_id,
    d.attendance_date,

    CASE
        WHEN ROW_NUMBER() OVER (
            PARTITION BY d.attendance_date
            ORDER BY s.student_id
        ) <= d.absent_count
        THEN 'Absent'
        ELSE 'Present'
    END,

    'Demo historical attendance',

    s.center_id

FROM public.student_master s

JOIN public.tuition_center tc
    ON tc.center_id = s.center_id

CROSS JOIN (
    VALUES
        ('2026-08-31'::date, 2),
        ('2026-09-01'::date, 1),
        ('2026-09-02'::date, 3),
        ('2026-09-03'::date, 2)
) AS d(attendance_date, absent_count)

WHERE tc.center_code = '26AG09'
  AND s.active_flag = TRUE

ON CONFLICT (student_id, attendance_date)
DO NOTHING;


-- =========================================================
-- 26AG10
-- =========================================================

INSERT INTO public.student_attendance
    (student_id, attendance_date, attendance_status, remarks, center_id)

SELECT
    s.student_id,
    d.attendance_date,

    CASE
        WHEN ROW_NUMBER() OVER (
            PARTITION BY d.attendance_date
            ORDER BY s.student_id
        ) <= d.absent_count
        THEN 'Absent'
        ELSE 'Present'
    END,

    'Demo historical attendance',

    s.center_id

FROM public.student_master s

JOIN public.tuition_center tc
    ON tc.center_id = s.center_id

CROSS JOIN (
    VALUES
        ('2026-08-31'::date, 3),
        ('2026-09-01'::date, 2),
        ('2026-09-02'::date, 4),
        ('2026-09-03'::date, 3)
) AS d(attendance_date, absent_count)

WHERE tc.center_code = '26AG10'
  AND s.active_flag = TRUE

ON CONFLICT (student_id, attendance_date)
DO NOTHING;