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
)

from datetime import datetime, timedelta
from psycopg2.extras import RealDictCursor

from excel_export import export_report_to_excel

from werkzeug.security import check_password_hash, generate_password_hash


app = Flask(__name__)
app.secret_key = "aems-demo-secret-key"


from functools import wraps


def login_required(view):

    @wraps(view)
    def wrapped_view(*args, **kwargs):

        if "username" not in session:
            return redirect(url_for("login"))

        return view(*args, **kwargs)

    return wrapped_view



def permission_required(permission_code):

    def decorator(view):

        @wraps(view)
        def wrapped_view(*args, **kwargs):

            # User must be logged in
            if "user_id" not in session:
                return redirect("/login")

            conn = get_connection()

            try:
                with conn.cursor(cursor_factory=RealDictCursor) as cur:

                    cur.execute("""
                        SELECT 1
                        FROM user_role ur
                        JOIN role_permission rp
                            ON rp.role_id = ur.role_id
                        JOIN permission_master pm
                            ON pm.permission_id = rp.permission_id
                        WHERE ur.user_id = %s
                          AND ur.active_flag = TRUE
                          AND ur.assigned_from <= CURRENT_DATE
                          AND (
                                ur.assigned_to IS NULL
                                OR ur.assigned_to >= CURRENT_DATE
                              )
                          AND pm.permission_code = %s
                        LIMIT 1
                    """, (
                        session["user_id"],
                        permission_code
                    ))

                    allowed = cur.fetchone()

                   

                    print("DEBUG permission:", permission_code)
                    print("DEBUG user_id:", session.get("user_id"))
                    print("DEBUG allowed:", allowed)

                  
                    if not allowed:
                        return redirect("/dashboard")

            finally:
                conn.close()

            return view(*args, **kwargs)

        return wrapped_view

    return decorator
# ============================================================
# CC ATTENDANCE CAPTURE
# ============================================================
@app.route("/mobile/attendance")
@login_required
def mobile_attendance():

    role = session.get("role")
    user_id = session.get("user_id")

    
    # Attendance capture is available to:
    #   1. Cluster Coordinators
    #   2. Segment Incharges
    if role not in ["cluster_incharge", "segment_incharge"]:
        return redirect("/dashboard")

    if not user_id:
        return redirect("/dashboard")

    conn = get_connection()
    cur = conn.cursor()

    try:

        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT academic_year_id
            FROM public.academic_year_master
            WHERE academic_year = '2026-2027'
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return redirect("/dashboard")

        academic_year_id = academic_year["academic_year_id"]


        # ====================================================
        # CLUSTER COORDINATOR
        # ====================================================
        if role == "cluster_incharge":

            # ------------------------------------------------
            # Identify logged-in CC
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    cc.cc_id,
                    cc.cc_name
                FROM public.user_person_assignment upa
                JOIN public.cluster_coordinator cc
                    ON cc.cc_id = upa.cc_id
                WHERE upa.user_id = %s
                  AND upa.active_flag = TRUE
                  AND cc.active_flag = TRUE
                LIMIT 1
            """, (user_id,))

            cc = cur.fetchone()
            

            if not cc:
                return redirect("/dashboard")

            cc_id = cc["cc_id"]
            display_name = cc["cc_name"]

            # Back destination for Cluster Coordinator
            cur.execute("""
                SELECT cluster_id
                FROM public.cluster_coordinator_assignment
                WHERE cc_id = %s
                AND academic_year_id = %s
                AND active_flag = TRUE
                ORDER BY assigned_from DESC NULLS LAST
                LIMIT 1
            """, (cc_id, academic_year_id))

            cluster_assignment = cur.fetchone()

            if not cluster_assignment:
                return redirect("/dashboard")

            back_url = f"/cluster-dashboard/{cluster_assignment['cluster_id']}"

            # ------------------------------------------------
            # AVLCs belonging to CC's active cluster
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name,

                    COUNT(DISTINCT sm.student_id) AS student_count,

                    MAX(ats.submission_id) AS submission_id

                FROM public.cluster_coordinator_assignment cca

                JOIN public.cluster_center ccm
                    ON ccm.cluster_id = cca.cluster_id
                   AND ccm.academic_year_id = cca.academic_year_id
                   AND ccm.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = ccm.center_id
                   

                LEFT JOIN public.student_center_assignment sca
                    ON sca.center_id = tc.center_id
                   AND sca.academic_year_id = %s
                   AND sca.active_flag = TRUE

                LEFT JOIN public.student_master sm
                    ON sm.student_id = sca.student_id
                   AND sm.active_flag = TRUE

                LEFT JOIN public.attendance_submission ats
                    ON ats.center_id = tc.center_id
                   AND ats.attendance_date = CURRENT_DATE

                WHERE cca.cc_id = %s
                  AND cca.academic_year_id = %s
                  AND cca.active_flag = TRUE

                GROUP BY
                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                ORDER BY
                    tc.center_code
            """, (
                academic_year_id,
                cc_id,
                academic_year_id
            ))

            centres = cur.fetchall()


        # ====================================================
        # SEGMENT INCHARGE
        # ====================================================
        else:

            segment_id = session.get("segment")

            if not segment_id:
                return redirect("/dashboard")

            back_url = f"/segment/{segment_id}"

            # ------------------------------------------------
            # Get SI display name
            # ------------------------------------------------
            cur.execute("""
                SELECT full_name
                FROM public.aems_user
                WHERE user_id = %s
                  AND active_flag = TRUE
            """, (user_id,))

            si = cur.fetchone()

            if not si:
                return redirect("/dashboard")

            display_name = si["full_name"]

            # ------------------------------------------------
            # All AVLCs in the SI's segment.
            #
            # IMPORTANT:
            # This does NOT depend on whether the cluster
            # currently has a CC.
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name,

                    COUNT(DISTINCT sm.student_id) AS student_count,

                    MAX(ats.submission_id) AS submission_id

                FROM public.cluster_master cm

                JOIN public.cluster_center ccm
                    ON ccm.cluster_id = cm.cluster_id
                   AND ccm.academic_year_id = %s
                   AND ccm.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = ccm.center_id
                   

                LEFT JOIN public.student_center_assignment sca
                    ON sca.center_id = tc.center_id
                   AND sca.academic_year_id = %s
                   AND sca.active_flag = TRUE

                LEFT JOIN public.student_master sm
                    ON sm.student_id = sca.student_id
                   AND sm.active_flag = TRUE

                LEFT JOIN public.attendance_submission ats
                    ON ats.center_id = tc.center_id
                   AND ats.attendance_date = CURRENT_DATE

                WHERE cm.segment_id = %s
                  AND cm.active_flag = TRUE

                GROUP BY
                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                ORDER BY
                    tc.center_code
            """, (
                academic_year_id,
                academic_year_id,
                segment_id
            ))

            centres = cur.fetchall()


        # ----------------------------------------------------
        # Reuse existing mobile attendance template
        #
        # Keep cc_name because the existing template already
        # expects this variable. For an SI it simply contains
        # the SI's name.
        # ----------------------------------------------------
        return render_template(
            "mobile/attendance.html",
            cc_name=display_name,
            centres=centres,
            back_url=back_url
        )

    except Exception as e:

        print("Mobile attendance error:", e)

        return redirect("/dashboard")

    finally:

        cur.close()
        conn.close()

# ============================================================
# CC ATTENDANCE CAPTURE - CENTRE
# ============================================================

# ============================================================
# ATTENDANCE CAPTURE - CENTRE
# CC + SEGMENT INCHARGE
# ============================================================

@app.route("/mobile/attendance/<int:center_id>")
@login_required
def mobile_centre_attendance(center_id):

    role = session.get("role")
    user_id = session.get("user_id")

    # Attendance capture is available to:
    #   1. Cluster Coordinators
    #   2. Segment Incharges
    if role not in ["cluster_incharge", "segment_incharge"]:
        return redirect("/dashboard")

    if not user_id:
        return redirect("/dashboard")

    conn = get_connection()
    cur = conn.cursor()

    try:

        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT academic_year_id
            FROM public.academic_year_master
            WHERE academic_year = '2026-2027'
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return redirect("/dashboard")

        academic_year_id = academic_year["academic_year_id"]


        # ====================================================
        # CLUSTER COORDINATOR
        # ====================================================
        if role == "cluster_incharge":

            # ------------------------------------------------
            # Identify logged-in CC
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    cc.cc_id,
                    cc.cc_name
                FROM public.user_person_assignment upa
                JOIN public.cluster_coordinator cc
                    ON cc.cc_id = upa.cc_id
                WHERE upa.user_id = %s
                  AND upa.active_flag = TRUE
                  AND cc.active_flag = TRUE
                LIMIT 1
            """, (user_id,))

            cc = cur.fetchone()

            if not cc:
                return redirect("/dashboard")

            cc_id = cc["cc_id"]
            display_name = cc["cc_name"]

            # ------------------------------------------------
            # Verify that the requested centre belongs to
            # one of the CC's active cluster assignments.
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name,
                    cc.cc_id,
                    cc.cc_name

                FROM public.cluster_coordinator_assignment cca

                JOIN public.cluster_coordinator cc
                    ON cc.cc_id = cca.cc_id

                JOIN public.cluster_center ccm
                    ON ccm.cluster_id = cca.cluster_id
                   AND ccm.academic_year_id = cca.academic_year_id
                   AND ccm.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = ccm.center_id

                WHERE cca.cc_id = %s
                  AND cca.academic_year_id = %s
                  AND cca.active_flag = TRUE
                  AND cc.active_flag = TRUE
                  AND tc.center_id = %s
            """, (
                cc_id,
                academic_year_id,
                center_id
            ))

            centre = cur.fetchone()


        # ====================================================
        # SEGMENT INCHARGE
        # ====================================================
        else:

            segment_id = session.get("segment")

            if not segment_id:
                return redirect("/dashboard")

            # ------------------------------------------------
            # Get SI display name
            # ------------------------------------------------
            cur.execute("""
                SELECT full_name
                FROM public.aems_user
                WHERE user_id = %s
                  AND active_flag = TRUE
            """, (user_id,))

            si = cur.fetchone()

            if not si:
                return redirect("/dashboard")

            display_name = si["full_name"]

            # ------------------------------------------------
            # Verify that the requested centre belongs to
            # the SI's authorised segment.
            #
            # This does NOT depend on whether the cluster
            # currently has a CC.
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                FROM public.cluster_master cm

                JOIN public.cluster_center ccm
                    ON ccm.cluster_id = cm.cluster_id
                   AND ccm.academic_year_id = %s
                   AND ccm.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = ccm.center_id

                WHERE cm.segment_id = %s
                  AND cm.active_flag = TRUE
                  AND tc.center_id = %s
            """, (
                academic_year_id,
                segment_id,
                center_id
            ))

            centre = cur.fetchone()


        # ----------------------------------------------------
        # User is not authorised for this centre
        # ----------------------------------------------------
        if not centre:
            return redirect("/mobile/attendance")


        # ----------------------------------------------------
        # Get all active students for this centre.
        #
        # Attendance is based on centre membership.
        # It does NOT depend on student_academic_year.
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                sm.student_id,
                sm.student_code,
                sm.student_name

            FROM public.student_center_assignment sca

            JOIN public.student_master sm
                ON sm.student_id = sca.student_id

            WHERE sca.center_id = %s
              AND sca.academic_year_id = %s
              AND sca.active_flag = TRUE
              AND sm.active_flag = TRUE

            ORDER BY
                sm.student_name
        """, (
            center_id,
            academic_year_id
        ))

        students = cur.fetchall()


        # ----------------------------------------------------
        # Display existing centre attendance screen.
        #
        # Keep cc_name because the existing template expects
        # this variable. For an SI it contains the SI name.
        # ----------------------------------------------------
        return render_template(
            "mobile/centre_attendance.html",
            cc_name=display_name,
            centre=centre,
            students=students
        )

    except Exception as e:

        print("Mobile centre attendance page error:", e)

        return redirect("/dashboard")

    finally:

        cur.close()
        conn.close()

# ============================================================
# SUBMIT CC ATTENDANCE
# ============================================================
# ============================================================
# SUBMIT ATTENDANCE
# CC + SEGMENT INCHARGE
# ============================================================

@app.route(
    "/mobile/attendance/<int:center_id>/submit",
    methods=["POST"]
)
@login_required
def mobile_attendance_submit(center_id):

    role = session.get("role")
    user_id = session.get("user_id")

    # Attendance submission is available to:
    #   1. Cluster Coordinators
    #   2. Segment Incharges
    if role not in ["cluster_incharge", "segment_incharge"]:
        return {
            "success": False,
            "message": "Unauthorized"
        }, 403

    if not user_id:
        return {
            "success": False,
            "message": "User session not found."
        }, 403

    data = request.get_json(silent=True) or {}

    absent_ids = data.get("absent_student_ids", [])

    # --------------------------------------------------------
    # Make sure we received a list
    # --------------------------------------------------------
    if not isinstance(absent_ids, list):
        return {
            "success": False,
            "message": "Invalid attendance data."
        }, 400

    conn = get_connection()
    cur = conn.cursor()

    try:

        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT academic_year_id
            FROM public.academic_year_master
            WHERE academic_year = '2026-2027'
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return {
                "success": False,
                "message": "Academic year 2026-2027 not found."
            }, 500

        academic_year_id = academic_year["academic_year_id"]

        # This will contain the actual CC for a CC submission.
        # It remains NULL for an SI submission.
        cc_id = None


        # ====================================================
        # CLUSTER COORDINATOR
        # ====================================================
        if role == "cluster_incharge":

            # ------------------------------------------------
            # Identify logged-in CC
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    cc.cc_id,
                    cc.cc_name
                FROM public.user_person_assignment upa
                JOIN public.cluster_coordinator cc
                    ON cc.cc_id = upa.cc_id
                WHERE upa.user_id = %s
                  AND upa.active_flag = TRUE
                  AND cc.active_flag = TRUE
                LIMIT 1
            """, (user_id,))

            cc = cur.fetchone()

            if not cc:
                return {
                    "success": False,
                    "message": "Coordinator not found."
                }, 403

            cc_id = cc["cc_id"]

            # ------------------------------------------------
            # Verify centre belongs to this CC
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                FROM public.cluster_coordinator_assignment cca

                JOIN public.cluster_center ccm
                    ON ccm.cluster_id = cca.cluster_id
                   AND ccm.academic_year_id = cca.academic_year_id
                   AND ccm.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = ccm.center_id

                WHERE cca.cc_id = %s
                  AND cca.academic_year_id = %s
                  AND cca.active_flag = TRUE
                  AND tc.center_id = %s
            """, (
                cc_id,
                academic_year_id,
                center_id
            ))

            centre = cur.fetchone()


        # ====================================================
        # SEGMENT INCHARGE
        # ====================================================
        else:

            segment_id = session.get("segment")

            if not segment_id:
                return {
                    "success": False,
                    "message": "Segment access not found."
                }, 403

            # ------------------------------------------------
            # Verify centre belongs to SI's segment.
            #
            # This does NOT depend on a CC assignment.
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                FROM public.cluster_master cm

                JOIN public.cluster_center ccm
                    ON ccm.cluster_id = cm.cluster_id
                   AND ccm.academic_year_id = %s
                   AND ccm.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = ccm.center_id

                WHERE cm.segment_id = %s
                  AND cm.active_flag = TRUE
                  AND tc.center_id = %s
            """, (
                academic_year_id,
                segment_id,
                center_id
            ))

            centre = cur.fetchone()


        # ----------------------------------------------------
        # User is not authorised for this centre
        # ----------------------------------------------------
        if not centre:
            return {
                "success": False,
                "message": "This centre is not assigned to you."
            }, 403


        # ----------------------------------------------------
        # Duplicate protection
        # ----------------------------------------------------
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
                "message": (
                    "Attendance has already been submitted "
                    "for this centre today."
                )
            }, 409


        # ----------------------------------------------------
        # Get all active students for this centre
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                sm.student_id,
                sm.student_code,
                sm.student_name

            FROM public.student_center_assignment sca

            JOIN public.student_master sm
                ON sm.student_id = sca.student_id

            WHERE sca.center_id = %s
              AND sca.academic_year_id = %s
              AND sca.active_flag = TRUE
              AND sm.active_flag = TRUE

            ORDER BY
                sm.student_name
        """, (
            center_id,
            academic_year_id
        ))

        students = cur.fetchall()

        student_ids = {
            student["student_id"]
            for student in students
        }


        # ----------------------------------------------------
        # Validate absentee IDs
        # ----------------------------------------------------
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


        # ----------------------------------------------------
        # Every absentee must belong to this centre
        # ----------------------------------------------------
        if not absent_ids.issubset(student_ids):

            return {
                "success": False,
                "message": (
                    "One or more selected students "
                    "do not belong to this centre."
                )
            }, 400


        # ----------------------------------------------------
        # Centre must have active students
        # ----------------------------------------------------
        if not student_ids:

            return {
                "success": False,
                "message": (
                    "No active students are available "
                    "for this centre."
                )
            }, 400


        # ----------------------------------------------------
        # Create attendance submission
        #
        # CC:
        #   cc_id = actual CC
        #
        # SI:
        #   cc_id = NULL
        #
        # Both:
        #   submitted_by_user_id = logged-in user
        # ----------------------------------------------------
        cur.execute("""
            INSERT INTO public.attendance_submission
                (
                    center_id,
                    attendance_date,
                    cc_id,
                    submitted_by_user_id,
                    day_status
                )
            VALUES
                (
                    %s,
                    CURRENT_DATE,
                    %s,
                    %s,
                    'WORKING'
                )
            RETURNING submission_id
        """, (
            center_id,
            cc_id,
            user_id
        ))

        submission_id = cur.fetchone()["submission_id"]


        # ----------------------------------------------------
        # Insert attendance for every active student
        #
        # Everyone is PRESENT by default.
        # Selected students are ABSENT.
        # ----------------------------------------------------
        for student_id in student_ids:

            status = (
                "ABSENT"
                if student_id in absent_ids
                else "PRESENT"
            )

            cur.execute("""
                INSERT INTO public.student_attendance
                    (
                        student_id,
                        submission_id,
                        attendance_date,
                        attendance_status
                    )
                VALUES
                    (
                        %s,
                        %s,
                        CURRENT_DATE,
                        %s
                    )
            """, (
                student_id,
                submission_id,
                status
            ))


        # ----------------------------------------------------
        # Commit submission + student attendance together
        # ----------------------------------------------------
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


# ============================================================
# CC ATTENDANCE SUBMISSION CONFIRMATION
# ============================================================

# ============================================================
# ATTENDANCE SUBMISSION CONFIRMATION
# CC + SEGMENT INCHARGE
# ============================================================

@app.route("/mobile/attendance/submitted/<int:submission_id>")
@login_required
def mobile_attendance_submitted(submission_id):

    role = session.get("role")
    user_id = session.get("user_id")

    # Confirmation is available to:
    #   1. Cluster Coordinators
    #   2. Segment Incharges
    if role not in ["cluster_incharge", "segment_incharge"]:
        return redirect("/dashboard")

    if not user_id:
        return redirect("/dashboard")

    conn = get_connection()
    cur = conn.cursor()

    try:

        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT academic_year_id
            FROM public.academic_year_master
            WHERE academic_year = '2026-2027'
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return redirect("/dashboard")

        academic_year_id = academic_year["academic_year_id"]


        # ====================================================
        # CLUSTER COORDINATOR
        # ====================================================
        if role == "cluster_incharge":

            # ------------------------------------------------
            # Identify logged-in CC
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    cc.cc_id,
                    cc.cc_name
                FROM public.user_person_assignment upa
                JOIN public.cluster_coordinator cc
                    ON cc.cc_id = upa.cc_id
                WHERE upa.user_id = %s
                  AND upa.active_flag = TRUE
                  AND cc.active_flag = TRUE
                LIMIT 1
            """, (user_id,))

            cc = cur.fetchone()

            if not cc:
                return redirect("/dashboard")

            cc_id = cc["cc_id"]

            # ------------------------------------------------
            # Verify that the submission belongs to a centre
            # within the logged-in CC's active cluster scope.
            #
            # Notice that we do NOT require ats.cc_id = cc_id.
            # This allows the CC to view attendance for their
            # centre even if the SI submitted it.
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    ats.submission_id,
                    ats.attendance_date,
                    ats.submitted_at,
                    ats.day_status,

                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                FROM public.attendance_submission ats

                JOIN public.tuition_center tc
                    ON tc.center_id = ats.center_id

                JOIN public.cluster_center ccm
                    ON ccm.center_id = ats.center_id
                   AND ccm.academic_year_id = %s
                   AND ccm.active_flag = TRUE

                JOIN public.cluster_coordinator_assignment cca
                    ON cca.cluster_id = ccm.cluster_id
                   AND cca.academic_year_id = ccm.academic_year_id
                   AND cca.active_flag = TRUE
                   AND cca.cc_id = %s

                JOIN public.cluster_coordinator cc
                    ON cc.cc_id = cca.cc_id
                   AND cc.active_flag = TRUE

                WHERE ats.submission_id = %s
            """, (
                academic_year_id,
                cc_id,
                submission_id
            ))

            submission = cur.fetchone()


        # ====================================================
        # SEGMENT INCHARGE
        # ====================================================
        else:

            segment_id = session.get("segment")

            if not segment_id:
                return redirect("/dashboard")

            # ------------------------------------------------
            # Verify that the submission belongs to a centre
            # within the SI's authorised segment.
            #
            # It does not matter whether the attendance was
            # submitted by the CC or by the SI.
            # ------------------------------------------------
            cur.execute("""
                SELECT
                    ats.submission_id,
                    ats.attendance_date,
                    ats.submitted_at,
                    ats.day_status,

                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                FROM public.attendance_submission ats

                JOIN public.tuition_center tc
                    ON tc.center_id = ats.center_id

                JOIN public.cluster_center ccm
                    ON ccm.center_id = ats.center_id
                   AND ccm.academic_year_id = %s
                   AND ccm.active_flag = TRUE

                JOIN public.cluster_master cm
                    ON cm.cluster_id = ccm.cluster_id
                   AND cm.active_flag = TRUE

                WHERE ats.submission_id = %s
                  AND cm.segment_id = %s
            """, (
                academic_year_id,
                submission_id,
                segment_id
            ))

            submission = cur.fetchone()


        # ----------------------------------------------------
        # Submission is outside the user's authorised scope
        # ----------------------------------------------------
        if not submission:
            return redirect("/mobile/attendance")


        # ----------------------------------------------------
        # Attendance summary
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                COUNT(*) AS total_students,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'PRESENT'
                ) AS present,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'ABSENT'
                ) AS absent

            FROM public.student_attendance sa

            WHERE sa.submission_id = %s
              AND sa.attendance_date = %s
        """, (
            submission["submission_id"],
            submission["attendance_date"]
        ))

        summary = cur.fetchone()


        # ----------------------------------------------------
        # Display existing confirmation screen
        # ----------------------------------------------------
        return render_template(
            "mobile/attendance_submitted.html",
            submission=submission,
            summary=summary
        )

    except Exception as e:

        print("Attendance confirmation error:", e)

        return redirect("/mobile/attendance")

    finally:

        cur.close()
        conn.close()

# =====================================================
@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        username = request.form.get("username", "").strip()
        password = request.form.get("password", "")

        # =====================================================
        # FIRST: Check new database-backed users
        # =====================================================

        conn = get_connection()

        try:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:

                cur.execute("""
                    SELECT
                        u.user_id,
                        u.username,
                        u.password_hash,
                        u.full_name,
                        r.role_code,
                        r.role_name
                    FROM public.aems_user u
                    JOIN public.user_role ur
                        ON ur.user_id = u.user_id
                       AND ur.active_flag = TRUE
                       AND ur.assigned_from <= CURRENT_DATE
                       AND (
                            ur.assigned_to IS NULL
                            OR ur.assigned_to >= CURRENT_DATE
                       )
                    JOIN public.role_master r
                        ON r.role_id = ur.role_id
                       AND r.active_flag = TRUE
                    WHERE u.username = %s
                      AND u.active_flag = TRUE
                    ORDER BY ur.assigned_from DESC
                    LIMIT 1
                """, (username,))

                db_user = cur.fetchone()

                # -------------------------------------------------
                # User access scope
                # -------------------------------------------------

                access = None

                if db_user:

                    cur.execute("""
                        SELECT
                            access_scope,
                            zone_id,
                            segment_id,
                            cluster_id,
                            center_id
                        FROM public.user_access
                        WHERE user_id = %s
                          AND active_flag = TRUE
                          AND assigned_from <= CURRENT_DATE
                          AND (
                               assigned_to IS NULL
                               OR assigned_to >= CURRENT_DATE
                          )
                        ORDER BY assigned_from DESC
                        LIMIT 1
                    """, (db_user["user_id"],))

                    access = cur.fetchone()

        finally:
            conn.close()

        # =====================================================
        # DATABASE USER
        # =====================================================

        if db_user:

            # Verify password against stored Werkzeug hash
            if check_password_hash(
                db_user["password_hash"],
                password
            ):

                # -------------------------------------------------
                # Clear any previous session
                # -------------------------------------------------

                session.clear()

                # -------------------------------------------------
                # Common session information
                # -------------------------------------------------

                session["user_id"] = db_user["user_id"]
                session["username"] = db_user["username"]
                session["name"] = db_user["full_name"]

                # Canonical role from new security model
                session["role_code"] = db_user["role_code"]

                # -------------------------------------------------
                # Compatibility role
                #
                # Existing AEMS routes currently use lowercase
                # POC role names. Keep these temporarily so that
                # existing screens do not break.
                # -------------------------------------------------

                role_compatibility = {
                    "ADMIN": "admin",
                    "OPERATIONS_HEAD": "operational_head",
                    "MANAGEMENT": "management",
                    "SEGMENT_INCHARGE": "segment_incharge",
                    "CLUSTER_COORDINATOR": "cluster_incharge",
                    "TUTOR": "tutor"
                }

                session["role"] = role_compatibility.get(
                    db_user["role_code"],
                    db_user["role_code"].lower()
                )

                # -------------------------------------------------
                # Access scope
                # -------------------------------------------------

                if access:

                    session["access_scope"] = access["access_scope"]
                    session["access_zone_id"] = access["zone_id"]
                    session["access_segment_id"] = access["segment_id"]
                    session["access_cluster_id"] = access["cluster_id"]
                    session["access_center_id"] = access["center_id"]

                else:

                    session["access_scope"] = None
                    session["access_zone_id"] = None
                    session["access_segment_id"] = None
                    session["access_cluster_id"] = None
                    session["access_center_id"] = None

                # -------------------------------------------------
                # ADMIN
                # -------------------------------------------------

                if db_user["role_code"] == "ADMIN":
                    return redirect("/dashboard")

                # -------------------------------------------------
                # OPERATIONS HEAD
                # -------------------------------------------------

                if db_user["role_code"] == "OPERATIONS_HEAD":
                    return redirect("/operations-dashboard")
                # -------------------------------------------------
                # SEGMENT INCHARGE
                # -------------------------------------------------

                if db_user["role_code"] == "SEGMENT_INCHARGE":

                    segment_id = session.get("access_segment_id")

                    if not segment_id:
                        return redirect("/dashboard")

                    # Store segment context for existing AEMS routes
                    session["segment"] = segment_id

                    return redirect(
                        f"/segment/{segment_id}"
                    )


                # -------------------------------------------------
                # TUTOR
                # -------------------------------------------------

                if db_user["role_code"] == "TUTOR":

                    conn = get_connection()

                    try:
                        with conn.cursor(cursor_factory=RealDictCursor) as cur:

                            cur.execute("""
                                SELECT
                                    tca.center_id
                                FROM public.user_person_assignment upa

                                JOIN public.tutor_centre_assignment tca
                                    ON tca.tutor_id = upa.tutor_id

                                WHERE upa.user_id = %s
                                AND upa.active_flag = TRUE
                                AND tca.active_flag = TRUE
                                AND tca.academic_year_id = 3

                                ORDER BY tca.assigned_from DESC
                                LIMIT 1
                            """, (db_user["user_id"],))

                            tutor_centre = cur.fetchone()

                    finally:
                        conn.close()

                    if not tutor_centre:
                        return redirect("/dashboard")

                    session["centre"] = tutor_centre["center_id"]

                    return redirect(
                        f"/centre/{tutor_centre['center_id']}"
                    )


                # -------------------------------------------------
                # CLUSTER COORDINATOR
                # -------------------------------------------------

                if db_user["role_code"] == "CLUSTER_COORDINATOR":

                    conn = get_connection()

                    try:
                        with conn.cursor(cursor_factory=RealDictCursor) as cur:

                            cur.execute("""
                               SELECT
                                    upa.cc_id,
                                    cca.cluster_id,
                                    cm.cluster_name
                                FROM public.user_person_assignment upa

                                JOIN public.cluster_coordinator_assignment cca
                                    ON cca.cc_id = upa.cc_id

                                JOIN public.cluster_master cm
                                    ON cm.cluster_id = cca.cluster_id
                                WHERE upa.user_id = %s
                                  AND upa.active_flag = TRUE
                                  AND cca.academic_year_id = 3
                                  AND cca.active_flag = TRUE
                                ORDER BY cca.assigned_from DESC NULLS LAST
                                LIMIT 1
                            """, (db_user["user_id"],))

                            cc_assignment = cur.fetchone()

                    finally:
                        conn.close()

                    if not cc_assignment:
                        return redirect("/dashboard")

                    # Store CC and cluster context in session
                    session["cc_id"] = cc_assignment["cc_id"]
                    session["cluster_id"] = cc_assignment["cluster_id"]
                    session["cluster"] = cc_assignment["cluster_name"]
                    # Existing cluster dashboard route currently
                    # expects the CC ID.
                    return redirect(
                        f"/cluster-dashboard/{cc_assignment['cc_id']}"
                    )


                # -------------------------------------------------
                # Other database users
                # -------------------------------------------------

                return redirect("/dashboard")

            return render_template(
                "auth/login.html",
                error="Invalid username or password."
            )


    return render_template("auth/login.html")


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
@app.route("/cluster-dashboard/<int:cc_id>")
@login_required
def cluster_dashboard(cc_id):

    allowed_roles = [
        "admin",
        "management",
        "programme_director",
        "operational_head",
        "segment_incharge",
        "cluster_incharge"
    ]

    if session.get("role") not in allowed_roles:
        return redirect("/dashboard")

    # ---------------------------------------------------------
    # Cluster Coordinator can only view their own CC portfolio
    # ---------------------------------------------------------
    if session.get("role") == "cluster_incharge":

        if session.get("cc_id") != cc_id:
            return redirect(
                f"/cluster-dashboard/{session.get('cc_id')}"
            )

    # ---------------------------------------------------------
    # Load CC, cluster and centre data
    # ---------------------------------------------------------

    conn = get_connection()

    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:

            # -------------------------------------------------
            # Coordinator + Cluster details
            # -------------------------------------------------

            cur.execute("""
                SELECT
                    cc.cc_id,
                    cc.cc_name,
                    cca.cluster_id,
                    cm.cluster_name,
                    cm.segment_id

                FROM public.cluster_coordinator cc
                JOIN public.cluster_coordinator_assignment cca
                    ON cca.cc_id = cc.cc_id
                   AND cca.academic_year_id = 3
                   AND cca.active_flag = TRUE
                JOIN public.cluster_master cm
                    ON cm.cluster_id = cca.cluster_id
                WHERE cc.cc_id = %s
                  AND cc.active_flag = TRUE
                ORDER BY cca.assigned_from DESC NULLS LAST
                LIMIT 1
            """, (cc_id,))

            coordinator = cur.fetchone()

            if not coordinator:
                return redirect("/dashboard")

            # Keep the cluster context available in the session
            session["cc_id"] = coordinator["cc_id"]
            session["cluster_id"] = coordinator["cluster_id"]

            # -------------------------------------------------
            # Assigned centres and active students
            #
            # Current AEMS model:
            # CC → Cluster → Cluster Centre → Student Assignment
            # -------------------------------------------------

            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name,
                    COUNT(sm.student_id) AS students
                FROM public.cluster_coordinator_assignment cca

                JOIN public.cluster_center c
                    ON c.cluster_id = cca.cluster_id
                   AND c.academic_year_id = 3
                   AND c.active_flag = TRUE

                JOIN public.tuition_center tc
                    ON tc.center_id = c.center_id
                   AND tc.status = 'ACTIVE'

                LEFT JOIN public.student_center_assignment sca
                    ON sca.center_id = tc.center_id
                   AND sca.academic_year_id = 3
                   AND sca.active_flag = TRUE

                LEFT JOIN public.student_master sm
                    ON sm.student_id = sca.student_id
                   AND sm.active_flag = TRUE

                LEFT JOIN public.student_academic_year say
                    ON say.student_id = sm.student_id
                   AND say.academic_year_id = 3
                   AND say.status = 'ACTIVE'

                WHERE cca.cc_id = %s
                  AND cca.academic_year_id = 3
                  AND cca.active_flag = TRUE

                GROUP BY
                    tc.center_id,
                    tc.center_code,
                    tc.center_name

                ORDER BY tc.center_code
            """, (cc_id,))

            centres = cur.fetchall()

            # -------------------------------------------------
            # 5-Day Attendance Trend
            #
            # student_attendance has NO center_id.
            # Centre is obtained through attendance_submission.
            # -------------------------------------------------

            cur.execute("""
                SELECT
                    sa.attendance_date,
                    COUNT(*) AS total,

                    COUNT(*) FILTER (
                        WHERE sa.attendance_status = 'PRESENT'
                    ) AS present,

                    COUNT(*) FILTER (
                        WHERE sa.attendance_status = 'ABSENT'
                    ) AS absent

                FROM public.student_attendance sa

                JOIN public.attendance_submission ats
                    ON ats.submission_id = sa.submission_id

                JOIN public.cluster_center c
                    ON c.center_id = ats.center_id
                   AND c.academic_year_id = 3
                   AND c.active_flag = TRUE

                JOIN public.cluster_coordinator_assignment cca
                    ON cca.cluster_id = c.cluster_id
                   AND cca.cc_id = %s
                   AND cca.academic_year_id = 3
                   AND cca.active_flag = TRUE

                WHERE sa.attendance_date >= CURRENT_DATE - INTERVAL '4 days'
                  AND sa.attendance_date <= CURRENT_DATE

                GROUP BY sa.attendance_date
                ORDER BY sa.attendance_date
            """, (cc_id,))

            attendance_trend = cur.fetchall()

    finally:
        conn.close()

    # ---------------------------------------------------------
    # Calculate centre-wise today's attendance
    # ---------------------------------------------------------

    for centre in centres:

        attendance = get_connection()

        try:
            with attendance.cursor(
                cursor_factory=RealDictCursor
            ) as cur:

                cur.execute("""
                    SELECT
                        COUNT(*) AS total,

                        COUNT(*) FILTER (
                            WHERE sa.attendance_status = 'PRESENT'
                        ) AS present,

                        COUNT(*) FILTER (
                            WHERE sa.attendance_status = 'ABSENT'
                        ) AS absent

                    FROM public.student_attendance sa

                    JOIN public.attendance_submission ats
                        ON ats.submission_id = sa.submission_id

                    WHERE ats.center_id = %s
                      AND sa.attendance_date = CURRENT_DATE
                """, (centre["center_id"],))

                result = cur.fetchone()

        finally:
            attendance.close()

        total = result["total"] or 0
        present = result["present"] or 0
        absent = result["absent"] or 0

        centre["attendance_total"] = total
        centre["present"] = present
        centre["absent"] = absent

        if total > 0:

            centre["attendance_value"] = round(
                (present / total) * 100,
                1
            )

            centre["attendance"] = (
                f'{centre["attendance_value"]}%'
            )

        else:

            centre["attendance_value"] = 0
            centre["attendance"] = "—"

    # ---------------------------------------------------------
    # Calculate today's CC totals
    # ---------------------------------------------------------

    total_students = sum(
        c["students"] for c in centres
    )

    total_attendance = sum(
        c["attendance_total"] for c in centres
    )

    total_present = sum(
        c["present"] for c in centres
    )

    total_absent = sum(
        c["absent"] for c in centres
    )

    if total_attendance > 0:

        attendance_percentage = round(
            (total_present / total_attendance) * 100,
            1
        )

    else:

        attendance_percentage = 0

    # ---------------------------------------------------------
    # CC summary
    # ---------------------------------------------------------

    cluster = {
    "name": coordinator["cc_name"],
    "cluster_name": coordinator["cluster_name"],
    "segment_id": coordinator["segment_id"],
    "centres": len(centres),
    "students": total_students,
    "attendance": f"{attendance_percentage}%",
    "present": total_present,
    "absent": total_absent
}

    # ---------------------------------------------------------
    # Calculate daily attendance percentages for trend
    # ---------------------------------------------------------

    for day in attendance_trend:

        total = day["total"] or 0
        present = day["present"] or 0

        if total > 0:

            day["attendance_percentage"] = round(
                (present / total) * 100,
                1
            )

        else:

            day["attendance_percentage"] = 0

    # ---------------------------------------------------------
    # Calculate 5-day aggregate average
    # ---------------------------------------------------------

    trend_total = sum(
        day["total"] for day in attendance_trend
    )

    trend_present = sum(
        day["present"] for day in attendance_trend
    )

    if trend_total > 0:

        trend_average = round(
            (trend_present / trend_total) * 100,
            1
        )

    else:

        trend_average = 0




    # ---------------------------------------------------------
    # Weekly Centre Attendance
    # Monday to Saturday
    # ---------------------------------------------------------

    requested_week = request.args.get("week")

    if requested_week:
        try:
            week_start = datetime.strptime(
                requested_week, "%Y-%m-%d"
            ).date()
        except ValueError:
            week_start = (
                datetime.today().date()
                - timedelta(
                    days=datetime.today().date().weekday()
                )
            )
    else:
        week_start = (
            datetime.today().date()
            - timedelta(
                days=datetime.today().date().weekday()
            )
        )

    week_days = [
        week_start + timedelta(days=i)
        for i in range(6)
    ]

    week_end = week_days[-1]

    previous_week = week_start - timedelta(days=7)
    next_week = week_start + timedelta(days=7)

    # ---------------------------------------------------------
    # Fetch weekly attendance for all centres
    # ---------------------------------------------------------

    weekly_rows = {}

    weekly_conn = get_connection()

    try:
        with weekly_conn.cursor(
            cursor_factory=RealDictCursor
        ) as cur:

            cur.execute("""
                SELECT
                    ats.center_id,
                    sa.attendance_date,

                    COUNT(*) FILTER (
                        WHERE sa.attendance_status = 'PRESENT'
                    ) AS present,

                    COUNT(*) FILTER (
                        WHERE sa.attendance_status = 'ABSENT'
                    ) AS absent

                FROM public.student_attendance sa

                JOIN public.attendance_submission ats
                    ON ats.submission_id = sa.submission_id

                JOIN public.cluster_center c
                    ON c.center_id = ats.center_id
                   AND c.academic_year_id = 3
                   AND c.active_flag = TRUE

                JOIN public.cluster_coordinator_assignment cca
                    ON cca.cluster_id = c.cluster_id
                   AND cca.cc_id = %s
                   AND cca.academic_year_id = 3
                   AND cca.active_flag = TRUE

                WHERE sa.attendance_date >= %s
                  AND sa.attendance_date <= %s

                GROUP BY
                    ats.center_id,
                    sa.attendance_date

                ORDER BY
                    ats.center_id,
                    sa.attendance_date
            """, (
                cc_id,
                week_start,
                week_end
            ))

            attendance_rows = cur.fetchall()

    finally:
        weekly_conn.close()

    # ---------------------------------------------------------
    # Prepare centre-wise weekly structure
    # ---------------------------------------------------------

    for centre in centres:

        weekly_rows[centre["center_id"]] = {
            "center_id": centre["center_id"],
            "center_code": centre["center_code"],
            "center_name": centre["center_name"],
            "days": {},
            "week_present": 0,
            "week_absent": 0,
            "week_total": 0,
            "week_percentage": None
        }

        for day in week_days:
            weekly_rows[
                centre["center_id"]
            ]["days"][day] = None

    # ---------------------------------------------------------
    # Calculate daily and weekly percentages
    # ---------------------------------------------------------

    for row in attendance_rows:

        center_id = row["center_id"]
        attendance_date = row["attendance_date"]

        present = row["present"] or 0
        absent = row["absent"] or 0
        total = present + absent

        if center_id not in weekly_rows:
            continue

        if total > 0:
            daily_percentage = round(
                (present / total) * 100,
                1
            )
        else:
            daily_percentage = None

        weekly_rows[center_id]["days"][
            attendance_date
        ] = daily_percentage

        weekly_rows[center_id]["week_present"] += present
        weekly_rows[center_id]["week_absent"] += absent
        weekly_rows[center_id]["week_total"] += total

    # ---------------------------------------------------------
    # Final weekly percentage
    # ---------------------------------------------------------

    for centre in weekly_rows.values():

        if centre["week_total"] > 0:

            centre["week_percentage"] = round(
                (
                    centre["week_present"]
                    / centre["week_total"]
                ) * 100,
                1
            )

    weekly_centre_attendance = list(
        weekly_rows.values()
    )


    # ---------------------------------------------------------
    # Monthly Attendance & Performance — Centre Comparison
    #
    # Three calendar months.
    # The month window is driven by calendar logic,
    # NOT by available attendance data.
    # ---------------------------------------------------------

    def add_months(source_date, months):

        month = source_date.month - 1 + months

        year = source_date.year + month // 12

        month = month % 12 + 1

        return source_date.replace(
            year=year,
            month=month,
            day=1
        )


    requested_month = request.args.get("month")


    if requested_month:

        try:

            monthly_anchor = datetime.strptime(
                requested_month,
                "%Y-%m"
            ).date().replace(day=1)

        except ValueError:

            monthly_anchor = (
                datetime.today()
                .date()
                .replace(day=1)
            )

    else:

        monthly_anchor = (
            datetime.today()
            .date()
            .replace(day=1)
        )


    # Three-month window

    monthly_months = [

        add_months(
            monthly_anchor,
            -2
        ),

        add_months(
            monthly_anchor,
            -1
        ),

        monthly_anchor

    ]


    # Navigation moves exactly three months

    previous_month = add_months(
        monthly_anchor,
        -3
    )

    next_month = add_months(
        monthly_anchor,
        3
    )


    # ---------------------------------------------------------
    # Initialise every centre for all three months
    #
    # This ensures that the calendar months are always displayed
    # even when there is no attendance data.
    # ---------------------------------------------------------

    monthly_rows = {}


    for centre in centres:

        center_id = centre["center_id"]

        monthly_rows[center_id] = {

            "center_id": center_id,

            "center_code":
                centre["center_code"],

            "center_name":
                centre["center_name"],

            "months": {}

        }


        for month in monthly_months:

            monthly_rows[
                center_id
            ]["months"][month] = {

                "attendance": None,

                "performance": None

            }


    # ---------------------------------------------------------
    # Monthly attendance
    #
    # Only WORKING days are included.
    #
    # Tutor Absent / Holiday therefore do not enter the
    # attendance denominator.
    # ---------------------------------------------------------

    monthly_start = monthly_months[0]

    monthly_end = add_months(
        monthly_months[-1],
        1
    )


    monthly_conn = get_connection()


    try:

        with monthly_conn.cursor(
            cursor_factory=RealDictCursor
        ) as cur:

            cur.execute("""
                SELECT

                    ats.center_id,

                    DATE_TRUNC(
                        'month',
                        ats.attendance_date
                    )::date AS month_start,

                    COUNT(*) FILTER (
                        WHERE sa.attendance_status = 'PRESENT'
                    ) AS present,

                    COUNT(*) FILTER (
                        WHERE sa.attendance_status = 'ABSENT'
                    ) AS absent

                FROM public.student_attendance sa

                JOIN public.attendance_submission ats
                    ON ats.submission_id =
                       sa.submission_id

                JOIN public.cluster_center c
                    ON c.center_id = ats.center_id
                   AND c.academic_year_id = 3
                   AND c.active_flag = TRUE

                JOIN public.cluster_coordinator_assignment cca
                    ON cca.cluster_id = c.cluster_id
                   AND cca.cc_id = %s
                   AND cca.academic_year_id = 3
                   AND cca.active_flag = TRUE

                WHERE ats.attendance_date >= %s
                  AND ats.attendance_date < %s
                  AND ats.day_status = 'WORKING'

                GROUP BY

                    ats.center_id,

                    DATE_TRUNC(
                        'month',
                        ats.attendance_date
                    )::date

                ORDER BY

                    ats.center_id,

                    month_start

            """, (
                cc_id,
                monthly_start,
                monthly_end
            ))

            monthly_attendance_rows = cur.fetchall()

    finally:

        monthly_conn.close()


    # ---------------------------------------------------------
    # Populate monthly attendance
    # ---------------------------------------------------------

    for row in monthly_attendance_rows:

        center_id = row["center_id"]

        month_start = row["month_start"]

        present = row["present"] or 0

        absent = row["absent"] or 0

        total = present + absent


        if total > 0:

            percentage = round(
                (present / total) * 100,
                1
            )

        else:

            percentage = None


        if center_id in monthly_rows:

            if month_start in monthly_rows[
                center_id
            ]["months"]:

                monthly_rows[
                    center_id
                ]["months"][
                    month_start
                ]["attendance"] = percentage


    # ---------------------------------------------------------
    # Performance
    #
    # No verified performance source is being used yet.
    # Therefore performance remains None and displays as —.
    # ---------------------------------------------------------

    monthly_centre_attendance = list(
        monthly_rows.values()
    )

    # ---------------------------------------------------------
    # Attendance date
    # ---------------------------------------------------------

    attendance_date = datetime.today().date()

    # ---------------------------------------------------------
    # Render CC dashboard
    # ---------------------------------------------------------

    return render_template(
        "cluster/cluster_dashboard.html",
        cluster=cluster,
        centres=centres,
        attendance_date=attendance_date,
        attendance_trend=attendance_trend,
        trend_average=trend_average,
        weekly_centre_attendance=weekly_centre_attendance,
        week_days=week_days,
        week_start=week_start,
        week_end=week_end,
        previous_week=previous_week,
        next_week=next_week,
        monthly_centre_attendance=monthly_centre_attendance,
        monthly_months=monthly_months,
        monthly_anchor=monthly_anchor,
        previous_month=previous_month,
        next_month=next_month,
        active_page="cluster",
        show_mobile_attendance=(
            session.get("role") == "cluster_incharge"
        )
    )
# =====================================================
# HOME
# =====================================================

@app.route("/")
def index():

    return redirect("/login")


# =========================================
# CENTRE / TUTOR DASHBOARD
# =========================================

@app.route("/centre/<int:centre_id>")
@login_required
def centre_dashboard(centre_id):

    role = session.get("role")
    user_id = session.get("user_id")

    db = get_connection()

    try:
        with db.cursor(cursor_factory=RealDictCursor) as cur:

            # -----------------------------------------
            # 1. CENTRE DETAILS
            # -----------------------------------------
            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name,
                    am.area_name
                FROM public.tuition_center tc

                LEFT JOIN public.area_master am
                    ON am.area_id = tc.area_id

                WHERE tc.center_id = %s
                AND tc.status = 'ACTIVE'
            """, (centre_id,))

            centre = cur.fetchone()

            if not centre:
                return redirect("/dashboard")


            # -----------------------------------------
            # 2. VERIFY USER ACCESS TO THIS CENTRE
            # -----------------------------------------

            if role == "tutor":

                # Tutor can access only the centre currently
                # assigned to the logged-in tutor.
                cur.execute("""
                    SELECT 1
                    FROM public.user_person_assignment upa

                    JOIN public.tutor_centre_assignment tca
                        ON tca.tutor_id = upa.tutor_id
                       AND tca.active_flag = TRUE

                    WHERE upa.user_id = %s
                      AND upa.active_flag = TRUE
                      AND tca.center_id = %s
                      AND tca.academic_year_id = 3
                """, (
                    user_id,
                    centre_id
                ))

                if not cur.fetchone():
                    return redirect("/dashboard")


            elif role == "cluster_incharge":

                # CC can access centres belonging to the
                # cluster currently assigned to that CC.
                cur.execute("""
                    SELECT 1
                    FROM public.user_person_assignment upa

                    JOIN public.cluster_coordinator_assignment cca
                        ON cca.cc_id = upa.cc_id
                       AND cca.active_flag = TRUE

                    JOIN public.cluster_center cc
                        ON cc.cluster_id = cca.cluster_id
                       AND cc.active_flag = TRUE
                       AND cc.academic_year_id = 3

                    WHERE upa.user_id = %s
                      AND upa.active_flag = TRUE
                      AND cca.academic_year_id = 3
                      AND cc.center_id = %s
                """, (
                    user_id,
                    centre_id
                ))

                if not cur.fetchone():
                    return redirect("/dashboard")


            # -----------------------------------------
            # 3. CURRENT TUTOR
            # -----------------------------------------

            tutor = None

            cur.execute("""
                SELECT
                    tm.tutor_id,
                    tm.tutor_name
                FROM public.tutor_centre_assignment tca

                JOIN public.tutor_master tm
                    ON tm.tutor_id = tca.tutor_id

                WHERE tca.center_id = %s
                  AND tca.academic_year_id = 3
                  AND tca.active_flag = TRUE
                  AND tm.active_flag = TRUE
            """, (centre_id,))

            tutor = cur.fetchone()

            # -----------------------------------------
            # 4. STUDENT STRENGTH
            # -----------------------------------------
           
            # Do NOT depend on student_academic_year here.
            # Class information is handled separately where
            # required.
            
            # Centre membership is the source of truth
            # for current student strength.
            #
            # Group A / Group B is the primary AVF
            # operational classification.
            #
            # Class remains secondary information.
            # -----------------------------------------
            cur.execute("""
                SELECT
                    COUNT(*) AS total_students,

                    COUNT(*) FILTER (
                        WHERE sm.gender = 'Boy'
                    ) AS boys,

                    COUNT(*) FILTER (
                        WHERE sm.gender = 'Girl'
                    ) AS girls,

                    COUNT(*) FILTER (
                        WHERE cgm.group_code = 'A'
                    ) AS group_a_students,

                    COUNT(*) FILTER (
                        WHERE cgm.group_code = 'B'
                    ) AS group_b_students,

                    COUNT(*) FILTER (
                        WHERE cgm.group_code = 'A'
                          AND sm.gender = 'Boy'
                    ) AS group_a_boys,

                    COUNT(*) FILTER (
                        WHERE cgm.group_code = 'A'
                          AND sm.gender = 'Girl'
                    ) AS group_a_girls,

                    COUNT(*) FILTER (
                        WHERE cgm.group_code = 'B'
                          AND sm.gender = 'Boy'
                    ) AS group_b_boys,

                    COUNT(*) FILTER (
                        WHERE cgm.group_code = 'B'
                          AND sm.gender = 'Girl'
                    ) AS group_b_girls,

                    COUNT(*) FILTER (
                        WHERE sm.caste_category IS NOT NULL
                          AND TRIM(sm.caste_category) <> ''
                    ) AS caste_available

                FROM public.student_center_assignment sca

                JOIN public.student_master sm
                    ON sm.student_id = sca.student_id

                LEFT JOIN public.student_academic_year say
                    ON say.student_id = sm.student_id
                   AND say.academic_year_id = 3

                LEFT JOIN public.curriculum_group_master cgm
                    ON cgm.group_id = say.group_id

                WHERE sca.center_id = %s
                  AND sca.academic_year_id = 3
                  AND sca.active_flag = TRUE
                  AND sm.active_flag = TRUE
            """, (centre_id,))

            strength = cur.fetchone()

                        # -----------------------------------------
            # INACTIVE ENROLLMENTS
            # -----------------------------------------

            cur.execute("""
                SELECT
                    COUNT(*) AS inactive_enrollments
                FROM public.student_center_assignment sca

                JOIN public.student_master sm
                    ON sm.student_id = sca.student_id

                WHERE sca.center_id = %s
                  AND sca.academic_year_id = 3
                  AND sca.active_flag = TRUE
                  AND sm.active_flag = FALSE
            """, (centre_id,))

            inactive_row = cur.fetchone()

            inactive_enrollments = (
                inactive_row["inactive_enrollments"] or 0
            )

            # -----------------------------------------
            # 5. STUDENT LIST
            # -----------------------------------------
            # Student membership comes directly from
            # student_center_assignment.
            # -----------------------------------------
            cur.execute("""
                SELECT
                    sm.student_id,
                    sm.student_code,
                    sm.student_name,
                    sm.gender

                FROM public.student_center_assignment sca

                JOIN public.student_master sm
                    ON sm.student_id = sca.student_id

                WHERE sca.center_id = %s
                  AND sca.academic_year_id = 3
                  AND sca.active_flag = TRUE
                  AND sm.active_flag = TRUE

                ORDER BY
                    sm.student_name
            """, (centre_id,))

            students = cur.fetchall()

            # -----------------------------------------
            # 6. LATEST ATTENDANCE DATE
            # -----------------------------------------
            cur.execute("""
                SELECT
                    MAX(attendance_date) AS latest_date
                FROM public.attendance_submission
                WHERE center_id = %s
            """, (centre_id,))

            latest = cur.fetchone()

            latest_attendance_date = latest["latest_date"]


            # -----------------------------------------
            # 7. LATEST ATTENDANCE SUMMARY
            # -----------------------------------------
            latest_attendance = {
                "total": 0,
                "present": 0,
                "absent": 0,
                "percentage": 0
            }

            if latest_attendance_date:

                cur.execute("""
                    SELECT
                        COUNT(*) AS total,

                        COUNT(*) FILTER (
                            WHERE sa.attendance_status = 'PRESENT'
                        ) AS present,

                        COUNT(*) FILTER (
                            WHERE sa.attendance_status = 'ABSENT'
                        ) AS absent

                    FROM public.student_attendance sa

                    JOIN public.attendance_submission ats
                        ON ats.submission_id = sa.submission_id

                    WHERE ats.center_id = %s
                      AND sa.attendance_date = %s
                """, (
                    centre_id,
                    latest_attendance_date
                ))

                result = cur.fetchone()

                total = result["total"] or 0
                present = result["present"] or 0
                absent = result["absent"] or 0

                latest_attendance["total"] = total
                latest_attendance["present"] = present
                latest_attendance["absent"] = absent

                if total > 0:
                    latest_attendance["percentage"] = round(
                        (present / total) * 100,
                        1
                    )


            # -----------------------------------------
            # 8. ABSENTEES ON LATEST DATE
            # -----------------------------------------
            absentees = []

            if latest_attendance_date:

                cur.execute("""
                    SELECT
                        sm.student_id,
                        sm.student_code,
                        sm.student_name,
                        sm.gender,
                        sa.attendance_date,
                        sa.remarks

                    FROM public.student_attendance sa

                    JOIN public.student_master sm
                        ON sm.student_id = sa.student_id

                    JOIN public.attendance_submission ats
                        ON ats.submission_id = sa.submission_id

                    WHERE ats.center_id = %s
                      AND sa.attendance_date = %s
                      AND sa.attendance_status = 'ABSENT'

                    ORDER BY sm.student_name
                """, (
                    centre_id,
                    latest_attendance_date
                ))

                absentees = cur.fetchall()


            # -----------------------------------------
            # 9. FIVE-DAY ATTENDANCE TREND
            # -----------------------------------------
            attendance_trend = []

            weekly_attendance = {
                "total": 0,
                "present": 0,
                "absent": 0,
                "percentage": 0
            }

            if latest_attendance_date:

                cur.execute("""
                    SELECT
                        sa.attendance_date,

                        COUNT(*) AS total,

                        COUNT(*) FILTER (
                            WHERE sa.attendance_status = 'PRESENT'
                        ) AS present,

                        COUNT(*) FILTER (
                            WHERE sa.attendance_status = 'ABSENT'
                        ) AS absent

                    FROM public.student_attendance sa

                    JOIN public.attendance_submission ats
                        ON ats.submission_id = sa.submission_id

                    WHERE ats.center_id = %s
                      AND sa.attendance_date >=
                          %s - INTERVAL '4 days'
                      AND sa.attendance_date <= %s

                    GROUP BY sa.attendance_date
                    ORDER BY sa.attendance_date
                """, (
                    centre_id,
                    latest_attendance_date,
                    latest_attendance_date
                ))

                attendance_trend = cur.fetchall()

                # -----------------------------------------
                # FIVE-DAY TOTAL
                # -----------------------------------------

                for day in attendance_trend:

                    total = day["total"] or 0
                    present = day["present"] or 0
                    absent = day["absent"] or 0

                    day["attendance_percentage"] = (
                        round((present / total) * 100, 1)
                        if total > 0
                        else 0
                    )

                    weekly_attendance["total"] += total
                    weekly_attendance["present"] += present
                    weekly_attendance["absent"] += absent

                if weekly_attendance["total"] > 0:

                    weekly_attendance["percentage"] = round(
                        (
                            weekly_attendance["present"]
                            / weekly_attendance["total"]
                        ) * 100,
                        1
                    )

            # -----------------------------------------
            # 10. CENTRE DISPLAY OBJECT
            # -----------------------------------------

            centre["tutor_name"] = (
                tutor["tutor_name"]
                if tutor
                else None
            )

            centre["academic_year"] = "2026–2027"

            if not centre.get("center_name"):
                centre["center_name"] = "Name not available"

            centre["total_students"] = (
                strength["total_students"] or 0
            )
            
            centre["inactive_enrollments"] = inactive_enrollments

            centre["boys"] = (
                strength["boys"] or 0
            )

            centre["girls"] = (
                strength["girls"] or 0
            )

            centre["group_a_students"] = (
                strength["group_a_students"] or 0
            )

            centre["group_b_students"] = (
                strength["group_b_students"] or 0
            )

            centre["group_a_boys"] = (
                strength["group_a_boys"] or 0
            )

            centre["group_a_girls"] = (
                strength["group_a_girls"] or 0
            )

            centre["group_b_boys"] = (
                strength["group_b_boys"] or 0
            )

            centre["group_b_girls"] = (
                strength["group_b_girls"] or 0
            )

            centre["caste_available"] = (
                strength["caste_available"] or 0
            )


    finally:
        db.close()


    # -----------------------------------------
    # 11. RENDER
    # -----------------------------------------

    return render_template(
    "aems/avlc/dashboard.html",

    centre=centre,

    students=students,

    latest_attendance_date=latest_attendance_date,

    latest_attendance=latest_attendance,

    weekly_attendance=weekly_attendance,

    absentees=absentees,

    attendance_trend=attendance_trend,

    active_page="avlc"
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

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    # =========================================================
    # Helper: add/subtract calendar months
    # =========================================================
    def add_months(source_date, months):
        month = source_date.month - 1 + months
        year = source_date.year + month // 12
        month = month % 12 + 1

        return source_date.replace(
            year=year,
            month=month,
            day=1
        )

    try:

        # =====================================================
        # 1. SEGMENT DETAILS
        # =====================================================

        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE segment_id = %s
              AND active_flag = TRUE
        """, (segment_id,))

        segment_row = cur.fetchone()

        if not segment_row:
            return "Segment not found", 404


        # =====================================================
        # 2. CLUSTER DETAILS
        #
        # Segment
        #    ↓
        # Cluster
        #    ↓
        # Centres
        #    ↓
        # Student enrolments
        # =====================================================

        cur.execute("""
            SELECT
                c.cluster_id,
                c.cluster_name,

                COUNT(DISTINCT cc.center_id) AS centres,

                COUNT(DISTINCT sm.student_id) AS students

            FROM cluster_master c

            LEFT JOIN cluster_center cc
                ON cc.cluster_id = c.cluster_id
               AND cc.academic_year_id = 3
               AND cc.active_flag = TRUE

            LEFT JOIN student_center_assignment sca
                ON sca.center_id = cc.center_id
               AND sca.academic_year_id = 3
               AND sca.active_flag = TRUE

            LEFT JOIN student_master sm
                ON sm.student_id = sca.student_id
               AND sm.active_flag = TRUE

            WHERE c.segment_id = %s
              AND c.active_flag = TRUE

            GROUP BY
                c.cluster_id,
                c.cluster_name

            ORDER BY
                c.cluster_id
        """, (segment_id,))

        cluster_rows = cur.fetchall()


        # =====================================================
        # 3. TODAY'S ATTENDANCE BY CLUSTER
        # =====================================================

        cur.execute("""
            SELECT
                c.cluster_id,

                COUNT(sa.attendance_id) AS attendance_total,

                COUNT(sa.attendance_id) FILTER (
                    WHERE sa.attendance_status = 'PRESENT'
                ) AS present,

                COUNT(sa.attendance_id) FILTER (
                    WHERE sa.attendance_status = 'ABSENT'
                ) AS absent

            FROM cluster_master c

            JOIN cluster_center cc
                ON cc.cluster_id = c.cluster_id
               AND cc.academic_year_id = 3
               AND cc.active_flag = TRUE

            LEFT JOIN attendance_submission ats
                ON ats.center_id = cc.center_id
               AND ats.attendance_date = CURRENT_DATE

            LEFT JOIN student_attendance sa
                ON sa.submission_id = ats.submission_id
               AND sa.attendance_date = CURRENT_DATE

            WHERE c.segment_id = %s
              AND c.active_flag = TRUE

            GROUP BY
                c.cluster_id

            ORDER BY
                c.cluster_id
        """, (segment_id,))

        attendance_rows = cur.fetchall()

        attendance_by_cluster = {
            row["cluster_id"]: row
            for row in attendance_rows
        }


        # =====================================================
        # 4. OPTIONAL CC FOR EACH CLUSTER
        #
        # Used only to provide the existing Cluster Dashboard
        # link.
        #
        # A cluster may legitimately have no CC.
        # =====================================================

        cur.execute("""
            SELECT
                cca.cluster_id,
                cca.cc_id

            FROM cluster_coordinator_assignment cca

            WHERE cca.academic_year_id = 3
              AND cca.active_flag = TRUE

            ORDER BY
                cca.assigned_from DESC NULLS LAST
        """)

        cc_rows = cur.fetchall()

        cc_by_cluster = {}

        for row in cc_rows:

            if row["cluster_id"] not in cc_by_cluster:
                cc_by_cluster[row["cluster_id"]] = row["cc_id"]


        # =====================================================
        # 5. PREPARE TODAY'S CLUSTER DATA
        # =====================================================

        for cluster in cluster_rows:

            cluster_id = cluster["cluster_id"]

            attendance = attendance_by_cluster.get(
                cluster_id
            )

            if attendance:

                total = attendance["attendance_total"] or 0
                present = attendance["present"] or 0
                absent = attendance["absent"] or 0

                cluster["attendance_total"] = total
                cluster["present"] = present
                cluster["absent"] = absent

                if total > 0:

                    percentage = round(
                        (present / total) * 100,
                        1
                    )

                    cluster["attendance_value"] = percentage
                    cluster["attendance"] = f"{percentage}%"

                    # RAG status
                    if percentage < 75:
                        cluster["status"] = "RED"
                        cluster["status_class"] = "text-danger"

                    elif percentage < 90:
                        cluster["status"] = "AMBER"
                        cluster["status_class"] = "text-warning"

                    else:
                        cluster["status"] = "GREEN"
                        cluster["status_class"] = "text-success"

                else:

                    cluster["attendance_value"] = None
                    cluster["attendance"] = "—"
                    cluster["status"] = "—"
                    cluster["status_class"] = "text-muted"

            else:

                cluster["attendance_total"] = 0
                cluster["present"] = 0
                cluster["absent"] = 0
                cluster["attendance_value"] = None
                cluster["attendance"] = "—"
                cluster["status"] = "—"
                cluster["status_class"] = "text-muted"

            cluster["cc_id"] = cc_by_cluster.get(
                cluster_id
            )


        # =====================================================
        # 6. SEGMENT TODAY'S ATTENDANCE
        # =====================================================

        segment_attendance_total = sum(
            cluster["attendance_total"]
            for cluster in cluster_rows
        )

        segment_present = sum(
            cluster["present"]
            for cluster in cluster_rows
        )

        segment_absent = sum(
            cluster["absent"]
            for cluster in cluster_rows
        )

        if segment_attendance_total > 0:

            segment_attendance_percentage = round(
                (
                    segment_present
                    / segment_attendance_total
                ) * 100,
                1
            )

            segment_attendance = (
                f"{segment_attendance_percentage}%"
            )

        else:

            segment_attendance = "—"


        # =====================================================
        # 7. WEEKLY ATTENDANCE
        #
        # Monday to Saturday
        # =====================================================

        requested_week = request.args.get("week")

        if requested_week:

            try:

                week_start = datetime.strptime(
                    requested_week,
                    "%Y-%m-%d"
                ).date()

            except ValueError:

                today = datetime.today().date()

                week_start = (
                    today
                    - timedelta(days=today.weekday())
                )

        else:

            today = datetime.today().date()

            week_start = (
                today
                - timedelta(days=today.weekday())
            )


        # Always normalise to Monday

        week_start = (
            week_start
            - timedelta(days=week_start.weekday())
        )

        week_days = [
            week_start + timedelta(days=i)
            for i in range(6)
        ]

        week_end = week_days[-1]

        previous_week = (
            week_start - timedelta(days=7)
        )

        next_week = (
            week_start + timedelta(days=7)
        )


        # =====================================================
        # 8. FETCH WEEKLY ATTENDANCE
        # =====================================================

        cur.execute("""
            SELECT
                c.cluster_id,
                sa.attendance_date,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'PRESENT'
                ) AS present,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'ABSENT'
                ) AS absent

            FROM cluster_master c

            JOIN cluster_center cc
                ON cc.cluster_id = c.cluster_id
               AND cc.academic_year_id = 3
               AND cc.active_flag = TRUE

            JOIN attendance_submission ats
                ON ats.center_id = cc.center_id
               AND ats.attendance_date >= %s
               AND ats.attendance_date <= %s

            JOIN student_attendance sa
                ON sa.submission_id = ats.submission_id
               AND sa.attendance_date >= %s
               AND sa.attendance_date <= %s

            WHERE c.segment_id = %s
              AND c.active_flag = TRUE

            GROUP BY
                c.cluster_id,
                sa.attendance_date

            ORDER BY
                c.cluster_id,
                sa.attendance_date

        """, (
            week_start,
            week_end,
            week_start,
            week_end,
            segment_id
        ))

        weekly_rows = cur.fetchall()


        # =====================================================
        # 9. PREPARE WEEKLY CLUSTER STRUCTURE
        # =====================================================

        weekly_cluster_rows = {}

        for cluster in cluster_rows:

            cluster_id = cluster["cluster_id"]

            weekly_cluster_rows[cluster_id] = {
                "cluster_id": cluster_id,
                "cluster_name": cluster["cluster_name"],
                "days": {},
                "week_present": 0,
                "week_absent": 0,
                "week_total": 0
            }


        # =====================================================
        # 10. POPULATE WEEKLY DATA
        # =====================================================

        for row in weekly_rows:

            cluster_id = row["cluster_id"]

            attendance_date = row["attendance_date"]

            present = row["present"] or 0
            absent = row["absent"] or 0

            total = present + absent

            if total > 0:

                daily_percentage = round(
                    (present / total) * 100,
                    1
                )

            else:

                daily_percentage = None


            weekly_cluster_rows[
                cluster_id
            ]["days"][attendance_date] = (
                daily_percentage
            )

            weekly_cluster_rows[
                cluster_id
            ]["week_present"] += present

            weekly_cluster_rows[
                cluster_id
            ]["week_absent"] += absent

            weekly_cluster_rows[
                cluster_id
            ]["week_total"] += total


        # =====================================================
        # 11. WEEKLY AVERAGE
        # =====================================================

        for cluster in weekly_cluster_rows.values():

            if cluster["week_total"] > 0:

                cluster["week_percentage"] = round(
                    (
                        cluster["week_present"]
                        / cluster["week_total"]
                    ) * 100,
                    1
                )

            else:

                cluster["week_percentage"] = None


        weekly_cluster_attendance = list(
            weekly_cluster_rows.values()
        )


        # =====================================================
        # 12. MONTHLY WINDOW
        #
        # Three calendar months.
        #
        # IMPORTANT:
        # This is driven by calendar logic.
        # It is NOT driven by available attendance data.
        # =====================================================

        requested_month = request.args.get("month")

        if requested_month:

            try:

                monthly_anchor = datetime.strptime(
                    requested_month,
                    "%Y-%m"
                ).date().replace(day=1)

            except ValueError:

                monthly_anchor = (
                    datetime.today()
                    .date()
                    .replace(day=1)
                )

        else:

            monthly_anchor = (
                datetime.today()
                .date()
                .replace(day=1)
            )


        monthly_months = [

            add_months(
                monthly_anchor,
                -2
            ),

            add_months(
                monthly_anchor,
                -1
            ),

            monthly_anchor

        ]

        previous_month = add_months(
            monthly_anchor,
            -3
        )

        next_month = add_months(
            monthly_anchor,
            3
        )


        # =====================================================
        # 13. MONTHLY ATTENDANCE STRUCTURE
        #
        # Initialise all clusters and all three months first.
        # Therefore months appear even when there is no data.
        # =====================================================

        monthly_cluster_rows = {}

        for cluster in cluster_rows:

            cluster_id = cluster["cluster_id"]

            monthly_cluster_rows[cluster_id] = {

                "cluster_id": cluster_id,

                "cluster_name":
                    cluster["cluster_name"],

                "months": {}

            }

            for month in monthly_months:

                monthly_cluster_rows[
                    cluster_id
                ]["months"][
                    month
                ] = {

                    "attendance": None,

                    "performance": None

                }


        # =====================================================
        # 14. MONTHLY ATTENDANCE
        #
        # Only WORKING attendance submissions count.
        #
        # Performance remains None until a verified
        # performance source is established.
        # =====================================================

        monthly_start = monthly_months[0]

        monthly_end = add_months(
            monthly_months[-1],
            1
        )

        cur.execute("""
            SELECT
                c.cluster_id,

                DATE_TRUNC(
                    'month',
                    ats.attendance_date
                )::date AS month_start,

                COUNT(sa.attendance_id) FILTER (
                    WHERE sa.attendance_status = 'PRESENT'
                ) AS present,

                COUNT(sa.attendance_id) FILTER (
                    WHERE sa.attendance_status = 'ABSENT'
                ) AS absent

            FROM cluster_master c

            JOIN cluster_center cc
                ON cc.cluster_id = c.cluster_id
               AND cc.academic_year_id = 3
               AND cc.active_flag = TRUE

            JOIN attendance_submission ats
                ON ats.center_id = cc.center_id
               AND ats.attendance_date >= %s
               AND ats.attendance_date < %s
               AND ats.day_status = 'WORKING'

            JOIN student_attendance sa
                ON sa.submission_id = ats.submission_id

            WHERE c.segment_id = %s
              AND c.active_flag = TRUE

            GROUP BY
                c.cluster_id,
                DATE_TRUNC(
                    'month',
                    ats.attendance_date
                )::date

            ORDER BY
                c.cluster_id,
                month_start

        """, (
            monthly_start,
            monthly_end,
            segment_id
        ))

        monthly_attendance_rows = cur.fetchall()


        # =====================================================
        # 15. FILL MONTHLY ATTENDANCE
        # =====================================================

        for row in monthly_attendance_rows:

            cluster_id = row["cluster_id"]
            month_start = row["month_start"]

            present = row["present"] or 0
            absent = row["absent"] or 0

            total = present + absent

            if total > 0:

                percentage = round(
                    (present / total) * 100,
                    1
                )

                if cluster_id in monthly_cluster_rows:

                    if month_start in monthly_cluster_rows[
                        cluster_id
                    ]["months"]:

                        monthly_cluster_rows[
                            cluster_id
                        ]["months"][
                            month_start
                        ]["attendance"] = percentage


        monthly_cluster_attendance = list(
            monthly_cluster_rows.values()
        )


        # =====================================================
        # 16. PREPARE SEGMENT SUMMARY
        # =====================================================

        segment = {

            "id":
                segment_row["segment_id"],

            "name":
                segment_row["segment_name"],

            "clusters":
                len(cluster_rows),

            "centres":
                sum(
                    row["centres"]
                    for row in cluster_rows
                ),

            "students":
                sum(
                    row["students"]
                    for row in cluster_rows
                ),

            "attendance":
                segment_attendance

        }


        # =====================================================
        # 17. PREPARE CLUSTER DATA FOR TEMPLATE
        # =====================================================

        clusters = []

        for row in cluster_rows:

            clusters.append({

                "id":
                    row["cluster_id"],

                "name":
                    row["cluster_name"],

                "centres":
                    row["centres"],

                "students":
                    row["students"],

                "attendance":
                    row["attendance"],

                "attendance_value":
                    row["attendance_value"],

                "present":
                    row["present"],

                "absent":
                    row["absent"],

                "status":
                    row["status"],

                "status_class":
                    row["status_class"],

                "cc_id":
                    row["cc_id"]

            })

        # ---------------------------------------------------------
        # Attendance date
        # ---------------------------------------------------------

        attendance_date = datetime.today().date()

        # =====================================================
        # 18. RENDER SEGMENT DASHBOARD
        # =====================================================

        return render_template(

            "segment/segment_dashboard.html",

            segment=segment,

            clusters=clusters,

            attendance_date=attendance_date,

            weekly_cluster_attendance=
                weekly_cluster_attendance,

            week_days=
                week_days,

            week_start=
                week_start,

            week_end=
                week_end,

            previous_week=
                previous_week,

            next_week=
                next_week,

            monthly_cluster_attendance=
                monthly_cluster_attendance,

            monthly_months=
                monthly_months,

            monthly_anchor=
                monthly_anchor,

            previous_month=
                previous_month,

            next_month=
                next_month,

            active_page="segment"

        )

    finally:

        cur.close()
        conn.close()


@app.route("/operations-dashboard")
@login_required
@permission_required("VIEW_DASHBOARD")
def operations_dashboard():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:
        # Current academic year
        cur.execute("""
            SELECT academic_year_id
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)
        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # Operations Dashboard summary
        cur.execute("""
            SELECT
                (SELECT COUNT(*)
                 FROM tuition_center
                 WHERE status IN ('ACTIVE', 'INACTIVE')) AS total_avlcs,

                (SELECT COUNT(*)
                 FROM tuition_center
                 WHERE status = 'INACTIVE') AS inactive_avlcs,

                COUNT(*) AS total_enrolments,

                COUNT(*) FILTER (
                    WHERE sm.active_flag = FALSE
                ) AS inactive_enrolments,

                COUNT(*) FILTER (
                    WHERE sm.gender = 'Boy'
                ) AS boys,

                COUNT(*) FILTER (
                    WHERE sm.gender = 'Girl'
                ) AS girls

            FROM student_center_assignment sca

            JOIN tuition_center tc
                ON tc.center_id = sca.center_id
               AND tc.status = 'ACTIVE'

            JOIN student_master sm
                ON sm.student_id = sca.student_id

            JOIN student_academic_year say
                ON say.student_id = sca.student_id
               AND say.academic_year_id = sca.academic_year_id

            WHERE sca.academic_year_id = %s
              AND sca.active_flag = TRUE
              AND say.status = 'ACTIVE'
        """, (academic_year_id,))

        summary = cur.fetchone()

        total_enrolments = summary["total_enrolments"] or 0
        boys = summary["boys"] or 0
        girls = summary["girls"] or 0

        summary["boys_percentage"] = (
            round((boys / total_enrolments) * 100, 1)
            if total_enrolments else 0
        )

        summary["girls_percentage"] = (
            round((girls / total_enrolments) * 100, 1)
            if total_enrolments else 0
        )

        return render_template(
            "operations/operations_dashboard.html",
            active_page="dashboard",
            summary=summary,
            academic_year_id=academic_year_id,
            dashboard_date=datetime.today()
        )
    finally:
        cur.close()
        conn.close()


# ============================================================
# AVLC DASHBOARD
# Operations Head - Organisation-wide AVLC / Segment View
# ============================================================

@app.route("/avlc-dashboard")
@login_required
@permission_required("VIEW_DASHBOARD")
def avlc_dashboard():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:

        # --------------------------------------------------------
        # Current academic year
        # --------------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]


        # --------------------------------------------------------
        # Active Segments
        # --------------------------------------------------------
        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE active_flag = TRUE
            ORDER BY segment_id
        """)

        segments = cur.fetchall()


        # --------------------------------------------------------
        # Selected Segment
        #
        # The dropdown will pass:
        # /avlc-dashboard?segment=2
        #
        # If nothing is selected, select the first active segment.
        # --------------------------------------------------------
        requested_segment = request.args.get(
            "segment",
            type=int
        )

        selected_segment = None

        if requested_segment:

            for segment in segments:

                if segment["segment_id"] == requested_segment:
                    selected_segment = segment
                    break

        if selected_segment is None and segments:
            selected_segment = segments[0]

                    # --------------------------------------------------------
        # Selected Segment Profile
        # --------------------------------------------------------
        selected_segment_profile = None

        if selected_segment:

            selected_segment_id = selected_segment["segment_id"]

            # Segment Incharge
            cur.execute("""
                SELECT
                    u.full_name AS segment_incharge
                FROM user_access ua

                JOIN aems_user u
                    ON u.user_id = ua.user_id

                JOIN user_role ur
                    ON ur.user_id = u.user_id
                   AND ur.active_flag = TRUE

                JOIN role_master rm
                    ON rm.role_id = ur.role_id
                   AND rm.role_code = 'SEGMENT_INCHARGE'
                   AND rm.active_flag = TRUE

                WHERE ua.segment_id = %s
                  AND ua.access_scope = 'SEGMENT'
                  AND ua.active_flag = TRUE
                  AND ua.assigned_from <= CURRENT_DATE
                  AND (
                      ua.assigned_to IS NULL
                      OR ua.assigned_to >= CURRENT_DATE
                  )

                ORDER BY ua.assigned_from DESC

                LIMIT 1
            """, (selected_segment_id,))

            incharge_row = cur.fetchone()


                        # Segment structure and enrolment
            cur.execute("""
                SELECT

                    COUNT(DISTINCT cm.cluster_id)
                        AS cluster_count,

                    COUNT(DISTINCT sca.student_id)
                        AS total_enrolments,

                    COUNT(DISTINCT sca.student_id)
                        FILTER (
                            WHERE sm.active_flag = FALSE
                        )
                        AS inactive_enrolments,

                    COUNT(DISTINCT sca.student_id)
                        FILTER (
                            WHERE sm.gender = 'Boy'
                        )
                        AS boys,

                    COUNT(DISTINCT sca.student_id)
                        FILTER (
                            WHERE sm.gender = 'Girl'
                        )
                        AS girls

                FROM cluster_master cm

                LEFT JOIN cluster_center cc
                    ON cc.cluster_id = cm.cluster_id
                   AND cc.academic_year_id = %s
                   AND cc.active_flag = TRUE

                LEFT JOIN tuition_center tc
                    ON tc.center_id = cc.center_id
                   AND tc.status = 'ACTIVE'

                LEFT JOIN student_center_assignment sca
                    ON sca.center_id = cc.center_id
                   AND sca.academic_year_id = %s
                   AND sca.active_flag = TRUE

                LEFT JOIN student_master sm
                    ON sm.student_id = sca.student_id

                LEFT JOIN student_academic_year say
                    ON say.student_id = sca.student_id
                   AND say.academic_year_id = %s
                   AND say.status = 'ACTIVE'

                WHERE cm.segment_id = %s
                  AND cm.active_flag = TRUE

                  AND (
                      sca.student_id IS NULL
                      OR say.student_id IS NOT NULL
                  )
            """, (
                academic_year_id,
                academic_year_id,
                academic_year_id,
                selected_segment_id
            ))

            profile_row = cur.fetchone()


            selected_segment_profile = {
                "segment_name":
                    selected_segment["segment_name"],

                "segment_incharge":
                    (
                        incharge_row["segment_incharge"]
                        if incharge_row
                        else None
                    ),

                "clusters":
                    profile_row["cluster_count"] or 0,

                "total_enrolments":
                    profile_row["total_enrolments"] or 0,

                "inactive_enrolments":
                    profile_row["inactive_enrolments"] or 0,

                    "boys":
                        profile_row["boys"] or 0,

                    "girls":
                        profile_row["girls"] or 0,

                    "boys_percentage": (
                        round(
                            (profile_row["boys"] or 0)
                            / profile_row["total_enrolments"]
                            * 100,
                            1
                        )
                        if profile_row["total_enrolments"]
                        else 0
                    ),

                    "girls_percentage": (
                        round(
                            (profile_row["girls"] or 0)
                            / profile_row["total_enrolments"]
                            * 100,
                            1
                        )
                        if profile_row["total_enrolments"]
                        else 0
                    )


            }


        # --------------------------------------------------------
        # Weekly period
        #
        # Same navigation principle as the existing
        # Cluster / Segment Dashboard.
        # Monday to Saturday.
        # --------------------------------------------------------
        requested_week = request.args.get("week")

        if requested_week:

            try:

                week_start = datetime.strptime(
                    requested_week,
                    "%Y-%m-%d"
                ).date()

            except ValueError:

                week_start = (
                    datetime.today().date()
                    - timedelta(
                        days=datetime.today().date().weekday()
                    )
                )

        else:

            week_start = (
                datetime.today().date()
                - timedelta(
                    days=datetime.today().date().weekday()
                )
            )


        week_days = [
            week_start + timedelta(days=i)
            for i in range(6)
        ]

        week_end = week_days[-1]

        previous_week = week_start - timedelta(days=7)
        next_week = week_start + timedelta(days=7)


        # --------------------------------------------------------
        # Weekly attendance
        #
        # One row per Segment.
        #
        # Segment
        #   ↓
        # Clusters
        #   ↓
        # AVLCs
        #   ↓
        # Attendance submissions
        #   ↓
        # Student attendance
        # --------------------------------------------------------
        weekly_rows = {}

        for segment in segments:

            weekly_rows[segment["segment_id"]] = {

                "segment_id":
                    segment["segment_id"],

                "segment_name":
                    segment["segment_name"],

                "days": {},

                "week_present": 0,

                "week_absent": 0,

                "week_total": 0,

                "week_percentage": None
            }

            for day in week_days:

                weekly_rows[
                    segment["segment_id"]
                ]["days"][day] = None


        # --------------------------------------------------------
        # Fetch attendance for selected week
        # --------------------------------------------------------
        cur.execute("""
            SELECT

                sm.segment_id,

                sa.attendance_date,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'PRESENT'
                ) AS present,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'ABSENT'
                ) AS absent

            FROM student_attendance sa

            JOIN attendance_submission ats
                ON ats.submission_id = sa.submission_id

            JOIN cluster_center cc
                ON cc.center_id = ats.center_id
               AND cc.academic_year_id = %s
               AND cc.active_flag = TRUE

            JOIN cluster_master cm
                ON cm.cluster_id = cc.cluster_id
               AND cm.active_flag = TRUE

            JOIN segment_master sm
                ON sm.segment_id = cm.segment_id
               AND sm.active_flag = TRUE

            WHERE sa.attendance_date >= %s
              AND sa.attendance_date <= %s

            GROUP BY
                sm.segment_id,
                sa.attendance_date

            ORDER BY
                sm.segment_id,
                sa.attendance_date

        """, (
            academic_year_id,
            week_start,
            week_end
        ))

        attendance_rows = cur.fetchall()


        # --------------------------------------------------------
        # Calculate daily and weekly percentages
        # --------------------------------------------------------
        for row in attendance_rows:

            segment_id = row["segment_id"]

            attendance_date = row["attendance_date"]

            present = row["present"] or 0

            absent = row["absent"] or 0

            total = present + absent


            if segment_id not in weekly_rows:
                continue


            if total > 0:

                daily_percentage = round(
                    (present / total) * 100,
                    1
                )

            else:

                daily_percentage = None


            weekly_rows[
                segment_id
            ]["days"][attendance_date] = (
                daily_percentage
            )

            weekly_rows[
                segment_id
            ]["week_present"] += present

            weekly_rows[
                segment_id
            ]["week_absent"] += absent

            weekly_rows[
                segment_id
            ]["week_total"] += total


        # --------------------------------------------------------
        # Final weekly percentage
        # --------------------------------------------------------
        for segment in weekly_rows.values():

            if segment["week_total"] > 0:

                segment["week_percentage"] = round(
                    (
                        segment["week_present"]
                        / segment["week_total"]
                    ) * 100,
                    1
                )

            else:

                segment["week_percentage"] = None


        weekly_segment_attendance = list(
            weekly_rows.values()
        )

        # --------------------------------------------------------
        # Monthly Attendance & Performance
        # Three-month rolling view
        # --------------------------------------------------------

        requested_month = request.args.get("month")

        if requested_month:

            try:
                monthly_anchor = datetime.strptime(
                    requested_month,
                    "%Y-%m"
                ).date().replace(day=1)

            except ValueError:

                monthly_anchor = (
                    datetime.today()
                    .date()
                    .replace(day=1)
                )

        else:

            monthly_anchor = (
                datetime.today()
                .date()
                .replace(day=1)
            )


        # --------------------------------------------------------
        # Helper: move a date by N months
        # --------------------------------------------------------

        def add_months(source_date, months):

            month_index = (
                source_date.year * 12
                + source_date.month
                - 1
                + months
            )

            year = month_index // 12

            month = month_index % 12 + 1

            return source_date.replace(
                year=year,
                month=month,
                day=1
            )


        # --------------------------------------------------------
        # Three displayed months
        # --------------------------------------------------------

        monthly_months = [
            add_months(monthly_anchor, -2),
            add_months(monthly_anchor, -1),
            monthly_anchor
        ]


        monthly_start = monthly_months[0]

        monthly_end = (
            add_months(monthly_anchor, 1)
            - timedelta(days=1)
        )


        previous_month_window = add_months(
            monthly_anchor,
            -3
        )

        next_month_window = add_months(
            monthly_anchor,
            3
        )


        # --------------------------------------------------------
        # Create monthly structure for every segment
        # --------------------------------------------------------

        monthly_rows = {}

        for segment in segments:

            monthly_rows[
                segment["segment_id"]
            ] = {

                "segment_id":
                    segment["segment_id"],

                "segment_name":
                    segment["segment_name"],

                "months": {}

            }

            for month in monthly_months:

                month_key = month.strftime("%Y-%m")

                monthly_rows[
                    segment["segment_id"]
                ]["months"][month_key] = {

                    "month": month,

                    "attendance": None,

                    "performance": None

                }


        # --------------------------------------------------------
        # Monthly attendance
        #
        # Only WORKING days are included.
        # Attendance = Present / (Present + Absent)
        # --------------------------------------------------------

        cur.execute("""
            SELECT

                cm.segment_id,

                DATE_TRUNC(
                    'month',
                    ats.attendance_date
                )::date AS month_start,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'PRESENT'
                ) AS present,

                COUNT(*) FILTER (
                    WHERE sa.attendance_status = 'ABSENT'
                ) AS absent

            FROM student_attendance sa

            JOIN attendance_submission ats
                ON ats.submission_id = sa.submission_id

            JOIN cluster_center cc
                ON cc.center_id = ats.center_id
               AND cc.academic_year_id = %s
               AND cc.active_flag = TRUE

            JOIN cluster_master cm
                ON cm.cluster_id = cc.cluster_id
               AND cm.active_flag = TRUE

            WHERE ats.attendance_date >= %s
              AND ats.attendance_date <= %s

              AND ats.day_status = 'WORKING'

            GROUP BY

                cm.segment_id,

                DATE_TRUNC(
                    'month',
                    ats.attendance_date
                )::date

            ORDER BY
                cm.segment_id,
                month_start

        """, (
            academic_year_id,
            monthly_start,
            monthly_end
        ))


        monthly_attendance_rows = cur.fetchall()


        # --------------------------------------------------------
        # Put attendance into monthly structure
        # --------------------------------------------------------

        for row in monthly_attendance_rows:

            segment_id = row["segment_id"]

            month_start = row["month_start"]

            month_key = month_start.strftime("%Y-%m")

            present = row["present"] or 0

            absent = row["absent"] or 0

            recorded = present + absent


            if (
                segment_id in monthly_rows
                and month_key in
                    monthly_rows[
                        segment_id
                    ]["months"]
            ):

                if recorded > 0:

                    monthly_rows[
                        segment_id
                    ]["months"][
                        month_key
                    ]["attendance"] = round(
                        (
                            present
                            / recorded
                        ) * 100,
                        1
                    )


        # --------------------------------------------------------
        # Performance
        #
        # Performance data is not being calculated yet.
        # It remains None until assessment data is available.
        # --------------------------------------------------------

        monthly_segment_data = list(
            monthly_rows.values()
        )


        # --------------------------------------------------------
        # Render AVLC Dashboard
        #
        # Monthly attendance/performance will be added next.
        # --------------------------------------------------------

        return render_template(
            "operations/avlc_dashboard.html",

            segments=segments,

            selected_segment=selected_segment,

            selected_segment_profile=selected_segment_profile,

            weekly_segment_attendance=(
                weekly_segment_attendance
            ),

            week_days=week_days,

            week_start=week_start,

            week_end=week_end,

            previous_week=previous_week,

            next_week=next_week,

            # ---------------------------------------------
            # Monthly Attendance & Performance
            # ---------------------------------------------

            monthly_segment_data=(
                monthly_segment_data
            ),

            monthly_months=monthly_months,

            monthly_start=monthly_start,

            monthly_end=monthly_end,

            previous_month_window=(
                previous_month_window
            ),

            next_month_window=(
                next_month_window
            ),

            academic_year=academic_year,

            active_page="avlc"
        )
    finally:

        cur.close()
        conn.close()


@app.route("/students/<int:centre_id>")
@login_required
@permission_required("VIEW_STUDENTS")
def centre_students(centre_id):

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    # ---------------------------------------------------------
    # Get centre details
    # ---------------------------------------------------------
    cur.execute("""
        SELECT
            center_id,
            center_code,
            center_name
        FROM tuition_center
        WHERE center_id = %s
    """, (centre_id,))

    centre = cur.fetchone()

    if not centre:
        cur.close()
        conn.close()
        return redirect("/dashboard")

    # ---------------------------------------------------------
    # Get students for this centre and academic year
    #
    # Group A / Group B is the primary AVF classification.
    # Class remains available as secondary student information.
    # ---------------------------------------------------------
    cur.execute("""
        SELECT
            sm.student_id,
            sm.student_code,
            sm.student_name,
            sm.gender,
            sm.mobile_no,
            sm.active_flag,

            say.class_studying,
            say.status,
            say.schooling_status,
            say.school_type,
            say.medium,

            cgm.group_id,
            cgm.group_code,
            cgm.group_name


        FROM student_center_assignment sca

        JOIN student_master sm
            ON sm.student_id = sca.student_id

        JOIN student_academic_year say
            ON say.student_id = sm.student_id
           AND say.academic_year_id = %s

        LEFT JOIN curriculum_group_master cgm
            ON cgm.group_id = say.group_id

        WHERE sca.center_id = %s
          AND sca.academic_year_id = %s
          AND sca.active_flag = TRUE
          AND say.status = 'ACTIVE'

        ORDER BY
            cgm.group_code,
            say.class_studying NULLS LAST,
            sm.student_name
    """, (3, centre_id, 3))

    students = cur.fetchall()

    # ---------------------------------------------------------
    # Enrollment statistics
    # ---------------------------------------------------------

    total_enrollments = len(students)

    inactive_students = [
        student
        for student in students
        if student["active_flag"] is False
    ]

    inactive_count = len(inactive_students)

    # ---------------------------------------------------------
    # Group students by AVF curriculum group
    # ---------------------------------------------------------
    students_by_group = {
        "A": [],
        "B": []
    }

    for student in students:
        group_code = student["group_code"]

        if group_code in students_by_group:
            students_by_group[group_code].append(student)

    # ---------------------------------------------------------
    # Group statistics
    # ---------------------------------------------------------
    group_stats = {}

    for group_code in ["A", "B"]:

        group_students = students_by_group[group_code]

        boys = sum(
            1
            for student in group_students
            if str(student["gender"]).strip().upper() == "BOY"
        )

        girls = sum(
            1
            for student in group_students
            if str(student["gender"]).strip().upper() == "GIRL"
        )

        group_stats[group_code] = {
            "total": len(group_students),
            "boys": boys,
            "girls": girls
        }

    # ---------------------------------------------------------
    # Total student statistics
    # ---------------------------------------------------------
    total_students = len(students)

    total_boys = sum(
        1
        for student in students
        if str(student["gender"]).strip().upper() == "BOY"
    )

    total_girls = sum(
        1
        for student in students
        if str(student["gender"]).strip().upper() == "GIRL"
    )

    total_stats = {
        "total": total_students,
        "boys": total_boys,
        "girls": total_girls
    }

    # ---------------------------------------------------------
    # Class-wise distribution
    #
    # Class is secondary information.
    # Core AVF cards continue to show Classes 1–6.
    # ---------------------------------------------------------
    students_by_class = {}

    for student in students:

        class_no = student["class_studying"]

        if class_no not in students_by_class:
            students_by_class[class_no] = []

        students_by_class[class_no].append(student)

        # ---------------------------------------------------------
    # Class-wise distribution
    #
    # Lower Class  : -2, -1, 0
    # Classes      : 1 to 6
    # Higher Class : 7 to 10
    # NS students have no class and are not included here.
    # ---------------------------------------------------------

    class_stats = {}

    # Lower Class (-2, -1, 0)
    lower_class_students = [
        student
        for student in students
        if student["class_studying"] in (-2, -1, 0)
    ]

    class_stats["lower"] = {
        "total": len(lower_class_students),
        "boys": sum(
            1 for student in lower_class_students
            if str(student["gender"]).strip().upper() == "BOY"
        ),
        "girls": sum(
            1 for student in lower_class_students
            if str(student["gender"]).strip().upper() == "GIRL"
        )
    }

    # Classes 1 to 6
    for class_no in range(1, 7):

        class_students = students_by_class.get(class_no, [])

        class_stats[class_no] = {
            "total": len(class_students),
            "boys": sum(
                1 for student in class_students
                if str(student["gender"]).strip().upper() == "BOY"
            ),
            "girls": sum(
                1 for student in class_students
                if str(student["gender"]).strip().upper() == "GIRL"
            )
        }

    # Higher Class (7 to 10)
    higher_class_students = [
        student
        for student in students
        if student["class_studying"] in (7, 8, 9, 10)
    ]

    class_stats["higher"] = {
        "total": len(higher_class_students),
        "boys": sum(
            1 for student in higher_class_students
            if str(student["gender"]).strip().upper() == "BOY"
        ),
        "girls": sum(
            1 for student in higher_class_students
            if str(student["gender"]).strip().upper() == "GIRL"
        )
    }
    cur.close()
    conn.close()

    return render_template(
    "students/centre_students.html",
    centre=centre,
    students=students,
    students_by_group=students_by_group,
    group_stats=group_stats,
    total_stats=total_stats,
    students_by_class=students_by_class,
    class_stats=class_stats,
    total_enrollments=total_enrollments,
    inactive_students=inactive_students,
    inactive_count=inactive_count
)
# ============================================================
# CENTRE ATTENDANCE
# ============================================================

@app.route("/attendance/<int:centre_id>")
@login_required
def centre_attendance(centre_id):

    role = session.get("role")
    user_id = session.get("user_id")

    db = get_connection()

    try:
        with db.cursor(cursor_factory=RealDictCursor) as cur:

            # ====================================================
            # 1. CENTRE DETAILS
            # ====================================================

            cur.execute("""
                SELECT
                    tc.center_id,
                    tc.center_code,
                    tc.center_name
                FROM public.tuition_center tc
                WHERE tc.center_id = %s
                  AND tc.status = 'ACTIVE'
            """, (centre_id,))

            centre = cur.fetchone()

            if not centre:
                return redirect("/dashboard")


            # ====================================================
            # 2. VERIFY USER ACCESS TO THIS CENTRE
            # ====================================================

            if role == "tutor":

                cur.execute("""
                    SELECT 1
                    FROM public.user_person_assignment upa

                    JOIN public.tutor_centre_assignment tca
                        ON tca.tutor_id = upa.tutor_id
                       AND tca.active_flag = TRUE

                    WHERE upa.user_id = %s
                      AND upa.active_flag = TRUE
                      AND tca.center_id = %s
                      AND tca.academic_year_id = 3
                """, (
                    user_id,
                    centre_id
                ))

                if not cur.fetchone():
                    return redirect("/dashboard")


            elif role == "cluster_incharge":

                cur.execute("""
                    SELECT 1
                    FROM public.user_person_assignment upa

                    JOIN public.cluster_coordinator_assignment cca
                        ON cca.cc_id = upa.cc_id
                       AND cca.active_flag = TRUE

                    JOIN public.cluster_center cc
                        ON cc.cluster_id = cca.cluster_id
                       AND cc.active_flag = TRUE
                       AND cc.academic_year_id = 3

                    WHERE upa.user_id = %s
                      AND upa.active_flag = TRUE
                      AND cca.academic_year_id = 3
                      AND cc.center_id = %s
                """, (
                    user_id,
                    centre_id
                ))

                if not cur.fetchone():
                    return redirect("/dashboard")


            # ====================================================
            # 3. CURRENT TUTOR
            # ====================================================

            cur.execute("""
                SELECT
                    tm.tutor_id,
                    tm.tutor_name
                FROM public.tutor_centre_assignment tca

                JOIN public.tutor_master tm
                    ON tm.tutor_id = tca.tutor_id

                WHERE tca.center_id = %s
                  AND tca.academic_year_id = 3
                  AND tca.active_flag = TRUE
                  AND tm.active_flag = TRUE
            """, (centre_id,))

            tutor = cur.fetchone()


            # ====================================================
            # 4. SELECTED WEEK
            #
            # Week is Monday to Saturday.
            #
            # Example:
            # /attendance/26?week=2026-09-14
            # ====================================================

            week_param = request.args.get("week")

            if week_param:
                try:
                    week_start = datetime.strptime(
                        week_param,
                        "%Y-%m-%d"
                    ).date()

                except ValueError:
                    today = datetime.today().date()
                    week_start = today - timedelta(
                        days=today.weekday()
                    )
            else:
                today = datetime.today().date()

                # Monday of current week
                week_start = today - timedelta(
                    days=today.weekday()
                )


            # Ensure week_start is Monday
            week_start = week_start - timedelta(
                days=week_start.weekday()
            )

            # AVF attendance week = Monday to Saturday
            week_end = week_start + timedelta(days=5)

            previous_week = week_start - timedelta(days=7)
            next_week = week_start + timedelta(days=7)

            week_days = [
                week_start + timedelta(days=i)
                for i in range(6)
            ]


            # ====================================================
            # 5. SELECTED GROUP
            #
            # No group = show Group A / Group B cards.
            # A or B = show weekly attendance for that group.
            # ====================================================

            selected_group = request.args.get("group")

            if selected_group not in ("A", "B"):
                selected_group = None


            # ====================================================
            # 6. CURRENT STUDENTS
            # ====================================================

            cur.execute("""
                SELECT
                    sm.student_id,
                    sm.student_code,
                    sm.student_name,
                    sm.gender,
                    say.class_studying,
                    cgm.group_code
                FROM public.student_center_assignment sca

                JOIN public.student_master sm
                    ON sm.student_id = sca.student_id

                JOIN public.student_academic_year say
                    ON say.student_id = sm.student_id
                   AND say.academic_year_id = sca.academic_year_id

                LEFT JOIN public.curriculum_group_master cgm
                    ON cgm.group_id = say.group_id

                WHERE sca.center_id = %s
                  AND sca.academic_year_id = 3
                  AND sca.active_flag = TRUE
                  AND sm.active_flag = TRUE
                  AND say.status = 'ACTIVE'

                ORDER BY
                    cgm.group_code,
                    say.class_studying NULLS FIRST,
                    sm.student_name
            """, (centre_id,))

            students = cur.fetchall()


            # ====================================================
            # 7. GROUP COUNTS
            #
            # Keep this deliberately simple.
            # Tutor only needs to know how many students
            # are in each group.
            # ====================================================

            group_counts = {
                "A": 0,
                "B": 0
            }

            for student in students:
                group_code = student["group_code"]

                if group_code in group_counts:
                    group_counts[group_code] += 1


            # ====================================================
            # 8. WEEKLY ATTENDANCE RECORDS
            #
            # Retrieve attendance only for the selected week.
            # ====================================================

            cur.execute("""
                SELECT
                    sa.student_id,
                    ats.attendance_date,
                    sa.attendance_status

                FROM public.student_attendance sa

                JOIN public.attendance_submission ats
                    ON ats.submission_id = sa.submission_id

                WHERE ats.center_id = %s
                  AND ats.attendance_date >= %s
                  AND ats.attendance_date <= %s

                ORDER BY
                    ats.attendance_date,
                    sa.student_id
            """, (
                centre_id,
                week_start,
                week_end
            ))

            attendance_rows = cur.fetchall()


            # ====================================================
            # 9. CREATE QUICK ATTENDANCE LOOKUP
            #
            # Key = (student_id, attendance_date)
            # Value = PRESENT / ABSENT
            # ====================================================

            attendance_lookup = {}

            for row in attendance_rows:

                attendance_lookup[
                    (
                        row["student_id"],
                        row["attendance_date"]
                    )
                ] = row["attendance_status"]


            # ====================================================
            # 10. BUILD WEEKLY ATTENDANCE FOR EACH STUDENT
            # ====================================================

            weekly_students = []

            for student in students:

                if selected_group:
                    if student["group_code"] != selected_group:
                        continue

                daily_attendance = []

                present_days = 0
                absent_days = 0

                for day in week_days:

                    status = attendance_lookup.get(
                        (
                            student["student_id"],
                            day
                        )
                    )

                    if status == "PRESENT":
                        symbol = "P"
                        present_days += 1

                    elif status == "ABSENT":
                        symbol = "A"
                        absent_days += 1

                    else:
                        symbol = "-"

                    daily_attendance.append({
                        "date": day,
                        "status": status,
                        "symbol": symbol
                    })


                # Attendance percentage:
                #
                # Present / (Present + Absent) * 100
                #
                # Days with no attendance captured are
                # deliberately excluded.

                recorded_days = present_days + absent_days

                if recorded_days > 0:
                    percentage = round(
                        (present_days / recorded_days) * 100,
                        1
                    )
                else:
                    percentage = None


                student["weekly_attendance"] = daily_attendance
                student["present_days"] = present_days
                student["absent_days"] = absent_days
                student["attendance_percentage"] = percentage

                weekly_students.append(student)


            # ====================================================
            # 11. LATEST ATTENDANCE DATE IN SELECTED WEEK
            # ====================================================

            cur.execute("""
                SELECT
                    MAX(attendance_date) AS latest_date
                FROM public.attendance_submission
                WHERE center_id = %s
                  AND attendance_date >= %s
                  AND attendance_date <= %s
            """, (
                centre_id,
                week_start,
                week_end
            ))

            latest_result = cur.fetchone()

            latest_attendance_date = None

            if latest_result:
                latest_attendance_date = latest_result["latest_date"]


            # ====================================================
            # 12. DISPLAY NAME
            # ====================================================

            centre_display_name = (
                centre["center_name"]
                if centre["center_name"]
                and str(centre["center_name"]).strip()
                else centre["center_code"]
            )


            # ====================================================
            # 13. RENDER
            # ====================================================

            return render_template(
                "attendance/centre_attendance.html",

                centre=centre,
                centre_display_name=centre_display_name,
                tutor=tutor,

                week_start=week_start,
                week_end=week_end,
                week_days=week_days,

                previous_week=previous_week,
                next_week=next_week,

                selected_group=selected_group,

                group_counts=group_counts,

                students=students,
                weekly_students=weekly_students,

                latest_attendance_date=latest_attendance_date,
                active_page="attendance"
            )
    except Exception as e:

        print("Centre attendance page error:", e)

        return redirect("/dashboard")

    finally:

        db.close()

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


# ============================================================
# MANAGE - STUDENTS
# ============================================================

@app.route("/manage/students")
@login_required
@permission_required("MANAGE_STUDENTS")
def manage_students():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:
        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # Filters
        # ----------------------------------------------------
        search = request.args.get("search", "").strip()
        class_filter = request.args.get("class", "").strip()
        status_filter = request.args.get("status", "ACTIVE").strip()
        centre_filter = request.args.get("centre", "").strip()

        # ----------------------------------------------------
        # Summary
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                COUNT(*) AS enrolments,

                COUNT(*) FILTER (
                    WHERE sm.active_flag = FALSE
                ) AS inactive

            FROM student_master sm

            JOIN student_academic_year say
                ON say.student_id = sm.student_id
               AND say.academic_year_id = %s
        """, (academic_year_id,))

        summary = cur.fetchone()

        # ----------------------------------------------------
        # AVLC list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                center_id,
                center_code,
                center_name
            FROM tuition_center
            WHERE status = 'ACTIVE'
            ORDER BY center_code
        """)

        centres = cur.fetchall()

        # ----------------------------------------------------
        # Student list
        #
        # Current assignment only:
        # active_flag = TRUE
        #
        # Historical assignments are not overwritten.
        # ----------------------------------------------------
        query = """
            SELECT
                sm.student_id,
                sm.student_code,
                sm.student_name,
                sm.father_name,
                sm.mother_name,
                sm.mobile_no,
                sm.date_of_birth,
                sm.joining_date,
                sm.active_flag,

                say.class_studying,
                say.status AS academic_status,

                cgm.group_code,
                cgm.group_name,

                tc.center_id,
                tc.center_code,
                tc.center_name

            FROM student_master sm

            JOIN student_academic_year say
                ON say.student_id = sm.student_id
               AND say.academic_year_id = %s

            LEFT JOIN curriculum_group_master cgm
                ON cgm.group_id = say.group_id

            LEFT JOIN student_center_assignment sca
                ON sca.student_id = sm.student_id
               AND sca.academic_year_id = %s
               AND sca.active_flag = TRUE

            LEFT JOIN tuition_center tc
                ON tc.center_id = sca.center_id

            WHERE 1 = 1
        """

        params = [
            academic_year_id,
            academic_year_id
        ]

        # ----------------------------------------------------
        # Search
        # ----------------------------------------------------
        if search:
            query += """
                AND (
                    sm.student_code ILIKE %s
                    OR sm.student_name ILIKE %s
                    OR COALESCE(sm.mobile_no, '') ILIKE %s
                )
            """

            search_value = f"%{search}%"

            params.extend([
                search_value,
                search_value,
                search_value
            ])

        # ----------------------------------------------------
        # Class filter
        # ----------------------------------------------------
        if class_filter:
            query += """
                AND CAST(say.class_studying AS TEXT) = %s
            """
            params.append(class_filter)

        # ----------------------------------------------------
        # Status filter
        # ----------------------------------------------------
        if status_filter == "ACTIVE":
            query += """
                AND sm.active_flag = TRUE
            """

        elif status_filter == "INACTIVE":
            query += """
                AND sm.active_flag = FALSE
            """

        # ----------------------------------------------------
        # AVLC filter
        # ----------------------------------------------------
        if centre_filter:
            query += """
                AND tc.center_id = %s
            """
            params.append(centre_filter)

        query += """
            ORDER BY
                sm.student_name
        """

        cur.execute(query, tuple(params))

        students = cur.fetchall()

        # ----------------------------------------------------
        # Distinct class list for filter
        # ----------------------------------------------------
        cur.execute("""
            SELECT DISTINCT
                say.class_studying
            FROM student_academic_year say
            WHERE say.academic_year_id = %s
              AND say.class_studying IS NOT NULL
            ORDER BY say.class_studying
        """, (academic_year_id,))

        classes = [
            row["class_studying"]
            for row in cur.fetchall()
        ]

        return render_template(
            "manage/students.html",
            students=students,
            centres=centres,
            classes=classes,
            summary=summary,
            academic_year=academic_year,
            search=search,
            class_filter=class_filter,
            status_filter=status_filter,
            centre_filter=centre_filter,
            active_page="manage"
        )

    finally:
        cur.close()
        conn.close()


# ============================================================
# MANAGE - ADD TUTOR
# ============================================================

@app.route("/manage/tutors/add", methods=["GET", "POST"])
@login_required
@permission_required("MANAGE_TUTORS")
def add_tutor():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:

        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # Qualification list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                qualification_id,
                qualification_name
            FROM qualification_master
            WHERE active_flag = TRUE
            ORDER BY qualification_name
        """)

        qualifications = cur.fetchall()

        # ----------------------------------------------------
        # Active AVLC list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                center_id,
                center_code,
                center_name
            FROM tuition_center
            WHERE status = 'ACTIVE'
            ORDER BY center_code
        """)

        centres = cur.fetchall()

        # ----------------------------------------------------
        # GET
        # ----------------------------------------------------
        if request.method == "GET":

            return render_template(
                "manage/add_tutor.html",
                academic_year=academic_year,
                qualifications=qualifications,
                centres=centres,
                form={},
                errors=[],
                active_page="manage"
            )

        # ----------------------------------------------------
        # POST
        # ----------------------------------------------------
        tutor_code = request.form.get("tutor_code", "").strip()
        tutor_name = request.form.get("tutor_name", "").strip()
        gender = request.form.get("gender", "").strip() or None
        mobile_no = request.form.get("mobile_no", "").strip() or None
        date_of_birth = request.form.get("date_of_birth", "").strip() or None
        joining_date = request.form.get("joining_date", "").strip() or None
        qualification_id = (
            request.form.get("qualification_id", "").strip() or None
        )
        center_id = request.form.get("center_id", "").strip()
        assigned_from = request.form.get("assigned_from", "").strip()

        errors = []

        # ----------------------------------------------------
        # Required fields
        # ----------------------------------------------------
        if not tutor_code:
            errors.append("Tutor Code is required.")

        if not tutor_name:
            errors.append("Tutor Name is required.")

        if not center_id:
            errors.append("AVLC is required.")

        if not assigned_from:
            errors.append("Assignment From date is required.")

        # ----------------------------------------------------
        # Tutor Code uniqueness
        # ----------------------------------------------------
        if tutor_code:

            cur.execute("""
                SELECT tutor_id
                FROM tutor_master
                WHERE tutor_code = %s
                LIMIT 1
            """, (tutor_code,))

            if cur.fetchone():
                errors.append(
                    "Tutor Code already exists. "
                    "Please enter a unique Tutor Code."
                )

        # ----------------------------------------------------
        # Validation errors
        # ----------------------------------------------------
        if errors:

            return render_template(
                "manage/add_tutor.html",
                academic_year=academic_year,
                qualifications=qualifications,
                centres=centres,
                form=request.form,
                errors=errors,
                active_page="manage"
            )

        # ----------------------------------------------------
        # Create Tutor + Initial AVLC Assignment
        # ----------------------------------------------------
        try:

            cur.execute("""
                INSERT INTO tutor_master (
                    tutor_code,
                    tutor_name,
                    gender,
                    mobile_no,
                    date_of_birth,
                    joining_date,
                    qualification_id,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, %s, %s, %s, %s, TRUE
                )
                RETURNING tutor_id
            """, (
                tutor_code,
                tutor_name,
                gender,
                mobile_no,
                date_of_birth,
                joining_date,
                qualification_id
            ))

            tutor_id = cur.fetchone()["tutor_id"]

            cur.execute("""
                INSERT INTO tutor_centre_assignment (
                    tutor_id,
                    center_id,
                    academic_year_id,
                    assigned_from,
                    assigned_to,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, %s, NULL, TRUE
                )
            """, (
                tutor_id,
                center_id,
                academic_year_id,
                assigned_from
            ))

            conn.commit()

            return redirect(
                url_for(
                    "manage_tutors",
                    message="Tutor added successfully."
                )
            )

        except Exception:
            conn.rollback()
            raise

    finally:
        cur.close()
        conn.close()


# ============================================================
# MANAGE - TUTORS
# ============================================================

@app.route("/manage/tutors")
@login_required
@permission_required("MANAGE_TUTORS")
def manage_tutors():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:
        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # Filters
        # ----------------------------------------------------
        search = request.args.get("search", "").strip()
        status_filter = request.args.get("status", "ACTIVE").strip()
        centre_filter = request.args.get("centre", "").strip()

        message = request.args.get("message", "").strip()

        # ----------------------------------------------------
        # Summary
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                COUNT(*) AS tutors,

                COUNT(*) FILTER (
                    WHERE tm.active_flag = FALSE
                ) AS inactive

            FROM tutor_master tm
        """)

        summary = cur.fetchone()

        # ----------------------------------------------------
        # AVLC list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                center_id,
                center_code,
                center_name
            FROM tuition_center
            WHERE status = 'ACTIVE'
            ORDER BY center_code
        """)

        centres = cur.fetchall()

        # ----------------------------------------------------
        # Tutor list
        #
        # Current AVLC assignment only.
        # Historical assignments remain untouched.
        # ----------------------------------------------------
        query = """
            SELECT
                tm.tutor_id,
                tm.tutor_code,
                tm.tutor_name,
                tm.mobile_no,
                tm.gender,
                tm.date_of_birth,
                tm.joining_date,
                tm.active_flag,

                tc.center_id,
                tc.center_code,
                tc.center_name

            FROM tutor_master tm

            LEFT JOIN tutor_centre_assignment tca
                ON tca.tutor_id = tm.tutor_id
               AND tca.academic_year_id = %s
               AND tca.active_flag = TRUE

            LEFT JOIN tuition_center tc
                ON tc.center_id = tca.center_id

            WHERE 1 = 1
        """

        params = [
            academic_year_id
        ]

        # ----------------------------------------------------
        # Search
        # ----------------------------------------------------
        if search:
            query += """
                AND (
                    COALESCE(tm.tutor_code, '') ILIKE %s
                    OR tm.tutor_name ILIKE %s
                    OR COALESCE(tm.mobile_no, '') ILIKE %s
                )
            """

            search_value = f"%{search}%"

            params.extend([
                search_value,
                search_value,
                search_value
            ])

        # ----------------------------------------------------
        # Status filter
        # ----------------------------------------------------
        if status_filter == "ACTIVE":
            query += """
                AND tm.active_flag = TRUE
            """

        elif status_filter == "INACTIVE":
            query += """
                AND tm.active_flag = FALSE
            """

        # ----------------------------------------------------
        # AVLC filter
        # ----------------------------------------------------
        if centre_filter:
            query += """
                AND tc.center_id = %s
            """
            params.append(centre_filter)

        query += """
            ORDER BY
                tm.tutor_name
        """

        cur.execute(query, tuple(params))

        tutors = cur.fetchall()

        return render_template(
            "manage/tutors.html",
            tutors=tutors,
            centres=centres,
            summary=summary,
            academic_year=academic_year,
            search=search,
            status_filter=status_filter,
            centre_filter=centre_filter,
            message=message,
            active_page="manage"
        )

    finally:
        cur.close()
        conn.close()


# ============================================================
# MANAGE - ADD CLUSTER COORDINATOR
# ============================================================

@app.route("/manage/cluster-coordinators/add", methods=["GET", "POST"])
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def add_cluster_coordinator():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:

        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # Active segments
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE active_flag = TRUE
            ORDER BY segment_name
        """)

        segments = cur.fetchall()

        # ----------------------------------------------------
        # Active clusters
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                cm.cluster_id,
                cm.cluster_name,
                cm.segment_id,
                sm.segment_name
            FROM cluster_master cm
            JOIN segment_master sm
              ON sm.segment_id = cm.segment_id
            WHERE cm.active_flag = TRUE
              AND sm.active_flag = TRUE
            ORDER BY sm.segment_name, cm.cluster_name
        """)

        clusters = cur.fetchall()

        # ----------------------------------------------------
        # GET
        # ----------------------------------------------------
        if request.method == "GET":

            return render_template(
                "manage/add_cluster_coordinator.html",
                academic_year=academic_year,
                segments=segments,
                clusters=clusters,
                form={},
                errors=[],
                active_page="manage"
            )

        # ----------------------------------------------------
        # POST
        # ----------------------------------------------------
        cc_code = request.form.get("cc_code", "").strip()
        cc_name = request.form.get("cc_name", "").strip()
        mobile_no = request.form.get("mobile_no", "").strip() or None
        joining_date = request.form.get("joining_date", "").strip() or None

        segment_id = request.form.get("segment_id", "").strip()
        cluster_id = request.form.get("cluster_id", "").strip()
        assigned_from = request.form.get("assigned_from", "").strip()

        errors = []

        # ----------------------------------------------------
        # Required fields
        # ----------------------------------------------------
        if not cc_code:
            errors.append("CC Code is required.")

        if not cc_name:
            errors.append("CC Name is required.")

        if not segment_id:
            errors.append("Segment is required.")

        if not cluster_id:
            errors.append("Cluster is required.")

        if not assigned_from:
            errors.append("Assignment From date is required.")

        # ----------------------------------------------------
        # CC Code uniqueness
        #
        # Case-insensitive application validation:
        # CC001 and cc001 are treated as the same code.
        # ----------------------------------------------------
        if cc_code:

            cur.execute("""
                SELECT cc_id
                FROM cluster_coordinator
                WHERE UPPER(cc_code) = UPPER(%s)
                LIMIT 1
            """, (cc_code,))

            if cur.fetchone():

                errors.append(
                    "CC Code already exists. "
                    "Please enter a unique CC Code."
                )

        # ----------------------------------------------------
        # Validate cluster belongs to selected segment
        # ----------------------------------------------------
        if segment_id and cluster_id:

            cur.execute("""
                SELECT cluster_id
                FROM cluster_master
                WHERE cluster_id = %s
                  AND segment_id = %s
                  AND active_flag = TRUE
                LIMIT 1
            """, (
                cluster_id,
                segment_id
            ))

            if not cur.fetchone():

                errors.append(
                    "Selected Cluster does not belong "
                    "to the selected Segment."
                )

        # ----------------------------------------------------
        # Validation errors
        # ----------------------------------------------------
        if errors:

            return render_template(
                "manage/add_cluster_coordinator.html",
                academic_year=academic_year,
                segments=segments,
                clusters=clusters,
                form=request.form,
                errors=errors,
                active_page="manage"
            )

        # ----------------------------------------------------
        # Create CC + Initial Cluster Assignment
        #
        # Multiple active CC assignments to the same cluster
        # are permitted to support transition / handover.
        #
        # Existing CC assignments are NOT changed here.
        # ----------------------------------------------------
        try:

            cur.execute("""
                INSERT INTO cluster_coordinator (
                    cc_code,
                    cc_name,
                    mobile_no,
                    joining_date,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, %s, TRUE
                )
                RETURNING cc_id
            """, (
                cc_code,
                cc_name,
                mobile_no,
                joining_date
            ))

            cc_id = cur.fetchone()["cc_id"]

            cur.execute("""
                INSERT INTO cluster_coordinator_assignment (
                    cc_id,
                    cluster_id,
                    academic_year_id,
                    assigned_from,
                    assigned_to,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, %s, NULL, TRUE
                )
            """, (
                cc_id,
                cluster_id,
                academic_year_id,
                assigned_from
            ))

            conn.commit()

            return redirect(
                url_for(
                    "manage_cluster_coordinators",
                    message="Cluster Coordinator added successfully."
                )
            )

        except Exception:
            conn.rollback()
            raise

    finally:
        cur.close()
        conn.close()

# ============================================================
# MANAGE - CLUSTER COORDINATORS
# ============================================================

@app.route("/manage/cluster-coordinators")
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def manage_cluster_coordinators():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:
        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # Filters
        # ----------------------------------------------------
        search = request.args.get("search", "").strip()
        status_filter = request.args.get("status", "ACTIVE").strip()
        segment_filter = request.args.get("segment", "").strip()
        cluster_filter = request.args.get("cluster", "").strip()

        message = request.args.get("message", "").strip()

        # ----------------------------------------------------
        # Summary
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                COUNT(*) AS coordinators,

                COUNT(*) FILTER (
                    WHERE active_flag = FALSE
                ) AS inactive

            FROM cluster_coordinator
        """)

        summary = cur.fetchone()

        # ----------------------------------------------------
        # Segment list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE active_flag = TRUE
            ORDER BY segment_name
        """)

        segments = cur.fetchall()

        # ----------------------------------------------------
        # Cluster list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                cm.cluster_id,
                cm.cluster_name,
                cm.segment_id,
                sm.segment_name
            FROM cluster_master cm
            JOIN segment_master sm
              ON sm.segment_id = cm.segment_id
            WHERE cm.active_flag = TRUE
            ORDER BY sm.segment_name, cm.cluster_name
        """)

        clusters = cur.fetchall()

        # ----------------------------------------------------
        # CC list
        #
        # Current cluster assignment for current academic year.
        # AVLC count comes from the cluster, not directly from CC.
        # ----------------------------------------------------
        query = """
            SELECT
                cc.cc_id,
                cc.cc_name,
                cc.mobile_no,
                cc.joining_date,
                cc.active_flag,

                cm.cluster_id,
                cm.cluster_name,

                sm.segment_id,
                sm.segment_name,

                COUNT(DISTINCT clc.center_id) FILTER (
                    WHERE clc.active_flag = TRUE
                      AND clc.academic_year_id = %s
                ) AS avlc_count

            FROM cluster_coordinator cc

            LEFT JOIN cluster_coordinator_assignment cca
                ON cca.cc_id = cc.cc_id
               AND cca.academic_year_id = %s
               AND cca.active_flag = TRUE

            LEFT JOIN cluster_master cm
                ON cm.cluster_id = cca.cluster_id

            LEFT JOIN segment_master sm
                ON sm.segment_id = cm.segment_id

            LEFT JOIN cluster_center clc
                ON clc.cluster_id = cm.cluster_id
               AND clc.academic_year_id = %s
               AND clc.active_flag = TRUE

            WHERE 1 = 1
        """

        params = [
            academic_year_id,
            academic_year_id,
            academic_year_id
        ]

        # ----------------------------------------------------
        # Search
        # ----------------------------------------------------
        if search:
            query += """
                AND (
                    cc.cc_name ILIKE %s
                    OR COALESCE(cc.mobile_no, '') ILIKE %s
                    OR COALESCE(cm.cluster_name, '') ILIKE %s
                )
            """

            search_value = f"%{search}%"

            params.extend([
                search_value,
                search_value,
                search_value
            ])

        # ----------------------------------------------------
        # Status
        # ----------------------------------------------------
        if status_filter == "ACTIVE":
            query += """
                AND cc.active_flag = TRUE
            """

        elif status_filter == "INACTIVE":
            query += """
                AND cc.active_flag = FALSE
            """

        # ----------------------------------------------------
        # Segment
        # ----------------------------------------------------
        if segment_filter:
            query += """
                AND sm.segment_id = %s
            """
            params.append(segment_filter)

        # ----------------------------------------------------
        # Cluster
        # ----------------------------------------------------
        if cluster_filter:
            query += """
                AND cm.cluster_id = %s
            """
            params.append(cluster_filter)

        query += """
            GROUP BY
                cc.cc_id,
                cc.cc_name,
                cc.mobile_no,
                cc.joining_date,
                cc.active_flag,
                cm.cluster_id,
                cm.cluster_name,
                sm.segment_id,
                sm.segment_name

            ORDER BY
                cc.cc_name
        """

        cur.execute(query, tuple(params))

        coordinators = cur.fetchall()

        return render_template(
            "manage/cluster_coordinators.html",
            coordinators=coordinators,
            segments=segments,
            clusters=clusters,
            summary=summary,
            academic_year=academic_year,
            search=search,
            status_filter=status_filter,
            segment_filter=segment_filter,
            cluster_filter=cluster_filter,
            message=message,
            active_page="manage"
        )

    finally:
        cur.close()
        conn.close()


# ============================================================
# MANAGE - CLUSTER COORDINATOR DETAILS
# ============================================================

@app.route("/manage/cluster-coordinators/<int:cc_id>")
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def cluster_coordinator_details(cc_id):

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:
        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # CC master details
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                cc_id,
                cc_name,
                mobile_no,
                joining_date,
                active_flag
            FROM cluster_coordinator
            WHERE cc_id = %s
        """, (cc_id,))

        coordinator = cur.fetchone()

        if not coordinator:
            return "Cluster Coordinator not found.", 404

        # ----------------------------------------------------
        # Current cluster assignment
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                cca.cc_assignment_id,
                cca.cluster_id,
                cca.assigned_from,
                cca.assigned_to,
                cca.active_flag,

                cm.cluster_name,

                sm.segment_id,
                sm.segment_name

            FROM cluster_coordinator_assignment cca

            JOIN cluster_master cm
              ON cm.cluster_id = cca.cluster_id

            JOIN segment_master sm
              ON sm.segment_id = cm.segment_id

            WHERE cca.cc_id = %s
              AND cca.academic_year_id = %s
              AND cca.active_flag = TRUE

            ORDER BY cca.assigned_from DESC NULLS LAST
            LIMIT 1
        """, (
            cc_id,
            academic_year_id
        ))

        current_assignment = cur.fetchone()

        # ----------------------------------------------------
        # AVLCs belonging to current cluster
        # ----------------------------------------------------
        avlcs = []

        if current_assignment:

            cur.execute("""
                SELECT
                    clc.cluster_center_id,
                    clc.center_id,
                    clc.assigned_from,
                    clc.assigned_to,
                    clc.active_flag,

                    tc.center_code,
                    tc.center_name

                FROM cluster_center clc

                JOIN tuition_center tc
                  ON tc.center_id = clc.center_id

                WHERE clc.cluster_id = %s
                  AND clc.academic_year_id = %s
                  AND clc.active_flag = TRUE

                ORDER BY tc.center_code
            """, (
                current_assignment["cluster_id"],
                academic_year_id
            ))

            avlcs = cur.fetchall()

        return render_template(
            "manage/cluster_coordinator_details.html",
            coordinator=coordinator,
            current_assignment=current_assignment,
            avlcs=avlcs,
            academic_year=academic_year,
            active_page="manage"
        )

    finally:
        cur.close()
        conn.close()


# ============================================================
# MANAGE - SEGMENT INCHARGES
# ============================================================

@app.route("/manage/segment-incharges")
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def manage_segment_incharges():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:

        # ----------------------------------------------------
        # Filters
        # ----------------------------------------------------

        search = request.args.get("search", "").strip()
        status_filter = request.args.get("status", "ACTIVE").strip()
        segment_filter = request.args.get("segment", "").strip()

        message = request.args.get("message", "").strip()

        # ----------------------------------------------------
        # Summary
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                COUNT(DISTINCT u.user_id) AS segment_incharges,

                COUNT(DISTINCT u.user_id) FILTER (
                    WHERE ur.active_flag = FALSE
                       OR u.active_flag = FALSE
                ) AS inactive

            FROM aems_user u

            JOIN user_role ur
              ON ur.user_id = u.user_id

            JOIN role_master rm
              ON rm.role_id = ur.role_id

            WHERE rm.role_code = 'SEGMENT_INCHARGE'
        """)

        summary = cur.fetchone()

        # ----------------------------------------------------
        # Active Segment list for filter
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE active_flag = TRUE
            ORDER BY segment_name
        """)

        segments = cur.fetchall()

        # ----------------------------------------------------
        # Segment Incharge list
        #
        # Current SEGMENT access determines the SI's
        # current segment responsibility.
        # ----------------------------------------------------

        query = """
            SELECT
                u.user_id,
                u.username,
                u.full_name,
                u.mobile_no,
                u.active_flag AS user_active,

                ur.assigned_from AS role_assigned_from,
                ur.active_flag AS role_active,

                ua.user_access_id,
                ua.assigned_from AS segment_assigned_from,
                ua.segment_id,

                sm.segment_name,

                COUNT(DISTINCT cm.cluster_id) FILTER (
                    WHERE cm.active_flag = TRUE
                ) AS cluster_count

            FROM aems_user u

            JOIN user_role ur
              ON ur.user_id = u.user_id

            JOIN role_master rm
              ON rm.role_id = ur.role_id

            LEFT JOIN user_access ua
              ON ua.user_id = u.user_id
             AND ua.access_scope = 'SEGMENT'
             AND ua.active_flag = TRUE

            LEFT JOIN segment_master sm
              ON sm.segment_id = ua.segment_id

            LEFT JOIN cluster_master cm
              ON cm.segment_id = sm.segment_id
             AND cm.active_flag = TRUE

            WHERE rm.role_code = 'SEGMENT_INCHARGE'
        """

        params = []

        # ----------------------------------------------------
        # Search
        # ----------------------------------------------------

        if search:

            query += """
                AND (
                    u.full_name ILIKE %s
                    OR u.username ILIKE %s
                    OR COALESCE(u.mobile_no, '') ILIKE %s
                    OR COALESCE(sm.segment_name, '') ILIKE %s
                )
            """

            search_value = f"%{search}%"

            params.extend([
                search_value,
                search_value,
                search_value,
                search_value
            ])

        # ----------------------------------------------------
        # Status
        # ----------------------------------------------------

        if status_filter == "ACTIVE":

            query += """
                AND u.active_flag = TRUE
                AND ur.active_flag = TRUE
            """

        elif status_filter == "INACTIVE":

            query += """
                AND (
                    u.active_flag = FALSE
                    OR ur.active_flag = FALSE
                )
            """

        # ----------------------------------------------------
        # Segment
        # ----------------------------------------------------

        if segment_filter:

            query += """
                AND sm.segment_id = %s
            """

            params.append(segment_filter)

        query += """
            GROUP BY
                u.user_id,
                u.username,
                u.full_name,
                u.mobile_no,
                u.active_flag,

                ur.assigned_from,
                ur.active_flag,

                ua.user_access_id,
                ua.assigned_from,
                ua.segment_id,

                sm.segment_name

            ORDER BY
                u.full_name
        """

        cur.execute(query, tuple(params))

        segment_incharges = cur.fetchall()

        return render_template(
            "manage/segment_incharges.html",
            segment_incharges=segment_incharges,
            segments=segments,
            summary=summary,
            search=search,
            status_filter=status_filter,
            segment_filter=segment_filter,
            message=message,
            active_page="manage"
        )

    finally:
        cur.close()
        conn.close()

# ============================================================
# MANAGE - ADD SEGMENT INCHARGE
# ============================================================

@app.route("/manage/segment-incharges/add", methods=["GET", "POST"])
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def add_segment_incharge():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:

        # ----------------------------------------------------
        # Active segments
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE active_flag = TRUE
            ORDER BY segment_name
        """)

        segments = cur.fetchall()

        # ----------------------------------------------------
        # GET
        # ----------------------------------------------------

        if request.method == "GET":

            return render_template(
                "manage/add_segment_incharge.html",
                segments=segments,
                form={},
                errors=[],
                active_page="manage"
            )

        # ----------------------------------------------------
        # POST
        # ----------------------------------------------------

        employee_code = request.form.get("employee_code", "").strip()
        full_name = request.form.get("full_name", "").strip()
        username = request.form.get("username", "").strip()
        mobile_no = request.form.get("mobile_no", "").strip() or None

        segment_id = request.form.get("segment_id", "").strip()
        assigned_from = request.form.get("assigned_from", "").strip()

        errors = []

        # ----------------------------------------------------
        # Required fields
        # ----------------------------------------------------

        if not employee_code:
            errors.append("SI Name is required.")

        if not username:
            errors.append("Username is required.")

        if not segment_id:
            errors.append("Segment is required.")

        if not assigned_from:
            errors.append("Assignment From date is required.")

        # ----------------------------------------------------
        # Username uniqueness
        # ----------------------------------------------------

        if username:

            cur.execute("""
                SELECT user_id
                FROM aems_user
                WHERE LOWER(username) = LOWER(%s)
                LIMIT 1
            """, (username,))

            if cur.fetchone():

                errors.append(
                    "Username already exists. "
                    "Please enter a unique username."
                )

        # ----------------------------------------------------
        # Validate selected segment
        # ----------------------------------------------------

        if segment_id:

            cur.execute("""
                SELECT segment_id
                FROM segment_master
                WHERE segment_id = %s
                  AND active_flag = TRUE
                LIMIT 1
            """, (segment_id,))

            if not cur.fetchone():

                errors.append(
                    "Selected Segment is not active or does not exist."
                )

        # ----------------------------------------------------
        # Validation errors
        # ----------------------------------------------------

        if errors:

            return render_template(
                "manage/add_segment_incharge.html",
                segments=segments,
                form=request.form,
                errors=errors,
                active_page="manage"
            )

        # ----------------------------------------------------
        # Get Segment Incharge role
        # ----------------------------------------------------

        cur.execute("""
            SELECT role_id
            FROM role_master
            WHERE role_code = 'SEGMENT_INCHARGE'
              AND active_flag = TRUE
            LIMIT 1
        """)

        role = cur.fetchone()

        if not role:
            return "Segment Incharge role is not configured.", 500

        role_id = role["role_id"]

        # ----------------------------------------------------
        # Create User + Role + Segment Access
        #
        # Multiple active SIs may temporarily be assigned
        # to the same segment during transition / handover.
        # Existing SI assignments are NOT changed here.
        # ----------------------------------------------------

        try:

            # Temporary initial password.
            # We will improve password handling separately.

            initial_password = "demo@123"

            password_hash = generate_password_hash(
                initial_password
            )

            # Create AEMS user

            cur.execute("""
                INSERT INTO aems_user (
                    employee_code,
                    username,
                    password_hash,
                    full_name,
                    mobile_no,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, %s, %s, TRUE
                )
                RETURNING user_id
            """, (
                employee_code,
                username,
                password_hash,
                full_name,
                mobile_no
            ))

            user_id = cur.fetchone()["user_id"]

            # Assign Segment Incharge role

            cur.execute("""
                INSERT INTO user_role (
                    user_id,
                    role_id,
                    assigned_from,
                    assigned_to,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, NULL, TRUE
                )
            """, (
                user_id,
                role_id,
                assigned_from
            ))

            # Assign Segment access

            cur.execute("""
                INSERT INTO user_access (
                    user_id,
                    access_scope,
                    segment_id,
                    assigned_from,
                    assigned_to,
                    active_flag
                )
                VALUES (
                    %s, 'SEGMENT', %s, %s, NULL, TRUE
                )
            """, (
                user_id,
                segment_id,
                assigned_from
            ))

            conn.commit()

            return redirect(
                url_for(
                    "manage_segment_incharges",
                    message="Segment Incharge added successfully."
                )
            )

        except Exception:
            conn.rollback()
            raise

    finally:
        cur.close()
        conn.close()

# ============================================================
# MANAGE - AVLCS
# ============================================================

@app.route("/manage/avlcs")
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def manage_avlcs():

    message = request.args.get("message", "").strip()

    return render_template(
        "manage/avlcs.html",
        message=message,
        active_page="manage"
    )

# ============================================================
# MANAGE - CREATE AVLC
# ============================================================

@app.route("/manage/avlcs/add", methods=["GET", "POST"])
@login_required
@permission_required("MANAGE_ASSIGNMENTS")
def add_avlc():

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:

        # ----------------------------------------------------
        # Current Academic Year
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE active_flag = TRUE
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        # ----------------------------------------------------
        # Active Areas
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                area_id,
                area_name
            FROM area_master
            WHERE active_flag = TRUE
            ORDER BY area_name
        """)

        areas = cur.fetchall()

        # ----------------------------------------------------
        # Active Segments
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                segment_id,
                segment_name
            FROM segment_master
            WHERE active_flag = TRUE
            ORDER BY segment_name
        """)

        segments = cur.fetchall()

        # ----------------------------------------------------
        # Active Clusters
        # ----------------------------------------------------

        cur.execute("""
            SELECT
                cm.cluster_id,
                cm.cluster_name,
                cm.segment_id
            FROM cluster_master cm
            WHERE cm.active_flag = TRUE
            ORDER BY cm.cluster_name
        """)

        clusters = cur.fetchall()

        # ----------------------------------------------------
        # GET
        # ----------------------------------------------------

        if request.method == "GET":

            return render_template(
                "manage/add_avlc.html",
                academic_year=academic_year,
                areas=areas,
                segments=segments,
                clusters=clusters,
                form={},
                errors=[],
                active_page="manage"
            )

        # ----------------------------------------------------
        # POST
        # ----------------------------------------------------

        center_code = request.form.get("center_code", "").strip().upper()
        center_name = request.form.get("center_name", "").strip()
        area_id = request.form.get("area_id", "").strip()
        start_date = request.form.get("start_date", "").strip()
        segment_id = request.form.get("segment_id", "").strip()
        cluster_id = request.form.get("cluster_id", "").strip()
        remarks = request.form.get("remarks", "").strip() or None

        errors = []

        # ----------------------------------------------------
        # Required fields
        # ----------------------------------------------------

        if not center_code:
            errors.append("AVLC Code is required.")

        if not center_name:
            errors.append("AVLC Name is required.")

        if not area_id:
            errors.append("Area is required.")

        if not start_date:
            errors.append("Start Date is required.")

        if not segment_id:
            errors.append("Segment is required.")

        if not cluster_id:
            errors.append("Cluster is required.")

        # ----------------------------------------------------
        # AVLC Code must be unique
        # ----------------------------------------------------

        if center_code:

            cur.execute("""
                SELECT center_id
                FROM tuition_center
                WHERE UPPER(center_code) = UPPER(%s)
                LIMIT 1
            """, (center_code,))

            if cur.fetchone():
                errors.append(
                    "AVLC Code already exists."
                )

        # ----------------------------------------------------
        # Validate Area
        # ----------------------------------------------------

        if area_id:

            cur.execute("""
                SELECT area_id
                FROM area_master
                WHERE area_id = %s
                  AND active_flag = TRUE
                LIMIT 1
            """, (area_id,))

            if not cur.fetchone():
                errors.append(
                    "Selected Area is not active or does not exist."
                )

        # ----------------------------------------------------
        # Validate Segment / Cluster relationship
        # ----------------------------------------------------

        if segment_id and cluster_id:

            cur.execute("""
                SELECT cluster_id
                FROM cluster_master
                WHERE cluster_id = %s
                  AND segment_id = %s
                  AND active_flag = TRUE
                LIMIT 1
            """, (
                cluster_id,
                segment_id
            ))

            if not cur.fetchone():
                errors.append(
                    "Selected Cluster does not belong to the selected Segment."
                )

        # ----------------------------------------------------
        # Validation errors
        # ----------------------------------------------------

        if errors:

            return render_template(
                "manage/add_avlc.html",
                academic_year=academic_year,
                areas=areas,
                segments=segments,
                clusters=clusters,
                form=request.form,
                errors=errors,
                active_page="manage"
            )

        # ----------------------------------------------------
        # Create AVLC + Cluster Assignment
        # ----------------------------------------------------

        try:

            cur.execute("""
                INSERT INTO tuition_center (
                    center_code,
                    center_name,
                    area_id,
                    start_date,
                    status,
                    remarks
                )
                VALUES (
                    %s, %s, %s, %s, 'ACTIVE', %s
                )
                RETURNING center_id
            """, (
                center_code,
                center_name,
                area_id,
                start_date,
                remarks
            ))

            center_id = cur.fetchone()["center_id"]

            cur.execute("""
                INSERT INTO cluster_center (
                    cluster_id,
                    center_id,
                    academic_year_id,
                    assigned_from,
                    assigned_to,
                    active_flag
                )
                VALUES (
                    %s, %s, %s, %s, NULL, TRUE
                )
            """, (
                cluster_id,
                center_id,
                academic_year["academic_year_id"],
                start_date
            ))

            conn.commit()

            return redirect(
                url_for(
                    "manage_avlcs",
                    message=f"AVLC {center_code} created successfully."
                )
            )

        except Exception:
            conn.rollback()
            raise

    finally:
        cur.close()
        conn.close()



# ============================================================
# MANAGE - TUTOR DETAILS
# ============================================================

@app.route("/manage/tutors/<int:tutor_id>", methods=["GET"])
@login_required
@permission_required("MANAGE_TUTORS")
def tutor_details(tutor_id):

    conn = get_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    try:
        # ----------------------------------------------------
        # Current academic year
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                academic_year_id,
                academic_year
            FROM academic_year_master
            WHERE CURRENT_DATE BETWEEN start_date AND end_date
            ORDER BY start_date DESC
            LIMIT 1
        """)

        academic_year = cur.fetchone()

        if not academic_year:
            return "No active academic year configured.", 500

        academic_year_id = academic_year["academic_year_id"]

        # ----------------------------------------------------
        # Tutor details
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                tm.tutor_id,
                tm.tutor_code,
                tm.tutor_name,
                tm.gender,
                tm.mobile_no,
                tm.date_of_birth,
                tm.joining_date,
                tm.qualification_id,
                tm.active_flag
            FROM tutor_master tm
            WHERE tm.tutor_id = %s
        """, (tutor_id,))

        tutor = cur.fetchone()

        if not tutor:
            return "Tutor not found.", 404

        # ----------------------------------------------------
        # Qualification list
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                qualification_id,
                qualification_name
            FROM qualification_master
            WHERE active_flag = TRUE
            ORDER BY qualification_name
        """)

        qualifications = cur.fetchall()

        # ----------------------------------------------------
        # Current AVLC assignment
        # ----------------------------------------------------
        cur.execute("""
            SELECT
                tca.tutor_assignment_id,
                tca.center_id,
                tca.assigned_from,
                tca.assigned_to,
                tca.active_flag,
                tc.center_code,
                tc.center_name
            FROM tutor_centre_assignment tca
            JOIN tuition_center tc
              ON tc.center_id = tca.center_id
            WHERE tca.tutor_id = %s
              AND tca.academic_year_id = %s
              AND tca.active_flag = TRUE
            ORDER BY tca.assigned_from DESC
            LIMIT 1
        """, (
            tutor_id,
            academic_year_id
        ))

        current_assignment = cur.fetchone()

        return render_template(
            "manage/tutor_details.html",
            tutor=tutor,
            qualifications=qualifications,
            current_assignment=current_assignment,
            academic_year=academic_year,
            active_page="manage"
        )

    finally:
        cur.close()
        conn.close()



@app.route("/manage")
@login_required
@permission_required("MANAGE_CENTRES")
def manage():
    return render_template("manage/dashboard.html", active_page="manage")

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )


