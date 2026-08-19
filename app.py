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

# =====================================================
# LOGIN
# =====================================================

@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        username = request.form.get("username", "").strip()
        password = request.form.get("password", "")

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
        active_page="cluster"
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
    # INDIVIDUAL TUTOR VIEW
    # =========================================

    if role == "tutor":

        tutor_profile = {
            "name": session.get("name"),
            "centre": session.get("centre"),
            "role": "Tutor",
            "classes": "I to VI"
        }

        return render_template(
            "tutor_space/my_tutor_space.html",
            tutor_profile=tutor_profile,
            active_page="tutor_space"
        )


    # =========================================
    # MANAGEMENT / SUPERVISORY VIEW
    # =========================================

    tutor_summary = {

        # Current workforce
        "active_tutors": 127,

        # Tutor outcomes - current + former tutors
        "higher_education": 94,
        "graduated": 61,
        "former_employed": 28,

        # Education profile
        "intermediate": 32,
        "graduation": 61,
        "post_graduation": 18,
        "professional": 16,

        # Academic performance
        "avg_performance": "78%",
        "above_80": 38,
        "between_70_79": 43,
        "between_60_69": 28,
        "below_60": 12,

        # AVF education support
        "supported_tutors": 94,
        "institutions": 31,
        "education_support": "₹18.6L"
    }

    tutor_centres = [

        {
            "name": "Rasoolpura Learning Centre",
            "tutors": 2,
            "experience": "2.8 yrs",
            "students": 28
        },

        {
            "name": "Rampur Learning Centre",
            "tutors": 1,
            "experience": "3.2 yrs",
            "students": 31
        },

        {
            "name": "Learning Centre 03",
            "tutors": 2,
            "experience": "1.9 yrs",
            "students": 35
        },

        {
            "name": "Learning Centre 04",
            "tutors": 1,
            "experience": "4.1 yrs",
            "students": 29
        }
    ]

    return render_template(
        "tutor_space/dashboard.html",
        tutor_summary=tutor_summary,
        tutor_centres=tutor_centres,
        active_page="tutor_space"
    )

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
        active_page="vidya_vikasam"
    )



if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )


