from flask import (
    Flask,
    render_template,
    redirect,
    request,
    send_file,
    session,
    url_for
)
from io import BytesIO

from database import (
    get_connection,
    search_students as db_search_students,
    get_student_journey,
    get_centre_directory,
    get_village_mapping,
    get_center_student_strength,
    get_academic_year_id,
    get_all_centres,
    get_classwise_student_strength,
    get_centre_fee_summary,
    get_centre_monthly_attendance_summary,
    get_smartlabs_dashboard_summary,
    get_school_student_strength,
    get_class_student_strength
)

from datetime import datetime

from excel_export import export_report_to_excel

app = Flask(__name__)
app.secret_key = "aems-demo-secret-key"


# =====================================================
# AEMS DEMO USERS
# =====================================================

AEMS_USERS = {

    # =========================================
    # AVF MANAGEMENT
    # =========================================

    "director": {
        "password": "demo123",
        "role": "management",
        "name": "Programme Director",
        "centres": "all"
    },


    # =========================================
    # OPERATIONAL HEAD
    # =========================================

    "operations": {
        "password": "demo123",
        "role": "operational_head",
        "name": "Operational Head",
        "zone": 1
    },


    # =========================================
    # SEGMENT INCHARGE
    # =========================================

    "segment1": {
        "password": "demo123",
        "role": "segment_incharge",
        "name": "Segment Incharge",
        "zone": 1,
        "segment": 1
    },


    # =========================================
    # CLUSTER COORDINATOR
    # =========================================

    "cluster1": {
        "password": "demo123",
        "role": "cluster_incharge",
        "name": "Cluster Coordinator",
        "zone": 1,
        "segment": 1,
        "cluster": 1,
        "centres": [1, 2, 3, 4, 5]
    },

    "swetha": {
    "password": "demo123",
    "role": "cluster_incharge",
    "name": "Swetha",
    "zone": 1,
    "segment": 1,
    "cluster": 1
},


    # =========================================
    # TUTOR
    # =========================================

    "tutor2": {
        "password": "demo123",
        "role": "tutor",
        "name": "Centre 2 Tutor",
        "zone": 1,
        "segment": 1,
        "cluster": 1,
        "centre": 2
    }

}
from functools import wraps


def login_required(view):

    @wraps(view)
    def wrapped_view(*args, **kwargs):

        if "username" not in session:
            return redirect(url_for("login"))

        return view(*args, **kwargs)

    return wrapped_view

@app.route("/mobile/attendance")
@login_required
def mobile_attendance():

    # Mobile attendance is currently for Cluster Coordinators
    if session.get("role") != "cluster_incharge":
        return redirect("/dashboard")

    cc_name = session.get("name")

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT
            tc.center_id,
            tc.center_code,
            tc.center_name,
            COUNT(sm.student_id) AS student_count,
            ats.submission_id,
            ats.submitted_at

        FROM public.cluster_coordinator cc

        JOIN public.cluster_center ccm
            ON ccm.cc_id = cc.cc_id
           AND ccm.active_flag = TRUE

        JOIN public.tuition_center tc
            ON tc.center_id = ccm.center_id

        LEFT JOIN public.student_master sm
            ON sm.center_id = tc.center_id
           AND sm.active_flag = TRUE

        LEFT JOIN public.attendance_submission ats
            ON ats.center_id = tc.center_id
           AND ats.attendance_date = CURRENT_DATE

        WHERE cc.cc_name = %s
          AND cc.active_flag = TRUE
          AND ccm.academic_year_id = (
              SELECT academic_year_id
              FROM public.academic_year_master
              WHERE academic_year = '2026-2027'
          )

        GROUP BY
            tc.center_id,
            tc.center_code,
            tc.center_name,
            ats.submission_id,
            ats.submitted_at

        ORDER BY tc.center_code
    """, (cc_name,))

    centres = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "mobile/attendance.html",
        cc_name=cc_name,
        centres=centres
    )

@app.route("/mobile/attendance/<int:center_id>")
@login_required
def mobile_centre_attendance(center_id):

    # Mobile attendance is currently for Cluster Coordinators
    if session.get("role") != "cluster_incharge":
        return redirect("/dashboard")

    cc_name = session.get("name")

    conn = get_connection()
    cur = conn.cursor()

    # -----------------------------------------
    # Verify that this centre belongs to CC
    # -----------------------------------------

    cur.execute("""
        SELECT
            tc.center_id,
            tc.center_code,
            tc.center_name

        FROM public.cluster_coordinator cc

        JOIN public.cluster_center ccm
            ON ccm.cc_id = cc.cc_id
           AND ccm.active_flag = TRUE

        JOIN public.tuition_center tc
            ON tc.center_id = ccm.center_id

        WHERE cc.cc_name = %s
          AND cc.active_flag = TRUE
          AND ccm.academic_year_id = (
              SELECT academic_year_id
              FROM public.academic_year_master
              WHERE academic_year = '2026-2027'
          )
          AND tc.center_id = %s
    """, (cc_name, center_id))

    centre = cur.fetchone()

    # CC is not authorised for this centre
    if not centre:
        cur.close()
        conn.close()
        return redirect("/mobile/attendance")

    # -----------------------------------------
    # Get active students in this centre
    # -----------------------------------------

    cur.execute("""
        SELECT
            student_id,
            student_code,
            student_name

        FROM public.student_master

        WHERE center_id = %s
          AND active_flag = TRUE

        ORDER BY student_name
    """, (center_id,))

    students = cur.fetchall()

    cur.close()
    conn.close()

    return render_template(
        "mobile/centre_attendance.html",
        cc_name=cc_name,
        centre=centre,
        students=students
    )

@app.route("/mobile/attendance/<int:center_id>/submit", methods=["POST"])
@login_required
def mobile_attendance_submit(center_id):

    # Mobile attendance is currently for Cluster Coordinators
    if session.get("role") != "cluster_incharge":
        return {"success": False, "message": "Unauthorized"}, 403

    cc_name = session.get("name")

    data = request.get_json(silent=True) or {}

    absent_ids = data.get("absent_student_ids", [])

    # Make sure we received a list
    if not isinstance(absent_ids, list):
        return {
            "success": False,
            "message": "Invalid attendance data."
        }, 400

    conn = get_connection()
    cur = conn.cursor()

    try:

        # -----------------------------------------
        # Find the logged-in CC
        # -----------------------------------------

        cur.execute("""
            SELECT cc_id
            FROM public.cluster_coordinator
            WHERE cc_name = %s
              AND active_flag = TRUE
        """, (cc_name,))

        cc = cur.fetchone()

        if not cc:
            return {
                "success": False,
                "message": "Coordinator not found."
            }, 403

        cc_id = cc["cc_id"]


        # -----------------------------------------
        # Verify centre belongs to CC
        # -----------------------------------------

        cur.execute("""
            SELECT tc.center_id
            FROM public.cluster_center ccm

            JOIN public.tuition_center tc
                ON tc.center_id = ccm.center_id

            WHERE ccm.cc_id = %s
              AND ccm.center_id = %s
              AND ccm.active_flag = TRUE
              AND ccm.academic_year_id = (
                  SELECT academic_year_id
                  FROM public.academic_year_master
                  WHERE academic_year = '2026-2027'
              )
        """, (cc_id, center_id))

        centre = cur.fetchone()

        if not centre:
            return {
                "success": False,
                "message": "This centre is not assigned to you."
            }, 403


        # -----------------------------------------
        # Check duplicate submission
        # -----------------------------------------

        cur.execute("""
            SELECT submission_id
            FROM public.attendance_submission
            WHERE center_id = %s
              AND attendance_date = CURRENT_DATE
        """, (center_id,))

        existing_submission = cur.fetchone()

        if existing_submission:
            return {
                "success": False,
                "message": "Attendance has already been submitted for this centre today."
            }, 409


        # -----------------------------------------
        # Get all active students
        # -----------------------------------------

        cur.execute("""
            SELECT student_id
            FROM public.student_master
            WHERE center_id = %s
              AND active_flag = TRUE
        """, (center_id,))

        students = cur.fetchall()

        student_ids = {
            student["student_id"]
            for student in students
        }


        # -----------------------------------------
        # Validate absentee IDs
        # -----------------------------------------

        try:
            absent_ids = {
                int(student_id)
                for student_id in absent_ids
            }
        except (ValueError, TypeError):

            return {
                "success": False,
                "message": "Invalid student selection."
            }, 400


        # Every absentee must belong to this centre
        if not absent_ids.issubset(student_ids):

            return {
                "success": False,
                "message": "One or more selected students do not belong to this centre."
            }, 400


        # -----------------------------------------
        # Create submission record
        # -----------------------------------------

        cur.execute("""
            INSERT INTO public.attendance_submission
                (center_id, attendance_date, cc_id)
            VALUES
                (%s, CURRENT_DATE, %s)
            RETURNING submission_id
        """, (center_id, cc_id))

        submission_id = cur.fetchone()["submission_id"]

        # -----------------------------------------
        # Insert attendance for every student
        # -----------------------------------------

        for student_id in student_ids:

            status = (
                "Absent"
                if student_id in absent_ids
                else "Present"
            )

            cur.execute("""
                INSERT INTO public.student_attendance
                    (
                        student_id,
                        attendance_date,
                        attendance_status,
                        center_id
                    )

                VALUES
                    (%s, CURRENT_DATE, %s, %s)
            """, (
                student_id,
                status,
                center_id
            ))


        # -----------------------------------------
        # Commit everything
        # -----------------------------------------

        conn.commit()

        return {
            "success": True,
            "message": "Attendance submitted successfully.",
            "submission_id": submission_id,
            "absent_count": len(absent_ids),
            "total_students": len(student_ids)
        }


    except Exception as e:

        conn.rollback()

        print("Attendance submission error:", e)

        return {
            "success": False,
            "message": "Attendance could not be submitted."
        }, 500


    finally:

        cur.close()
        conn.close()


@app.route("/mobile/attendance/submitted/<int:submission_id>")
@login_required
def mobile_attendance_submitted(submission_id):

    if session.get("role") != "cluster_incharge":
        return redirect("/dashboard")

    cc_name = session.get("name")

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT
            ats.submission_id,
            ats.attendance_date,
            ats.submitted_at,
            tc.center_id,
            tc.center_code,
            tc.center_name

        FROM public.attendance_submission ats

        JOIN public.tuition_center tc
            ON tc.center_id = ats.center_id

        JOIN public.cluster_coordinator cc
            ON cc.cc_id = ats.cc_id

        WHERE ats.submission_id = %s
          AND cc.cc_name = %s
          AND cc.active_flag = TRUE
    """, (submission_id, cc_name))

    submission = cur.fetchone()

    if not submission:
        cur.close()
        conn.close()
        return redirect("/mobile/attendance")

    cur.execute("""
        SELECT
            COUNT(*) AS total_students,
            COUNT(*) FILTER (
                WHERE attendance_status = 'Present'
            ) AS present,
            COUNT(*) FILTER (
                WHERE attendance_status = 'Absent'
            ) AS absent
        FROM public.student_attendance
        WHERE center_id = %s
          AND attendance_date = %s
    """, (
        submission["center_id"],
        submission["attendance_date"]
    ))

    summary = cur.fetchone()

    cur.close()
    conn.close()

    return render_template(
        "mobile/attendance_submitted.html",
        submission=submission,
        summary=summary
    )


# =====================================================
# LOGIN
# =====================================================
@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        username = request.form.get("username", "").strip()
        password = request.form.get("password", "")

        # =====================================================
        # FIRST: Check database-backed users
        # =====================================================

        conn = get_connection()
        cur = conn.cursor()

        cur.execute("""
            SELECT
                u.user_id,
                u.username,
                u.password_hash,
                u.role,
                u.cc_id,
                u.active_flag,
                c.cc_name
            FROM public.aems_user u
            JOIN public.cluster_coordinator c
                ON c.cc_id = u.cc_id
            WHERE u.username = %s
              AND u.active_flag = TRUE
              AND c.active_flag = TRUE
        """, (username,))

        db_user = cur.fetchone()

        cur.close()
        conn.close()

        # =====================================================
        # DATABASE USER - CURRENTLY CC LOGIN
        # =====================================================

        if db_user:

            # Development phase:
            # password_hash currently contains plain demo password
            if db_user["password_hash"] == password:

                session["username"] = db_user["username"]
                session["role"] = db_user["role"]
                session["name"] = db_user["cc_name"]
                session["cc_id"] = db_user["cc_id"]

                if db_user["role"] == "cluster_incharge":
                    return redirect("/cluster-dashboard/1")

                return redirect("/dashboard")

            return render_template(
                "auth/login.html",
                error="Invalid username or password."
            )

        # =====================================================
        # EXISTING HARD-CODED USERS
        # Keep these temporarily for other roles
        # =====================================================

        user = AEMS_USERS.get(username)

        if user and user["password"] == password:

            session["username"] = username
            session["role"] = user["role"]
            session["name"] = user["name"]

            session["zone"] = user.get("zone")
            session["segment"] = user.get("segment")
            session["cluster"] = user.get("cluster")
            session["centre"] = user.get("centre")
            session["centres"] = user.get("centres")

            if user["role"] == "management":
                return redirect("/dashboard")

            elif user["role"] == "operational_head":
                return redirect("/zone-dashboard")

            elif user["role"] == "segment_incharge":
                return redirect(f"/segment/{user['segment']}")

            elif user["role"] == "cluster_incharge":
                return redirect(f"/cluster-dashboard/{user['cluster']}")

            elif user["role"] == "tutor":
                return redirect("/centre/2")

            return redirect("/dashboard")

        return render_template(
            "auth/login.html",
            error="Invalid username or password."
        )

    return render_template(
        "auth/login.html"
    )


@app.route("/logout")
def logout():

    session.clear()

    return redirect("/login")

@app.route("/dashboard")
@login_required
def dashboard():

    programme_snapshot = {
        "students": 125,
        "villages": 18,
        "schools": 12,
        "higher_education": 84
    }

    return render_template(
        "platform/home.html",
        programme_snapshot=programme_snapshot,
        active_page="home"
    )


@app.route("/cluster-dashboard/<int:cluster_id>")
@login_required
def cluster_dashboard(cluster_id):

    allowed_roles = [
        "management",
        "programme_director",
        "operational_head",
        "segment_incharge",
        "cluster_incharge"
    ]

    if session.get("role") not in allowed_roles:
        return redirect("/dashboard")


    
    cluster = {
        "name": "Cluster 1",
        "centres": 5,
        "students": 168,
        "attendance": "91%",
        "assessment": "74%"
    }

    
    centres = [
    {
        "id": 1,
        "name": "Centre 1",
        "students": 31,
        "attendance": "94%",
        "attendance_value": 94,
        "assessment": "78%",
        "assessment_value": 78,
        "group_a": "80%",
        "group_b": "76%",
        "gurukul": 7
    },

    {
        "id": 2,
        "name": "Centre 2",
        "students": 28,
        "attendance": "91%",
        "attendance_value": 91,
        "assessment": "72%",
        "assessment_value": 72,
        "group_a": "74%",
        "group_b": "70%",
        "gurukul": 6
    },

    {
        "id": 3,
        "name": "Centre 3",
        "students": 29,
        "attendance": "89%",
        "attendance_value": 89,
        "assessment": "74%",
        "assessment_value": 74,
        "group_a": "77%",
        "group_b": "71%",
        "gurukul": 5
    },

    {
        "id": 4,
        "name": "Centre 4",
        "students": 35,
        "attendance": "82%",
        "attendance_value": 82,
        "assessment": "65%",
        "assessment_value": 65,
        "group_a": "69%",
        "group_b": "61%",
        "gurukul": 4
    },

    {
        "id": 5,
        "name": "Centre 5",
        "students": 27,
        "attendance": "76%",
        "attendance_value": 76,
        "assessment": "62%",
        "assessment_value": 62,
        "group_a": "66%",
        "group_b": "58%",
        "gurukul": 3
    }
]

    return render_template(
    "cluster/cluster_dashboard.html",
    cluster=cluster,
    centres=centres,
    active_page="cluster",
    show_mobile_attendance=(session.get("role") == "cluster_incharge")
)


# =====================================================
# HOME
# =====================================================

@app.route("/")
def index():

    return redirect("/login")

#====================================================
# VIDYA VAHINI LANDING
# =====================================================

@app.route("/vidya-vahini")
def vidya_vahini():

    return render_template(
        "vidya_vahini/landing.html",
        active_page="vidya_vahini"
    )


@app.route("/vidya-vikasam")
def vidya_vikasam_dashboard():
   
    return render_template(
        "vidya_vikasam/dashboard.html",
        active_page="vidya_vikasam"
    )

@app.route("/search")
def search_students():

    search_text = request.args.get("search", "").strip()

    students = db_search_students(search_text)

    return render_template(
        "vidya_vahini/search_results.html",
        search_text=search_text,
        students=students
)


@app.route("/centre/<int:centre_id>")
def centre_dashboard(centre_id):

    centre = {
        "name": "Rampur Tuition Centre",
        "code": "VV-012",
        "village": "Rampur",
        "mandal": "Adilabad Rural",
        "district": "Adilabad",
        "tutor": "Smt. Lakshmi",
        "academic_year": "2026-27",
        "classes": "I to V"
    }

    return render_template(
        "vidya_vikasam/centre_dashboard.html",
        centre=centre,
        active_page="vidya_vikasam"
    )


@app.route("/student/<int:student_id>")
def student_summary(student_id):

    print("1. Entered function")

    conn = get_connection()
    print("2. Connected to database")

    cur = conn.cursor()
    print("3. Cursor created")

    cur.execute("""
        SELECT *
        FROM vidya_vahini.vw_student_summary_profile
        WHERE student_id = %s
    """, (student_id,))

    print("4. Query executed")

    student = cur.fetchone()
    print("5. Row fetched")

    # Get Educational Journey
    journey_events = get_student_journey(student_id)

    print("Journey Events:")
    print(journey_events)


   # =====================================================
    # PRESENTATION LAYER
    # =====================================================

    if student:
        # Employment Status is derived from the Student Lifecycle View
        student["employment_status"] = student.get("current_stage")

        fields = [
            "company_name",
            "designation",
            "employment_category",
            "employment_city",
            "employment_state",
            "joining_date",
            "annual_salary",
            "placement_source"
        ]

        for field in fields:
            if student[field] is None:
                student[field] = "—"

        city = student["employment_city"]
        state = student["employment_state"]

        if city == "—" and state == "—":
            student["employment_location"] = "—"
        elif city == "—":
            student["employment_location"] = state
        elif state == "—":
            student["employment_location"] = city
        else:
            student["employment_location"] = f"{city}, {state}"

        print("Employment Status =", student["employment_status"])
    cur.close()
    conn.close()
    print("6. Connection closed")

    return render_template(
        "vidya_vahini/student_lifecycle_dashboard.html",
        student=student,
        journey_events=journey_events,
        active_page="vidya_vahini"
    )

# ======================================================
# VIDYA VIKASAM REPORTS
# ======================================================

@app.route("/reports")
def reporting_workspace():

    academic_year = request.args.get(
        "year",
        "2026-2027"
    )

    return render_template(

        "reports/reporting_workspace.html",

        academic_year=academic_year,

        active_page="reports"

    )

# ======================================================
# VIDYA VIKASAM REPORTING DASHBOARD
# ======================================================

@app.route("/vv-reports")
def vv_reports_dashboard():

    academic_year = request.args.get(
        "year",
        "2026-2027"
    )
    centres = get_all_centres()
    return render_template(

        "reports/vv_reports_dashboard.html",

        academic_year=academic_year,
        centres=centres,
        active_page="reports"

    )

@app.route("/vv-report-category/class-strength")
def class_strength():

    academic_year = request.args.get(
        "year",
        "2024-2025"
    )

    academic_year_id = get_academic_year_id(
        academic_year
    )

    center_id = request.args.get(
        "center_id",
        type=int
    )

    rows = get_classwise_student_strength(
        academic_year_id,
        center_id
    )
    total_boys = sum(row["boys"] for row in rows)

    total_girls = sum(row["girls"] for row in rows)

    total_students = sum(row["total_students"] for row in rows)

    return render_template(

        "reports/class_strength.html",

        programme_name="Vidya Vikasam",

        report_title="Class-wise Student Strength",

        report_category="Centre Reports",

        academic_year=academic_year,

        center_id=center_id,

        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        active_page="reports",
        total_boys=total_boys,

        total_girls=total_girls,

        total_students=total_students,

    )

    
# ======================================================
# CENTRE DIRECTORY REPORT
# ======================================================

@app.route("/centre-directory")
def centre_directory():

    academic_year = request.args.get(
        "year",
        "2026-2027"
    )
    
    rows = get_centre_directory()

    return render_template(
        "reports/report_results.html",

        programme_name="Vidya Vikasam",
        report_title="Centre Directory",
        report_category="Centre Reports",
        academic_year=academic_year,
        export_url="/export/centre-directory",

        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        active_page="reports"
    )


@app.route("/export/centre-directory")
def export_centre_directory():

    academic_year = request.args.get(
        "year",
        "2026-2027"
    )

    rows = get_centre_directory()
          
    
    headers = [

        "Centre ID",

        "Centre Name",

        "Village",

        "Tutor",

        "Status",

        "Start Date"

    ]

    totals = f"Total Centres : {len(rows)}"

    workbook = export_report_to_excel(

        report_title="Centre Directory",

        academic_year=academic_year,

        headers=headers,

        rows=rows,

        totals=totals

    )

    output = BytesIO()

    workbook.save(output)

    output.seek(0)

    filename = f"Centre_Directory_{academic_year}.xlsx"

    return send_file(

        output,

        as_attachment=True,

        download_name=filename,

        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    )

@app.route("/vv-report-category/centre")
def vv_centre_directory():

    academic_year = request.args.get(
        "year",
        "2026-27"
    )
    rows = get_centre_directory()

    return render_template(
        "reports/report_results.html",

        programme_name="Vidya Vikasam",
        report_title="Centre Directory",
        report_category="Centre Reports",

        academic_year=academic_year,

        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        active_page="reports"
    )



@app.route("/vv-report-category/village")
def village_mapping():

    academic_year = request.args.get("year", "2026-27")

    academic_year = request.args.get(
    "year",
    "2026-2027"
    )
    
    rows = get_village_mapping()

    return render_template(

        "reports/report_results.html",

        programme_name="Vidya Vikasam",

        report_title="Village Mapping",

        report_category="Centre Reports",

        academic_year=academic_year,

        export_url="/export/village-mapping",


        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        active_page="reports"

    )


@app.route("/export/village-mapping")
def export_village_mapping():

    academic_year = request.args.get(
        "year",
        "2026-2027"
    )

    rows = get_village_mapping()
          
    
    headers = [

        "Centre ID",

        "Centre Name",

        "Village",

        "Mandal",

        "District",

        "Tutor"

        "Status"

    ]

    totals = f"Total Centres : {len(rows)}"

    workbook = export_report_to_excel(

        report_title="Village Mapping",

        academic_year=academic_year,

        headers=headers,

        rows=rows,

        totals=totals

    )

    output = BytesIO()

    workbook.save(output)

    output.seek(0)

    filename = f"Village_Mapping_{academic_year}.xlsx"

    return send_file(

        output,

        as_attachment=True,

        download_name=filename,

        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    )


@app.route("/vv-report-category/student-strength")
def student_strength():

    academic_year = request.args.get("year", "2026-27")
    academic_year_id = get_academic_year_id(
        academic_year
    )

    rows = get_center_student_strength(
        academic_year_id
    )
    total_boys = sum(row["boys"] for row in rows)
    total_girls = sum(row["girls"] for row in rows)
    total_students = sum(row["total_students"] for row in rows)

    return render_template(

        "reports/student_strength.html",

        programme_name="Vidya Vikasam",

        report_title="Centre-wise Student Strength",

        report_category="Centre Reports",

        academic_year=academic_year,

        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        total_boys=total_boys,

        total_girls=total_girls,

        total_students=total_students,

        active_page="reports"

    )



@app.route("/export/student-strength")
def export_student_strength():

    academic_year = request.args.get(
        "year",
        "2026-2027"
    )

    academic_year_id = get_academic_year_id(
        academic_year
    )

    rows = get_center_student_strength(
        academic_year_id
    )

    headers = [

        "Centre",

        "Village",

        "Tutor",

        "Boys",

        "Girls",

        "Total Students"

    ]

    totals = (

        f"Centres : {len(rows)}    "

        f"Boys : {sum(r['boys'] for r in rows)}    "

        f"Girls : {sum(r['girls'] for r in rows)}    "

        f"Students : {sum(r['total_students'] for r in rows)}"

    )

    workbook = export_report_to_excel(

        report_title="Centre-wise Student Strength",

        academic_year=academic_year,

        headers=headers,

        rows=rows,

        totals=totals

    )

    output = BytesIO()

    workbook.save(output)

    output.seek(0)

    filename = (
        f"Centre_Student_Strength_{academic_year}.xlsx"
    )

    return send_file(

        output,

        as_attachment=True,

        download_name=filename,

        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    )


@app.route("/vv-report-filter/class-strength")
def class_strength_filter():

    
    academic_year = request.args.get(
        "year",
        "2026-2027"
    )

    centres = get_all_centres()

    return render_template(

        "reports/class_strength_filter.html",

        academic_year=academic_year,

        centres=centres,

        active_page="reports"

    )
# ----  This route simply displays the filter page

@app.route("/vv-report-filter/fee-summary")
def fee_summary_filter():

    return render_template(

        "reports/fee_summary_filter.html",

        active_page="reports"

    )

####   -----  FOR ATTENDANCE FILTER ROUTE 

@app.route("/vv-report-filter/attendance-summary")
def attendance_summary_filter():

    return render_template(

        "reports/attendance_summary_filter.html",

        active_page="reports"

    )

# ----  This route is the main query for fees

@app.route("/vv-report-category/fee-summary")
def fee_summary():

    academic_year = request.args.get(
        "year",
        "2025-2026"
    )

    fee_month = request.args.get(
        "fee_month",
        "2025-06"
    )
    display_month = fee_month

    if len(fee_month) == 7:
        fee_month += "-01"

    display_month = datetime.strptime(
        display_month,
        "%Y-%m"
    ).strftime("%B %Y")

    academic_year_id = get_academic_year_id(
        academic_year
    )

    rows = get_centre_fee_summary(
        academic_year_id,
        fee_month
    )

    total_students = sum(
        row["total_students"] for row in rows
    )

    total_paid = sum(
        row["paid_students"] for row in rows
    )

    total_not_paid = sum(
        row["not_paid_students"] for row in rows
    )

    overall_percent = round(
        (total_paid * 100 / total_students),
        1
    ) if total_students else 0

    return render_template(

        "reports/fee_summary.html",

        programme_name="Vidya Vikasam",

        report_title="Centre-wise Fee Collection Summary",

        report_category="Attendance Reports",

        academic_year=academic_year,

        fee_month=display_month,

        fee_month_value=fee_month,

        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        total_students=total_students,

        total_paid=total_paid,

        total_not_paid=total_not_paid,

        overall_percent=overall_percent,

        active_page="reports"

    )


## ------------  FEE REPORT EXPORT ---------

@app.route("/export/fee-summary")
def export_fee_summary():

    academic_year = request.args.get(
        "year",
        "2025-2026"
    )

    fee_month = request.args.get("fee_month")

    academic_year_id = get_academic_year_id(
        academic_year
    )

    rows = get_centre_fee_summary(
        academic_year_id,
        fee_month
    )

    headers = [

        "Centre ID",
        
        "Centre",

        "Total Students",

        "Paid Students",

        "Not Paid Students",

        "Collection %"

    ]

    totals = (

        f"Centres : {len(rows)}    "

        f"Students : {sum(r['total_students'] for r in rows)}    "

        f"Paid : {sum(r['paid_students'] for r in rows)}    "

        f"Not Paid : {sum(r['not_paid_students'] for r in rows)}"

    )

    workbook = export_report_to_excel(

        report_title="Fee Collection Summary",

        academic_year=academic_year,

        headers=headers,

        rows=rows,

        totals=totals

    )

    output = BytesIO()

    workbook.save(output)

    output.seek(0)

    filename = (
        f"Fee_Collection_Summary_{academic_year}_{fee_month}.xlsx"
    )

    return send_file(

        output,

        as_attachment=True,

        download_name=filename,

        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    )

## ------------  ATTENDANCE REPORT ---------

@app.route("/vv-report-category/attendance-summary")
def attendance_summary():

    academic_year = request.args.get(
        "year",
        "2025-2026"
    )

    attendance_month = request.args.get(
    "attendance_month",
        "2025-06"
    )

    display_month = attendance_month

    if len(attendance_month) == 7:
        attendance_month += "-01"

    display_month = datetime.strptime(
        display_month,
        "%Y-%m"
    ).strftime("%B %Y")

    academic_year_id = get_academic_year_id(
        academic_year
    )

    rows = get_centre_monthly_attendance_summary(
        attendance_month
    )

    total_students = sum(
        row["total_students"] for row in rows
    )

    total_present = sum(
        row["present_students"] for row in rows
    )

    total_absent = sum(
        row["absent_students"] for row in rows
    )

    overall_percent = 0
    if total_students > 0:   
        overall_percent = round(
        (total_present * 100 / total_students),
        1
        ) if total_students else 0
    
    return render_template(

        "reports/attendance_summary.html",

        programme_name="Vidya Vikasam",

        report_title="Centre-wise Monthly Attendance Summary",

        report_category="Attendance Reports",

        academic_year=academic_year,

        attendance_month=display_month,

        total_present=total_present,

        total_absent=total_absent,

        generated_on=datetime.now().strftime("%d-%b-%Y %I:%M %p"),

        record_count=len(rows),

        rows=rows,

        total_students=total_students,

        overall_percent=overall_percent,

        active_page="reports"

    )


@app.route("/export/class-strength")
def export_class_strength():

    
    academic_year = request.args.get(
        "year",
        "2026-2027"
    )

    academic_year_id = get_academic_year_id(
        academic_year
    )
    center_id = request.args.get(
        "center_id",
        type=int
    )

        
    rows = get_classwise_student_strength(
        academic_year_id,
        center_id
    )

    print("Rows:", rows)

    headers = [
    "Class",
    "Boys",
    "Girls",
    "Total Students"
]

    totals = (

        f"Classes : {len(rows)}    "

        f"Boys : {sum(r['boys'] for r in rows)}    "

        f"Girls : {sum(r['girls'] for r in rows)}    "

        f"Students : {sum(r['total_students'] for r in rows)}"

    )

    workbook = export_report_to_excel(

        report_title="Class-wise Student Strength",

        academic_year=academic_year,

        headers=headers,

        rows=rows,

        totals=totals

    )

    output = BytesIO()

    workbook.save(output)

    output.seek(0)

    filename = (
        f"Classwise_Student_Strength_{academic_year}.xlsx"
    )

    return send_file(

        output,

        as_attachment=True,

        download_name=filename,

        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    )

### --------------- SMARTLAB ROUTE ---------------

@app.route("/smartlabs")
def smartlabs_dashboard():

    dashboard = get_smartlabs_dashboard_summary()

    school_strength = get_school_student_strength()

    class_strength = get_class_student_strength()

    return render_template(
        "smartlabs/dashboard.html",
        dashboard=dashboard,
        school_strength=school_strength,
        class_strength=class_strength,
        title="SmartLabs Dashboard",
        active_page="smartlabs"
    )

# --------------- TUTOR SPACE ---------------

@app.route("/tutor-space")
@login_required
def tutor_space():

    role = session.get("role")

    # =========================================
    # SEGMENT INCHARGE
    # =========================================

    if role == "segment_incharge":

        segment_id = session.get("segment")

        clusters = [
            {
                "id": 1,
                "name": "Cluster 1",
                "tutors": 5
            },
            {
                "id": 2,
                "name": "Cluster 2",
                "tutors": 5
            },
            {
                "id": 3,
                "name": "Cluster 3",
                "tutors": 5
            },
            {
                "id": 4,
                "name": "Cluster 4",
                "tutors": 5
            }
        ]

        return render_template(
            "tutor_space/segment_tutor_space.html",
            segment_id=segment_id,
            clusters=clusters,
            active_page="tutor_space"
        )


    # =========================================
    # CLUSTER INCHARGE
    # =========================================

    if role == "cluster_incharge":

        cluster_id = session.get("cluster")

        return render_template(
            "tutor_space/dashboard.html",
            cluster_id=cluster_id,
            active_page="tutor_space"
        )


# =========================================
# TUTOR REPORTS
# =========================================

@app.route("/tutor-reports")
@login_required
def tutor_reports():

    centre_id = session.get("centre")

    centre = {
        "name": f"Centre {centre_id}",
        "tutor": "Smt. Lakshmi",
        "academic_year": "2026–27"
    }

    return render_template(
    "reports/tutor/tutor_reports.html",
    centre=centre,
    active_page="reports"
    )


# =========================================
# TUTOR REPORT - STUDENT ATTENDANCE &
# PERFORMANCE
# =========================================

@app.route("/tutor-reports/student-attendance-performance")
@login_required
def tutor_student_attendance_performance():

    centre_id = session.get("centre")

    centre = {
        "name": f"Centre {centre_id}",
        "tutor": "Smt. Lakshmi",
        "academic_year": "2026–27"
    }

    # -----------------------------------------
    # Demo data
    # -----------------------------------------

    classes = {

        "Class I": [
            {
                "name": "Aaradhya",
                "months": [
                    ("92%", "74%"),
                    ("94%", "76%"),
                    ("91%", "78%"),
                    ("95%", "80%"),
                    ("93%", "79%")
                ]
            },
            {
                "name": "Rahul",
                "months": [
                    ("88%", "68%"),
                    ("90%", "70%"),
                    ("87%", "69%"),
                    ("91%", "72%"),
                    ("89%", "71%")
                ]
            },
            {
                "name": "Sowmya",
                "months": [
                    ("96%", "82%"),
                    ("95%", "84%"),
                    ("97%", "85%"),
                    ("96%", "87%"),
                    ("94%", "86%")
                ]
            }
        ],

        "Class II": [
            {
                "name": "Anjali",
                "months": [
                    ("91%", "75%"),
                    ("94%", "78%"),
                    ("90%", "77%"),
                    ("93%", "81%"),
                    ("95%", "83%")
                ]
            },
            {
                "name": "Kiran",
                "months": [
                    ("86%", "67%"),
                    ("89%", "70%"),
                    ("88%", "72%"),
                    ("91%", "74%"),
                    ("90%", "73%")
                ]
            },
            {
                "name": "Meena",
                "months": [
                    ("95%", "84%"),
                    ("96%", "86%"),
                    ("94%", "85%"),
                    ("97%", "88%"),
                    ("96%", "89%")
                ]
            }
        ],

        "Class III": [
            {
                "name": "Anjali",
                "months": [
                    ("92%", "76%"),
                    ("95%", "81%"),
                    ("90%", "78%"),
                    ("94%", "84%"),
                    ("91%", "80%")
                ]
            },
            {
                "name": "Ravi",
                "months": [
                    ("88%", "69%"),
                    ("91%", "73%"),
                    ("86%", "71%"),
                    ("90%", "75%"),
                    ("89%", "74%")
                ]
            },
            {
                "name": "Sita",
                "months": [
                    ("96%", "84%"),
                    ("94%", "86%"),
                    ("95%", "88%"),
                    ("97%", "90%"),
                    ("96%", "89%")
                ]
            },
            {
                "name": "Manoj",
                "months": [
                    ("84%", "65%"),
                    ("87%", "68%"),
                    ("89%", "70%"),
                    ("88%", "72%"),
                    ("90%", "74%")
                ]
            }
        ]

    }

    selected_class = request.args.get(
        "class_name",
        "Class III"
    )

    students = classes.get(
        selected_class,
        classes["Class III"]
    )

    months = [
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug"
    ]

    return render_template(
        "reports/tutor/student_attendance_performance.html",
        centre=centre,
        classes=classes.keys(),
        selected_class=selected_class,
        students=students,
        months=months,
        active_page="reports"
    )

# =========================================
# TUTOR REPORT - CLASS PERFORMANCE
# COMPARISON
# =========================================

@app.route("/tutor-reports/class-performance-comparison")
@login_required
def tutor_class_performance_comparison():

    centre_id = session.get("centre")

    centre = {
        "name": f"Centre {centre_id}",
        "tutor": "Smt. Lakshmi",
        "academic_year": "2026–27"
    }

    # -----------------------------------------
    # Demo data
    # -----------------------------------------

    classes = {

        "Class I": [
            {
                "name": "Aaradhya",
                "months": [
                    (92, 74), (94, 76), (91, 78),
                    (95, 80), (93, 79)
                ]
            },
            {
                "name": "Rahul",
                "months": [
                    (88, 68), (90, 70), (87, 69),
                    (91, 72), (89, 71)
                ]
            },
            {
                "name": "Sowmya",
                "months": [
                    (96, 82), (95, 84), (97, 85),
                    (96, 87), (94, 86)
                ]
            }
        ],

        "Class II": [
            {
                "name": "Anjali",
                "months": [
                    (91, 75), (94, 78), (90, 77),
                    (93, 81), (95, 83)
                ]
            },
            {
                "name": "Kiran",
                "months": [
                    (86, 67), (89, 70), (88, 72),
                    (91, 74), (90, 73)
                ]
            },
            {
                "name": "Meena",
                "months": [
                    (95, 84), (96, 86), (94, 85),
                    (97, 88), (96, 89)
                ]
            }
        ],

        "Class III": [
            {
                "name": "Anjali",
                "months": [
                    (92, 76), (95, 81), (90, 78),
                    (94, 84), (91, 80)
                ]
            },
            {
                "name": "Ravi",
                "months": [
                    (88, 69), (91, 73), (86, 71),
                    (90, 75), (89, 74)
                ]
            },
            {
                "name": "Sita",
                "months": [
                    (96, 84), (94, 86), (95, 88),
                    (97, 90), (96, 89)
                ]
            },
            {
                "name": "Manoj",
                "months": [
                    (84, 65), (87, 68), (89, 70),
                    (88, 72), (90, 74)
                ]
            }
        ]

    }

    months = [
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug"
    ]

    # -----------------------------------------
    # Calculate class averages
    # -----------------------------------------

    class_summary = []

    all_attendance = []
    all_performance = []

    for class_name, students in classes.items():

        attendance_values = []
        performance_values = []

        for student in students:

            for attendance, performance in student["months"]:

                attendance_values.append(attendance)
                performance_values.append(performance)

                all_attendance.append(attendance)
                all_performance.append(performance)

        class_summary.append({

            "name": class_name,

            "students": len(students),

            "attendance": round(
                sum(attendance_values) /
                len(attendance_values)
            ),

            "performance": round(
                sum(performance_values) /
                len(performance_values)
            )

        })

            # -----------------------------------------
    # Centre averages
    # -----------------------------------------

    centre_average = {

        "students": sum(
            item["students"]
            for item in class_summary
        ),

        "attendance": round(
            sum(all_attendance) /
            len(all_attendance)
        ),

        "performance": round(
            sum(all_performance) /
            len(all_performance)
        )

    }

    # -----------------------------------------
    # Display report
    # -----------------------------------------

    return render_template(
        "reports/tutor/class_performance_comparison.html",
        centre=centre,
        class_summary=class_summary,
        centre_average=centre_average,
        months=months,
        active_page="reports"
    )





# =========================================
# TUTOR REPORT - CLASS PERFORMANCE
# EXCEL EXPORT
# =========================================

@app.route("/tutor-reports/export/class-performance-comparison")
@login_required
def export_tutor_class_performance_comparison():

    centre_id = session.get("centre")

    # -----------------------------------------
    # Demo data
    # -----------------------------------------

    class_summary = [
        {
            "name": "Class I",
            "students": 3,
            "attendance": 93,
            "performance": 77
        },
        {
            "name": "Class II",
            "students": 3,
            "attendance": 92,
            "performance": 79
        },
        {
            "name": "Class III",
            "students": 4,
            "attendance": 91,
            "performance": 77
        }
    ]

    centre_average = {
        "students": 10,
        "attendance": 92,
        "performance": 78
    }

    headers = [
        "Class",
        "Students",
        "Average Attendance",
        "Average Performance"
    ]

    rows = []

    for item in class_summary:

        rows.append({
            "Class": item["name"],
            "Students": item["students"],
            "Average Attendance": f'{item["attendance"]}%',
            "Average Performance": f'{item["performance"]}%'
        })

    totals = (
        f"Students: {centre_average['students']} | "
        f"Average Attendance: {centre_average['attendance']}% | "
        f"Average Performance: {centre_average['performance']}%"
    )

    workbook = export_report_to_excel(
    report_title="Class Performance Comparison",
    academic_year="2026–27",
    headers=headers,
    rows=rows,
    totals=totals,
    organisation_name="AKSHAYA VIDYA FOUNDATION",
    system_name="Akshaya Vidya Education Management System"
    )

    filename = (
        f"Centre_{centre_id}_"
        f"Class_Performance_Comparison.xlsx"
    )

    workbook.save(filename)

    return send_file(
        filename,
        as_attachment=True,
        download_name=filename,
        mimetype=(
            "application/vnd.openxmlformats-officedocument."
            "spreadsheetml.sheet"
        )
    )


    # -----------------------------------------
    # Centre averages
    # -----------------------------------------

    centre_average = {

        "students": sum(
            item["students"]
            for item in class_summary
        ),

        "attendance": round(
            sum(all_attendance) /
            len(all_attendance)
        ),

        "performance": round(
            sum(all_performance) /
            len(all_performance)
        )

    }

    return render_template(
        "reports/tutor/class_performance_comparison.html",
        centre=centre,
        class_summary=class_summary,
        centre_average=centre_average,
        months=months,
        active_page="reports"
    )

    # =========================================
    # CLUSTER COORDINATOR
    # =========================================

    if role == "cluster_incharge":

        cluster_id = session.get("cluster")

        return render_template(
            "tutor_space/dashboard.html",
            cluster_id=cluster_id,
            active_page="tutor_space"
        )


    # =========================================
    # OTHER ROLES — NOT YET AVAILABLE
    # =========================================

    return redirect("/dashboard")
    # =========================================
    # OTHER ROLES
    # =========================================

    return redirect("/dashboard")

@app.route("/segment/<int:segment_id>")
@login_required
def segment_dashboard(segment_id):

    segment = {
        "name": "Segment 1",
        "incharge": "Smt. Anitha",
        "clusters": 4,
        "centres": 20,
        "students": 600,
        "attendance": "87%",
        "assessment": "71%"
    }

    clusters = [
        {
            "id": 1,
            "name": "Cluster 1",
            "centres": 5,
            "students": 168,
            "attendance": "91%",
            "attendance_value": 91,
            "assessment": "74%",
            "assessment_value": 74
        },
        {
            "id": 2,
            "name": "Cluster 2",
            "centres": 5,
            "students": 152,
            "attendance": "88%",
            "attendance_value": 88,
            "assessment": "72%",
            "assessment_value": 72
        },
        {
            "id": 3,
            "name": "Cluster 3",
            "centres": 5,
            "students": 141,
            "attendance": "84%",
            "attendance_value": 84,
            "assessment": "69%",
            "assessment_value": 69
        },
        {
            "id": 4,
            "name": "Cluster 4",
            "centres": 5,
            "students": 139,
            "attendance": "81%",
            "attendance_value": 81,
            "assessment": "65%",
            "assessment_value": 65
        }
    ]

    return render_template(
        "segment/segment_dashboard.html",
        segment=segment,
        clusters=clusters,
        active_page="vidya_vikasam"
    )

@app.route("/zone-dashboard")
def zone_dashboard():

    zone = {
        "name": "Zone 1",
        "head": "Smt. Anitha",
        "segments": 5,
        "clusters": 20,
        "centres": 100,
        "students": 3000,
        "attendance": "85%",
        "assessment": "69%"
    }

    segments = [
        {
            "id": 1,
            "name": "Segment 1",
            "clusters": 4,
            "centres": 20,
            "students": 620,
            "attendance": "90%",
            "attendance_value": 90,
            "assessment": "75%",
            "assessment_value": 75
        },
        {
            "id": 2,
            "name": "Segment 2",
            "clusters": 4,
            "centres": 20,
            "students": 605,
            "attendance": "88%",
            "attendance_value": 88,
            "assessment": "72%",
            "assessment_value": 72
        },
        {
            "id": 3,
            "name": "Segment 3",
            "clusters": 4,
            "centres": 20,
            "students": 590,
            "attendance": "86%",
            "attendance_value": 86,
            "assessment": "70%",
            "assessment_value": 70
        },
        {
            "id": 4,
            "name": "Segment 4",
            "clusters": 4,
            "centres": 20,
            "students": 610,
            "attendance": "82%",
            "attendance_value": 82,
            "assessment": "66%",
            "assessment_value": 66
        },
        {
            "id": 5,
            "name": "Segment 5",
            "clusters": 4,
            "centres": 20,
            "students": 575,
            "attendance": "79%",
            "attendance_value": 79,
            "assessment": "63%",
            "assessment_value": 63
        }
    ]

    return render_template(
        "zone/zone_dashboard.html",
        zone=zone,
        segments=segments,
        active_page="tutor_space"
    )


# --------------- ZONE TUTOR SPACE ---------------

@app.route("/zone-tutor-space")
@login_required
def zone_tutor_space():

    zone = {
        "name": "Zone 1",
        "head": "Smt. Anitha",
        "tutors": 100,
        "higher_education": 82,
        "education_support": 81,
        "pending_support": 11
    }

    segments = [
        {
            "id": 1,
            "name": "Segment 1",
            "tutors": 20,
            "higher_education": 18,
            "education_support": 19,
            "pending_support": 1
        },
        {
            "id": 2,
            "name": "Segment 2",
            "tutors": 20,
            "higher_education": 17,
            "education_support": 18,
            "pending_support": 2
        },
        {
            "id": 3,
            "name": "Segment 3",
            "tutors": 20,
            "higher_education": 16,
            "education_support": 15,
            "pending_support": 3
        },
        {
            "id": 4,
            "name": "Segment 4",
            "tutors": 20,
            "higher_education": 15,
            "education_support": 14,
            "pending_support": 2
        },
        {
            "id": 5,
            "name": "Segment 5",
            "tutors": 20,
            "higher_education": 16,
            "education_support": 15,
            "pending_support": 3
        }
    ]

    qualification = [
        {"name": "Class 10", "tutors": 18},
        {"name": "Intermediate", "tutors": 27},
        {"name": "Degree", "tutors": 42},
        {"name": "Post-Graduation", "tutors": 8},
        {"name": "Other", "tutors": 5}
    ]

    education_status = [
        {"name": "Intermediate", "tutors": 25},
        {"name": "Degree", "tutors": 52},
        {"name": "Post-Graduation", "tutors": 5},
        {"name": "Completed", "tutors": 18}
    ]

    return render_template(
        "zone/zone_tutor_space.html",
        zone=zone,
        segments=segments,
        qualification=qualification,
        education_status=education_status,
        active_page="tutor_space"
    )


@app.route("/students/<int:centre_id>")
@login_required
def centre_students(centre_id):

    students_by_class = {

        "I": [
            {"name": "Anjali", "age": 6, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Rahul", "age": 6, "gender": "Male", "village": "Rampur"},
            {"name": "Sravani", "age": 6, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Kiran", "age": 7, "gender": "Male", "village": "Rampur"},
            {"name": "Divya", "age": 6, "gender": "Female", "village": "Rasoolpura"}
        ],

        "II": [
            {"name": "Kavya", "age": 7, "gender": "Female", "village": "Rampur"},
            {"name": "Rohit", "age": 7, "gender": "Male", "village": "Rasoolpura"},
            {"name": "Pooja", "age": 7, "gender": "Female", "village": "Rampur"},
            {"name": "Arjun", "age": 8, "gender": "Male", "village": "Rasoolpura"},
            {"name": "Lakshmi", "age": 7, "gender": "Female", "village": "Rampur"},
            {"name": "Manoj", "age": 8, "gender": "Male", "village": "Rasoolpura"}
        ],

        "III": [
            {"name": "Swathi", "age": 8, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Vijay", "age": 8, "gender": "Male", "village": "Rampur"},
            {"name": "Keerthi", "age": 9, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Naveen", "age": 8, "gender": "Male", "village": "Rampur"},
            {"name": "Harika", "age": 9, "gender": "Female", "village": "Rasoolpura"}
        ],

        "IV": [
            {"name": "Anusha", "age": 9, "gender": "Female", "village": "Rampur"},
            {"name": "Ramesh", "age": 9, "gender": "Male", "village": "Rasoolpura"},
            {"name": "Bhavya", "age": 10, "gender": "Female", "village": "Rampur"},
            {"name": "Suresh", "age": 9, "gender": "Male", "village": "Rasoolpura"},
            {"name": "Meena", "age": 10, "gender": "Female", "village": "Rampur"},
            {"name": "Ajay", "age": 10, "gender": "Male", "village": "Rasoolpura"}
        ],

        "V": [
            {"name": "Sandhya", "age": 10, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Praveen", "age": 10, "gender": "Male", "village": "Rampur"},
            {"name": "Deepa", "age": 11, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Mahesh", "age": 11, "gender": "Male", "village": "Rampur"},
            {"name": "Jyothi", "age": 10, "gender": "Female", "village": "Rasoolpura"}
        ],

        "VI": [
            {"name": "Sravani", "age": 11, "gender": "Female", "village": "Rampur"},
            {"name": "Anjali", "age": 11, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Karthik", "age": 11, "gender": "Male", "village": "Rampur"},
            {"name": "Divya", "age": 12, "gender": "Female", "village": "Rasoolpura"},
            {"name": "Ravi", "age": 12, "gender": "Male", "village": "Rampur"},
            {"name": "Pavani", "age": 11, "gender": "Female", "village": "Rasoolpura"}
        ]
    }

    class_counts = {
        "I": 5,
        "II": 6,
        "III": 5,
        "IV": 6,
        "V": 5,
        "VI": 6
    }

    return render_template(
        "students/centre_students.html",
        centre_id=centre_id,
        students_by_class=students_by_class,
        class_counts=class_counts,
        active_page="students"
    )



@app.route("/attendance/<int:centre_id>")
@login_required
def centre_attendance(centre_id):

    attendance_by_class = {

        "I": [
            {"name": "Anjali", "present": 23, "absent": 2},
            {"name": "Rahul", "present": 21, "absent": 4},
            {"name": "Sravani", "present": 24, "absent": 1},
            {"name": "Kiran", "present": 22, "absent": 3},
            {"name": "Divya", "present": 23, "absent": 2}
        ],

        "II": [
            {"name": "Kavya", "present": 22, "absent": 3},
            {"name": "Rohit", "present": 21, "absent": 4},
            {"name": "Pooja", "present": 24, "absent": 1},
            {"name": "Arjun", "present": 20, "absent": 5},
            {"name": "Lakshmi", "present": 23, "absent": 2},
            {"name": "Manoj", "present": 22, "absent": 3}
        ],

        "III": [
            {"name": "Swathi", "present": 23, "absent": 2},
            {"name": "Vijay", "present": 21, "absent": 4},
            {"name": "Keerthi", "present": 24, "absent": 1},
            {"name": "Naveen", "present": 22, "absent": 3},
            {"name": "Harika", "present": 23, "absent": 2}
        ],

        "IV": [
            {"name": "Anusha", "present": 23, "absent": 2},
            {"name": "Ramesh", "present": 21, "absent": 4},
            {"name": "Bhavya", "present": 24, "absent": 1},
            {"name": "Suresh", "present": 20, "absent": 5},
            {"name": "Meena", "present": 22, "absent": 3},
            {"name": "Ajay", "present": 23, "absent": 2}
        ],

        "V": [
            {"name": "Sandhya", "present": 22, "absent": 3},
            {"name": "Praveen", "present": 21, "absent": 4},
            {"name": "Deepa", "present": 24, "absent": 1},
            {"name": "Mahesh", "present": 20, "absent": 5},
            {"name": "Jyothi", "present": 23, "absent": 2}
        ],

        "VI": [
            {"name": "Sravani", "present": 23, "absent": 2},
            {"name": "Anjali", "present": 22, "absent": 3},
            {"name": "Karthik", "present": 21, "absent": 4},
            {"name": "Divya", "present": 24, "absent": 1},
            {"name": "Ravi", "present": 22, "absent": 3},
            {"name": "Pavani", "present": 23, "absent": 2}
        ]
    }

    class_counts = {
        "I": 5,
        "II": 6,
        "III": 5,
        "IV": 6,
        "V": 5,
        "VI": 6
    }

    return render_template(
        "attendance/centre_attendance.html",
        centre_id=centre_id,
        attendance_by_class=attendance_by_class,
        class_counts=class_counts,
        active_page="attendance"
    )


@app.route("/performance/<int:centre_id>")
@login_required
def centre_performance(centre_id):

    performance_by_class = {

        "I": [
            {"name": "Anjali", "english": 78, "mathematics": 82, "science": 80},
            {"name": "Rahul", "english": 72, "mathematics": 76, "science": 74},
            {"name": "Sravani", "english": 84, "mathematics": 86, "science": 82},
            {"name": "Kiran", "english": 69, "mathematics": 74, "science": 71},
            {"name": "Divya", "english": 81, "mathematics": 79, "science": 83}
        ],

        "II": [
            {"name": "Kavya", "english": 82, "mathematics": 85, "science": 80},
            {"name": "Rohit", "english": 74, "mathematics": 71, "science": 76},
            {"name": "Pooja", "english": 88, "mathematics": 91, "science": 86},
            {"name": "Arjun", "english": 68, "mathematics": 72, "science": 70},
            {"name": "Lakshmi", "english": 80, "mathematics": 84, "science": 82},
            {"name": "Manoj", "english": 76, "mathematics": 78, "science": 75}
        ],

        "III": [
            {"name": "Swathi", "english": 84, "mathematics": 86, "science": 82},
            {"name": "Vijay", "english": 72, "mathematics": 75, "science": 74},
            {"name": "Keerthi", "english": 89, "mathematics": 92, "science": 88},
            {"name": "Naveen", "english": 76, "mathematics": 79, "science": 77},
            {"name": "Harika", "english": 86, "mathematics": 88, "science": 85}
        ],

        "IV": [
            {"name": "Anusha", "english": 78, "mathematics": 82, "science": 80},
            {"name": "Ramesh", "english": 72, "mathematics": 76, "science": 74},
            {"name": "Bhavya", "english": 88, "mathematics": 91, "science": 86},
            {"name": "Suresh", "english": 68, "mathematics": 72, "science": 70},
            {"name": "Meena", "english": 84, "mathematics": 86, "science": 82},
            {"name": "Ajay", "english": 76, "mathematics": 79, "science": 75}
        ],

        "V": [
            {"name": "Sandhya", "english": 82, "mathematics": 85, "science": 83},
            {"name": "Praveen", "english": 74, "mathematics": 77, "science": 72},
            {"name": "Deepa", "english": 90, "mathematics": 92, "science": 89},
            {"name": "Mahesh", "english": 71, "mathematics": 74, "science": 70},
            {"name": "Jyothi", "english": 85, "mathematics": 88, "science": 84}
        ],

        "VI": [
            {"name": "Sravani", "english": 86, "mathematics": 89, "science": 84},
            {"name": "Anjali", "english": 82, "mathematics": 85, "science": 81},
            {"name": "Karthik", "english": 74, "mathematics": 78, "science": 76},
            {"name": "Divya", "english": 91, "mathematics": 94, "science": 90},
            {"name": "Ravi", "english": 77, "mathematics": 80, "science": 75},
            {"name": "Pavani", "english": 88, "mathematics": 91, "science": 87}
        ]
    }

    class_counts = {
        "I": 5,
        "II": 6,
        "III": 5,
        "IV": 6,
        "V": 5,
        "VI": 6
    }

    return render_template(
        "performance/centre_performance.html",
        centre_id=centre_id,
        performance_by_class=performance_by_class,
        class_counts=class_counts,
        active_page="performance"
    )






if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )


