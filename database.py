
# database.py
import psycopg2
from psycopg2.extras import RealDictCursor
from config import DB_CONFIG


def get_connection():

    conn = psycopg2.connect(
        host=DB_CONFIG["host"],
        database=DB_CONFIG["database"],
        user=DB_CONFIG["user"],
        password=DB_CONFIG["password"],
        port=DB_CONFIG["port"],
        cursor_factory=RealDictCursor
    )

    # Set default schema
    cur = conn.cursor()
    cur.execute("SET search_path TO vidya_vahini, public;")
    cur.close()

    return conn



def get_academic_year_id(academic_year):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""

        SELECT academic_year_id

        FROM academic_year_master

        WHERE academic_year = %s

    """, (academic_year,))

    row = cur.fetchone()

    cur.close()
    conn.close()

    if row:
        return row["academic_year_id"]

    return None

def search_students(search_text):

    conn = get_connection()
    cur = conn.cursor()

    if search_text.isdigit():

        sql = """
            SELECT
                student_id,
                student_name,
                village_name,
                school_name,
                current_stage,
                ssc_percentage
            FROM vw_student_summary_profile
            WHERE student_id = %s
            ORDER BY student_name
        """

        cur.execute(sql, (int(search_text),))

    else:

        value = f"%{search_text}%"

        sql = """
            SELECT
                student_id,
                student_name,
                village_name,
                school_name,
                current_stage,
                ssc_percentage
            FROM vw_student_summary_profile
            WHERE
                   student_name ILIKE %s
                OR village_name ILIKE %s
                OR school_name ILIKE %s
            ORDER BY student_name
        """

        cur.execute(sql, (value, value, value))

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows

# =====================================================
# STUDENT JOURNEY
# =====================================================

def get_student_journey(student_id):

    conn = get_connection()
    cur = conn.cursor()

    query = """
        SELECT
            *
        FROM
            vidya_vahini.vw_student_journey
        WHERE
            student_id = %s
        ORDER BY
            COALESCE(admission_date, completion_date),
            education_level;
    """

    cur.execute(query, (student_id,))

    journey_events = cur.fetchall()

    cur.close()
    conn.close()

    return journey_events

def get_centre_directory():

    conn = get_connection()
    cur = conn.cursor()

    query = """
        SELECT
            tc.center_id,
            tc.center_name,
            vm.village_name,
            tm.tutor_name,
            tc.status,
            tc.start_date

        FROM tuition_center tc

        LEFT JOIN village_master vm
            ON tc.village_id = vm.village_id

        LEFT JOIN tutor_master tm
            ON tc.tutor_id = tm.tutor_id

        ORDER BY tc.center_name;
    """

    cur.execute(query)
    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows

def get_village_mapping():

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""

        SELECT

            tc.center_id,
            tc.center_name,
            vm.village_name,
            mm.mandal_name,
            dm.district_name,
            tm.tutor_name,
            tc.status

        FROM tuition_center tc

        JOIN village_master vm
            ON tc.village_id = vm.village_id

        JOIN mandal_master mm
            ON vm.mandal_id = mm.mandal_id

        JOIN district_master dm
            ON vm.district_id = dm.district_id

        LEFT JOIN tutor_master tm
            ON tc.tutor_id = tm.tutor_id

        ORDER BY

            dm.district_name,
            mm.mandal_name,
            vm.village_name;

    """)

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows

# =====================================================
# CENTRE-WISE STUDENT STRENGTH
# =====================================================

def get_center_student_strength(academic_year_id):

    conn = get_connection()
    cur = conn.cursor()

    query = """

        SELECT

            tc.center_id,
            tc.center_name,
            vm.village_name,
            tm.tutor_name,

            COUNT(*) FILTER (
                WHERE sm.gender = 'Boy'
                AND say.student_id IS NOT NULL
            ) AS boys,

            COUNT(*) FILTER (
                WHERE sm.gender = 'Girl'
                AND say.student_id IS NOT NULL
            ) AS girls,

            COUNT(say.student_id) AS total_students

        FROM public.tuition_center tc

        LEFT JOIN public.student_master sm
               ON tc.center_id = sm.center_id
              AND sm.active_flag = TRUE

        LEFT JOIN public.student_academic_year say
                ON sm.student_id = say.student_id
                AND say.academic_year_id = %s

        LEFT JOIN public.village_master vm
               ON tc.village_id = vm.village_id

        LEFT JOIN public.tutor_master tm
               ON tc.tutor_id = tm.tutor_id

        GROUP BY

            tc.center_id,
            tc.center_name,
            vm.village_name,
            tm.tutor_name

        ORDER BY

            total_students DESC,
            tc.center_name;

    """

    cur.execute(query, (academic_year_id,))

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows


def get_all_centres():

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""

        SELECT
            center_id,
            center_name

        FROM tuition_center

        ORDER BY center_name

    """)

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows


def get_classwise_student_strength(academic_year_id, center_id):

    conn = get_connection()
    cur = conn.cursor()

    query = """

    SELECT

    say.class_studying,

    COUNT(*) FILTER (WHERE sm.gender = 'Boy') AS boys,

    COUNT(*) FILTER (WHERE sm.gender = 'Girl') AS girls,

    COUNT(*) AS total_students

FROM public.student_master sm

JOIN public.student_academic_year say
     ON sm.student_id = say.student_id

WHERE
      sm.center_id = %s
  AND say.academic_year_id = %s
  AND sm.active_flag = TRUE

GROUP BY
    say.class_studying

ORDER BY
    say.class_studying;

     """

    cur.execute(query, (center_id, academic_year_id))

    rows = cur.fetchall()

      
    cur.close()
    conn.close()

    return rows


# =====================================================
# FEE SECTION
# =====================================================

def get_centre_fee_summary(
    academic_year_id,
    fee_month
    ):
        
     
        conn = get_connection()
        cur = conn.cursor()

        query = """

        SELECT

            tc.center_id,

            tc.center_name,

            COUNT(*) AS total_students,

            COUNT(sfp.student_id) AS paid_students,

            COUNT(*) - COUNT(sfp.student_id) AS not_paid_students,

            ROUND(

                COUNT(sfp.student_id) * 100.0 /
                COUNT(*),

                1

            ) AS collection_percent

        FROM public.student_master sm

        JOIN public.tuition_center tc

            ON sm.center_id = tc.center_id

        JOIN public.student_academic_year say

            ON sm.student_id = say.student_id

        LEFT JOIN public.student_fee_payment sfp

            ON sm.student_id = sfp.student_id

        AND sfp.academic_year_id = say.academic_year_id

        AND sfp.fee_month = %s

        WHERE

            sm.active_flag = TRUE

        AND say.academic_year_id = %s

        GROUP BY

            tc.center_id,

            tc.center_name

        ORDER BY

            collection_percent DESC,

            tc.center_name

    """
        
        
        cur.execute(

            query,

        (

            fee_month,

            academic_year_id

        )

    )

        rows = cur.fetchall()

        cur.close()
        conn.close()

        return rows



# =====================================================
#               ATTENDANCE REPORT
# =====================================================


def get_centre_monthly_attendance_summary(
    attendance_month
):

    conn = get_connection()
    cur = conn.cursor()

    query = """

    SELECT

        tc.center_id,

        tc.center_name,

        COUNT(*) AS total_students,

        COUNT(*) FILTER (

            WHERE sa.attendance_status = 'Present'

        ) AS present_students,

        COUNT(*) FILTER (

            WHERE sa.attendance_status = 'Absent'

        ) AS absent_students,

        ROUND(

            COUNT(*) FILTER (

                WHERE sa.attendance_status = 'Present'

            ) * 100.0 /

            COUNT(*),

            1

        ) AS attendance_percent

    FROM public.student_attendance sa

    JOIN public.tuition_center tc

        ON sa.center_id = tc.center_id

    WHERE

        DATE_TRUNC('month', sa.attendance_date)
            = DATE_TRUNC('month', %s::date)

    GROUP BY

        tc.center_id,
        tc.center_name

    ORDER BY

        attendance_percent DESC,
        tc.center_name

    """

    cur.execute(

        query,

        (attendance_month,)

    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows


# =====================================================
# SMARTLABS SECTION
# =====================================================


def get_smartlabs_dashboard_summary():

    conn = get_connection()
    cur = conn.cursor()

    dashboard = {}

    # Number of Schools
    cur.execute("""
        SELECT COUNT(*)
        FROM smartlab.school_master;
    """)
    dashboard["school_count"] = cur.fetchone()["count"]

    # Number of Students
    cur.execute("""
        SELECT COUNT(*)
        FROM smartlab.student_master;
    """)
    dashboard["student_count"] = cur.fetchone()["count"]

    # Number of Girl Students
    cur.execute("""
    SELECT COUNT(*)
    FROM smartlab.student_master
    WHERE gender = 'GIRL';
    """)
    dashboard["girl_student_count"] = cur.fetchone()["count"]

    # Number of Initiatives
    cur.execute("""
        SELECT COUNT(*)
        FROM smartlab.initiative_master;
    """)
    dashboard["initiative_count"] = cur.fetchone()["count"]

    cur.close()
    conn.close()

    return dashboard


# =====================================================
# CARDS SMARTLABS SECTION
# =====================================================


def get_school_student_strength():

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT
            s.school_name,
            COUNT(*) FILTER (WHERE st.gender = 'BOY') AS boys,
            COUNT(*) FILTER (WHERE st.gender = 'GIRL') AS girls,
            COUNT(*) AS total
        FROM smartlab.student_master st
        JOIN smartlab.school_master s
            ON st.school_id = s.school_id
        GROUP BY s.school_name
        ORDER BY s.school_name;
    """)

    school_strength = cur.fetchall()

    cur.close()
    conn.close()

    return school_strength

def get_class_student_strength():

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT
            class,
            COUNT(*) FILTER (WHERE gender = 'BOY') AS boys,
            COUNT(*) FILTER (WHERE gender = 'GIRL') AS girls,
            COUNT(*) AS total
        FROM smartlab.student_master
        GROUP BY class
        ORDER BY class;
    """)

    class_strength = cur.fetchall()

    cur.close()
    conn.close()

    return class_strength
