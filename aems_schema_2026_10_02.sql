--
-- PostgreSQL database dump
--

\restrict lMRnYknRtpwBeKKbuyzdIduSIvjX0LS1TJLL7dkQksuYSxMke9kPqrTJh1SyuXU

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: academic_year_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.academic_year_master (
    academic_year_id integer NOT NULL,
    academic_year character varying(9) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_academic_year_dates CHECK ((end_date > start_date))
);


--
-- Name: academic_year_master_academic_year_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.academic_year_master_academic_year_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: academic_year_master_academic_year_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.academic_year_master_academic_year_id_seq OWNED BY public.academic_year_master.academic_year_id;


--
-- Name: aems_phase1_student_stage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aems_phase1_student_stage (
    source_row_no text,
    segment_serial text,
    segment text,
    cc_name text,
    tutor_name text,
    avlc_code text,
    student_code text,
    student_name text,
    gender text,
    educational_status text,
    school_type text,
    class_studying text,
    curriculum_group text,
    medium text
);


--
-- Name: aems_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aems_user (
    user_id bigint NOT NULL,
    username character varying(100) NOT NULL,
    password_hash text NOT NULL,
    full_name character varying(150) NOT NULL,
    mobile_no character varying(15),
    email character varying(150),
    active_flag boolean DEFAULT true NOT NULL,
    last_login_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    employee_code character varying(30)
);


--
-- Name: aems_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aems_user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aems_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.aems_user_user_id_seq OWNED BY public.aems_user.user_id;


--
-- Name: area_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area_master (
    area_id integer NOT NULL,
    area_name character varying(100) NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: area_master_area_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.area_master_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_master_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.area_master_area_id_seq OWNED BY public.area_master.area_id;


--
-- Name: assessment_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assessment_master (
    assessment_id bigint NOT NULL,
    academic_year_id integer NOT NULL,
    assessment_name character varying(100) NOT NULL,
    assessment_type character varying(30) DEFAULT 'MONTHLY_TEST'::character varying NOT NULL,
    assessment_month date,
    assessment_date date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_assessment_type CHECK (((assessment_type)::text = ANY (ARRAY[('MONTHLY_TEST'::character varying)::text, ('BASELINE'::character varying)::text, ('PERIODIC_TEST'::character varying)::text, ('OTHER'::character varying)::text])))
);


--
-- Name: assessment_master_assessment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assessment_master_assessment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assessment_master_assessment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assessment_master_assessment_id_seq OWNED BY public.assessment_master.assessment_id;


--
-- Name: assessment_status_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assessment_status_master (
    status_code character varying(5) NOT NULL,
    status_name character varying(50) NOT NULL,
    description text,
    marks_applicable boolean DEFAULT false NOT NULL,
    eligible_for_performance boolean DEFAULT false NOT NULL,
    active_flag boolean DEFAULT true NOT NULL
);


--
-- Name: assessment_subject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assessment_subject (
    assessment_subject_id bigint NOT NULL,
    assessment_id bigint NOT NULL,
    subject_id integer NOT NULL,
    maximum_marks numeric(6,2) NOT NULL,
    display_order integer,
    CONSTRAINT chk_assessment_subject_max_marks CHECK ((maximum_marks > (0)::numeric))
);


--
-- Name: assessment_subject_assessment_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assessment_subject_assessment_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assessment_subject_assessment_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assessment_subject_assessment_subject_id_seq OWNED BY public.assessment_subject.assessment_subject_id;


--
-- Name: attendance_submission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendance_submission (
    submission_id bigint NOT NULL,
    center_id bigint NOT NULL,
    attendance_date date NOT NULL,
    cc_id bigint,
    day_status character varying(20) DEFAULT 'WORKING'::character varying NOT NULL,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    remarks text,
    submitted_by_user_id bigint,
    CONSTRAINT chk_attendance_day_status CHECK (((day_status)::text = ANY (ARRAY[('WORKING'::character varying)::text, ('HOLIDAY'::character varying)::text])))
);


--
-- Name: attendance_submission_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attendance_submission_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attendance_submission_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attendance_submission_submission_id_seq OWNED BY public.attendance_submission.submission_id;


--
-- Name: cluster_center; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cluster_center (
    cluster_center_id bigint NOT NULL,
    cluster_id integer NOT NULL,
    center_id bigint NOT NULL,
    academic_year_id integer NOT NULL,
    assigned_from date,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cluster_center_cluster_center_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cluster_center_cluster_center_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cluster_center_cluster_center_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cluster_center_cluster_center_id_seq OWNED BY public.cluster_center.cluster_center_id;


--
-- Name: cluster_coordinator; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cluster_coordinator (
    cc_id bigint NOT NULL,
    cc_name character varying(100) NOT NULL,
    mobile_no character varying(15),
    joining_date date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cc_code character varying(20)
);


--
-- Name: cluster_coordinator_assignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cluster_coordinator_assignment (
    cc_assignment_id bigint NOT NULL,
    cc_id bigint NOT NULL,
    cluster_id integer NOT NULL,
    academic_year_id integer NOT NULL,
    assigned_from date,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cluster_coordinator_assignment_cc_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cluster_coordinator_assignment_cc_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cluster_coordinator_assignment_cc_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cluster_coordinator_assignment_cc_assignment_id_seq OWNED BY public.cluster_coordinator_assignment.cc_assignment_id;


--
-- Name: cluster_coordinator_cc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cluster_coordinator_cc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cluster_coordinator_cc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cluster_coordinator_cc_id_seq OWNED BY public.cluster_coordinator.cc_id;


--
-- Name: cluster_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cluster_master (
    cluster_id integer NOT NULL,
    segment_id integer NOT NULL,
    cluster_name character varying(100) NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cluster_master_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cluster_master_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cluster_master_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cluster_master_cluster_id_seq OWNED BY public.cluster_master.cluster_id;


--
-- Name: curriculum_group_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_group_master (
    group_id integer NOT NULL,
    group_code character varying(10) NOT NULL,
    group_name character varying(100) NOT NULL,
    description text,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: curriculum_group_master_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.curriculum_group_master ALTER COLUMN group_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.curriculum_group_master_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: evaluation_group_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluation_group_master (
    group_id smallint NOT NULL,
    group_code character varying(10) NOT NULL,
    group_name character varying(50) NOT NULL,
    description text,
    active_flag boolean DEFAULT true NOT NULL
);


--
-- Name: evaluation_group_master_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluation_group_master_group_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluation_group_master_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluation_group_master_group_id_seq OWNED BY public.evaluation_group_master.group_id;


--
-- Name: permission_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permission_master (
    permission_id integer NOT NULL,
    permission_code character varying(50) NOT NULL,
    permission_name character varying(100) NOT NULL,
    description text,
    active_flag boolean DEFAULT true NOT NULL
);


--
-- Name: permission_master_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permission_master_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permission_master_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permission_master_permission_id_seq OWNED BY public.permission_master.permission_id;


--
-- Name: qualification_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.qualification_master (
    qualification_id integer NOT NULL,
    qualification_name character varying(100) NOT NULL,
    active_flag boolean DEFAULT true NOT NULL
);


--
-- Name: qualification_master_qualification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.qualification_master_qualification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: qualification_master_qualification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.qualification_master_qualification_id_seq OWNED BY public.qualification_master.qualification_id;


--
-- Name: role_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_master (
    role_id smallint NOT NULL,
    role_code character varying(30) NOT NULL,
    role_name character varying(100) NOT NULL,
    description text,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: role_master_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_master_role_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_master_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_master_role_id_seq OWNED BY public.role_master.role_id;


--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permission (
    role_id smallint NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: segment_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.segment_master (
    segment_id integer NOT NULL,
    zone_id integer NOT NULL,
    segment_name character varying(100) NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: segment_master_segment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.segment_master_segment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: segment_master_segment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.segment_master_segment_id_seq OWNED BY public.segment_master.segment_id;


--
-- Name: student_academic_year; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_academic_year (
    student_year_id bigint NOT NULL,
    student_id bigint NOT NULL,
    academic_year_id integer NOT NULL,
    class_studying integer,
    status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    group_id integer,
    CONSTRAINT chk_student_year_status CHECK (((status)::text = ANY (ARRAY[('ACTIVE'::character varying)::text, ('PROMOTED'::character varying)::text, ('COMPLETED'::character varying)::text, ('DROPPED'::character varying)::text, ('TRANSFERRED'::character varying)::text])))
);


--
-- Name: student_academic_year_student_year_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_academic_year_student_year_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_academic_year_student_year_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_academic_year_student_year_id_seq OWNED BY public.student_academic_year.student_year_id;


--
-- Name: student_assessment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_assessment (
    student_assessment_id bigint NOT NULL,
    assessment_id bigint NOT NULL,
    student_id bigint NOT NULL,
    student_year_id bigint,
    center_id bigint,
    evaluation_group_id smallint,
    test_status character varying(5) NOT NULL,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: student_assessment_mark; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_assessment_mark (
    mark_id bigint NOT NULL,
    student_assessment_id bigint NOT NULL,
    assessment_subject_id bigint NOT NULL,
    marks_obtained numeric(6,2) NOT NULL,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_marks_obtained CHECK ((marks_obtained >= (0)::numeric))
);


--
-- Name: student_assessment_mark_mark_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_assessment_mark_mark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_assessment_mark_mark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_assessment_mark_mark_id_seq OWNED BY public.student_assessment_mark.mark_id;


--
-- Name: student_assessment_student_assessment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_assessment_student_assessment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_assessment_student_assessment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_assessment_student_assessment_id_seq OWNED BY public.student_assessment.student_assessment_id;


--
-- Name: student_attendance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_attendance (
    attendance_id bigint NOT NULL,
    student_id bigint NOT NULL,
    submission_id bigint NOT NULL,
    attendance_date date NOT NULL,
    attendance_status character varying(10) NOT NULL,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_student_attendance_status CHECK (((attendance_status)::text = ANY (ARRAY[('PRESENT'::character varying)::text, ('ABSENT'::character varying)::text])))
);


--
-- Name: student_attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_attendance_attendance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_attendance_attendance_id_seq OWNED BY public.student_attendance.attendance_id;


--
-- Name: student_center_assignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_center_assignment (
    student_center_assignment_id bigint NOT NULL,
    student_id bigint NOT NULL,
    center_id bigint NOT NULL,
    academic_year_id integer NOT NULL,
    assigned_from date,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: student_center_assignment_student_center_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_center_assignment_student_center_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_center_assignment_student_center_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_center_assignment_student_center_assignment_id_seq OWNED BY public.student_center_assignment.student_center_assignment_id;


--
-- Name: student_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_master (
    student_id bigint NOT NULL,
    student_code character varying(20) NOT NULL,
    student_name character varying(200) NOT NULL,
    father_name character varying(200),
    mother_name character varying(200),
    gender character varying(10) NOT NULL,
    date_of_birth date,
    caste_category character varying(50),
    mobile_no character varying(15),
    aadhaar_no character varying(20),
    joining_date date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    student_picture text,
    school_name character varying(200),
    medium character varying(50),
    is_private boolean,
    CONSTRAINT chk_student_gender CHECK (((gender)::text = ANY (ARRAY[('Boy'::character varying)::text, ('Girl'::character varying)::text, ('Other'::character varying)::text])))
);


--
-- Name: student_master_student_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_master_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_master_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_master_student_id_seq OWNED BY public.student_master.student_id;


--
-- Name: subject_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subject_master (
    subject_id integer NOT NULL,
    subject_name character varying(100) NOT NULL,
    active_flag boolean DEFAULT true NOT NULL
);


--
-- Name: subject_master_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subject_master_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subject_master_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subject_master_subject_id_seq OWNED BY public.subject_master.subject_id;


--
-- Name: tuition_center; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tuition_center (
    center_id bigint NOT NULL,
    center_code character varying(20) NOT NULL,
    center_name character varying(100),
    ward_id bigint,
    start_date date,
    status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    area_id integer,
    CONSTRAINT chk_center_status CHECK (((status)::text = ANY (ARRAY[('ACTIVE'::character varying)::text, ('INACTIVE'::character varying)::text, ('CLOSED'::character varying)::text])))
);


--
-- Name: tuition_center_center_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tuition_center_center_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tuition_center_center_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tuition_center_center_id_seq OWNED BY public.tuition_center.center_id;


--
-- Name: tutor_centre_assignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tutor_centre_assignment (
    tutor_assignment_id bigint NOT NULL,
    tutor_id bigint NOT NULL,
    center_id bigint NOT NULL,
    academic_year_id integer NOT NULL,
    assigned_from date,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tutor_centre_assignment_tutor_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tutor_centre_assignment_tutor_assignment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tutor_centre_assignment_tutor_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tutor_centre_assignment_tutor_assignment_id_seq OWNED BY public.tutor_centre_assignment.tutor_assignment_id;


--
-- Name: tutor_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tutor_master (
    tutor_id bigint NOT NULL,
    tutor_code character varying(20),
    tutor_name character varying(100) NOT NULL,
    gender character varying(10),
    mobile_no character varying(15),
    date_of_birth date,
    joining_date date,
    qualification_id integer,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    exit_date date,
    CONSTRAINT chk_tutor_gender CHECK (((gender IS NULL) OR ((gender)::text = ANY (ARRAY[('Boy'::character varying)::text, ('Girl'::character varying)::text, ('Other'::character varying)::text]))))
);


--
-- Name: tutor_master_tutor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tutor_master_tutor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tutor_master_tutor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tutor_master_tutor_id_seq OWNED BY public.tutor_master.tutor_id;


--
-- Name: user_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_access (
    user_access_id bigint NOT NULL,
    user_id bigint NOT NULL,
    access_scope character varying(20) NOT NULL,
    zone_id integer,
    segment_id integer,
    cluster_id integer,
    center_id bigint,
    assigned_from date DEFAULT CURRENT_DATE NOT NULL,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_user_access_dates CHECK (((assigned_to IS NULL) OR (assigned_to >= assigned_from))),
    CONSTRAINT chk_user_access_scope CHECK (((access_scope)::text = ANY (ARRAY[('ALL'::character varying)::text, ('ZONE'::character varying)::text, ('SEGMENT'::character varying)::text, ('CLUSTER'::character varying)::text, ('CENTRE'::character varying)::text]))),
    CONSTRAINT chk_user_access_scope_reference CHECK (((((access_scope)::text = 'ALL'::text) AND (zone_id IS NULL) AND (segment_id IS NULL) AND (cluster_id IS NULL) AND (center_id IS NULL)) OR (((access_scope)::text = 'ZONE'::text) AND (zone_id IS NOT NULL) AND (segment_id IS NULL) AND (cluster_id IS NULL) AND (center_id IS NULL)) OR (((access_scope)::text = 'SEGMENT'::text) AND (zone_id IS NULL) AND (segment_id IS NOT NULL) AND (cluster_id IS NULL) AND (center_id IS NULL)) OR (((access_scope)::text = 'CLUSTER'::text) AND (zone_id IS NULL) AND (segment_id IS NULL) AND (cluster_id IS NOT NULL) AND (center_id IS NULL)) OR (((access_scope)::text = 'CENTRE'::text) AND (zone_id IS NULL) AND (segment_id IS NULL) AND (cluster_id IS NULL) AND (center_id IS NOT NULL))))
);


--
-- Name: user_access_user_access_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_access_user_access_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_access_user_access_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_access_user_access_id_seq OWNED BY public.user_access.user_access_id;


--
-- Name: user_person_assignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_person_assignment (
    user_id bigint NOT NULL,
    tutor_id bigint,
    cc_id bigint,
    assigned_from date DEFAULT CURRENT_DATE NOT NULL,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_person_assignment_check CHECK ((((tutor_id IS NOT NULL) AND (cc_id IS NULL)) OR ((tutor_id IS NULL) AND (cc_id IS NOT NULL)))),
    CONSTRAINT user_person_assignment_check1 CHECK (((assigned_to IS NULL) OR (assigned_to >= assigned_from)))
);


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role (
    user_id bigint NOT NULL,
    role_id smallint NOT NULL,
    assigned_from date DEFAULT CURRENT_DATE NOT NULL,
    assigned_to date,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_user_role_dates CHECK (((assigned_to IS NULL) OR (assigned_to >= assigned_from)))
);


--
-- Name: ward_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ward_master (
    ward_id bigint NOT NULL,
    ward_number character varying(20) NOT NULL,
    ward_name character varying(100),
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    district_name character varying(100) NOT NULL
);


--
-- Name: ward_master_ward_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ward_master_ward_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ward_master_ward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ward_master_ward_id_seq OWNED BY public.ward_master.ward_id;


--
-- Name: zone_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zone_master (
    zone_id integer NOT NULL,
    zone_name character varying(100) NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: zone_master_zone_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.zone_master_zone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: zone_master_zone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.zone_master_zone_id_seq OWNED BY public.zone_master.zone_id;


--
-- Name: academic_year_master academic_year_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.academic_year_master ALTER COLUMN academic_year_id SET DEFAULT nextval('public.academic_year_master_academic_year_id_seq'::regclass);


--
-- Name: aems_user user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aems_user ALTER COLUMN user_id SET DEFAULT nextval('public.aems_user_user_id_seq'::regclass);


--
-- Name: area_master area_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_master ALTER COLUMN area_id SET DEFAULT nextval('public.area_master_area_id_seq'::regclass);


--
-- Name: assessment_master assessment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_master ALTER COLUMN assessment_id SET DEFAULT nextval('public.assessment_master_assessment_id_seq'::regclass);


--
-- Name: assessment_subject assessment_subject_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_subject ALTER COLUMN assessment_subject_id SET DEFAULT nextval('public.assessment_subject_assessment_subject_id_seq'::regclass);


--
-- Name: attendance_submission submission_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_submission ALTER COLUMN submission_id SET DEFAULT nextval('public.attendance_submission_submission_id_seq'::regclass);


--
-- Name: cluster_center cluster_center_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_center ALTER COLUMN cluster_center_id SET DEFAULT nextval('public.cluster_center_cluster_center_id_seq'::regclass);


--
-- Name: cluster_coordinator cc_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator ALTER COLUMN cc_id SET DEFAULT nextval('public.cluster_coordinator_cc_id_seq'::regclass);


--
-- Name: cluster_coordinator_assignment cc_assignment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator_assignment ALTER COLUMN cc_assignment_id SET DEFAULT nextval('public.cluster_coordinator_assignment_cc_assignment_id_seq'::regclass);


--
-- Name: cluster_master cluster_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_master ALTER COLUMN cluster_id SET DEFAULT nextval('public.cluster_master_cluster_id_seq'::regclass);


--
-- Name: evaluation_group_master group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group_master ALTER COLUMN group_id SET DEFAULT nextval('public.evaluation_group_master_group_id_seq'::regclass);


--
-- Name: permission_master permission_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permission_master ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_master_permission_id_seq'::regclass);


--
-- Name: qualification_master qualification_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.qualification_master ALTER COLUMN qualification_id SET DEFAULT nextval('public.qualification_master_qualification_id_seq'::regclass);


--
-- Name: role_master role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_master ALTER COLUMN role_id SET DEFAULT nextval('public.role_master_role_id_seq'::regclass);


--
-- Name: segment_master segment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segment_master ALTER COLUMN segment_id SET DEFAULT nextval('public.segment_master_segment_id_seq'::regclass);


--
-- Name: student_academic_year student_year_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_academic_year ALTER COLUMN student_year_id SET DEFAULT nextval('public.student_academic_year_student_year_id_seq'::regclass);


--
-- Name: student_assessment student_assessment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment ALTER COLUMN student_assessment_id SET DEFAULT nextval('public.student_assessment_student_assessment_id_seq'::regclass);


--
-- Name: student_assessment_mark mark_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment_mark ALTER COLUMN mark_id SET DEFAULT nextval('public.student_assessment_mark_mark_id_seq'::regclass);


--
-- Name: student_attendance attendance_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.student_attendance_attendance_id_seq'::regclass);


--
-- Name: student_center_assignment student_center_assignment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_center_assignment ALTER COLUMN student_center_assignment_id SET DEFAULT nextval('public.student_center_assignment_student_center_assignment_id_seq'::regclass);


--
-- Name: student_master student_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_master ALTER COLUMN student_id SET DEFAULT nextval('public.student_master_student_id_seq'::regclass);


--
-- Name: subject_master subject_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject_master ALTER COLUMN subject_id SET DEFAULT nextval('public.subject_master_subject_id_seq'::regclass);


--
-- Name: tuition_center center_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tuition_center ALTER COLUMN center_id SET DEFAULT nextval('public.tuition_center_center_id_seq'::regclass);


--
-- Name: tutor_centre_assignment tutor_assignment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_centre_assignment ALTER COLUMN tutor_assignment_id SET DEFAULT nextval('public.tutor_centre_assignment_tutor_assignment_id_seq'::regclass);


--
-- Name: tutor_master tutor_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_master ALTER COLUMN tutor_id SET DEFAULT nextval('public.tutor_master_tutor_id_seq'::regclass);


--
-- Name: user_access user_access_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access ALTER COLUMN user_access_id SET DEFAULT nextval('public.user_access_user_access_id_seq'::regclass);


--
-- Name: ward_master ward_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ward_master ALTER COLUMN ward_id SET DEFAULT nextval('public.ward_master_ward_id_seq'::regclass);


--
-- Name: zone_master zone_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zone_master ALTER COLUMN zone_id SET DEFAULT nextval('public.zone_master_zone_id_seq'::regclass);


--
-- Name: academic_year_master academic_year_master_academic_year_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.academic_year_master
    ADD CONSTRAINT academic_year_master_academic_year_key UNIQUE (academic_year);


--
-- Name: academic_year_master academic_year_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.academic_year_master
    ADD CONSTRAINT academic_year_master_pkey PRIMARY KEY (academic_year_id);


--
-- Name: aems_user aems_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aems_user
    ADD CONSTRAINT aems_user_pkey PRIMARY KEY (user_id);


--
-- Name: aems_user aems_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aems_user
    ADD CONSTRAINT aems_user_username_key UNIQUE (username);


--
-- Name: area_master area_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_master
    ADD CONSTRAINT area_master_pkey PRIMARY KEY (area_id);


--
-- Name: assessment_master assessment_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_master
    ADD CONSTRAINT assessment_master_pkey PRIMARY KEY (assessment_id);


--
-- Name: assessment_status_master assessment_status_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_status_master
    ADD CONSTRAINT assessment_status_master_pkey PRIMARY KEY (status_code);


--
-- Name: assessment_subject assessment_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_subject
    ADD CONSTRAINT assessment_subject_pkey PRIMARY KEY (assessment_subject_id);


--
-- Name: attendance_submission attendance_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_submission
    ADD CONSTRAINT attendance_submission_pkey PRIMARY KEY (submission_id);


--
-- Name: cluster_center cluster_center_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_center
    ADD CONSTRAINT cluster_center_pkey PRIMARY KEY (cluster_center_id);


--
-- Name: cluster_coordinator_assignment cluster_coordinator_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator_assignment
    ADD CONSTRAINT cluster_coordinator_assignment_pkey PRIMARY KEY (cc_assignment_id);


--
-- Name: cluster_coordinator cluster_coordinator_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator
    ADD CONSTRAINT cluster_coordinator_pkey PRIMARY KEY (cc_id);


--
-- Name: cluster_master cluster_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_master
    ADD CONSTRAINT cluster_master_pkey PRIMARY KEY (cluster_id);


--
-- Name: curriculum_group_master curriculum_group_master_group_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_group_master
    ADD CONSTRAINT curriculum_group_master_group_code_key UNIQUE (group_code);


--
-- Name: curriculum_group_master curriculum_group_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_group_master
    ADD CONSTRAINT curriculum_group_master_pkey PRIMARY KEY (group_id);


--
-- Name: evaluation_group_master evaluation_group_master_group_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group_master
    ADD CONSTRAINT evaluation_group_master_group_code_key UNIQUE (group_code);


--
-- Name: evaluation_group_master evaluation_group_master_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group_master
    ADD CONSTRAINT evaluation_group_master_group_name_key UNIQUE (group_name);


--
-- Name: evaluation_group_master evaluation_group_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group_master
    ADD CONSTRAINT evaluation_group_master_pkey PRIMARY KEY (group_id);


--
-- Name: permission_master permission_master_permission_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permission_master
    ADD CONSTRAINT permission_master_permission_code_key UNIQUE (permission_code);


--
-- Name: permission_master permission_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permission_master
    ADD CONSTRAINT permission_master_pkey PRIMARY KEY (permission_id);


--
-- Name: qualification_master qualification_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.qualification_master
    ADD CONSTRAINT qualification_master_pkey PRIMARY KEY (qualification_id);


--
-- Name: qualification_master qualification_master_qualification_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.qualification_master
    ADD CONSTRAINT qualification_master_qualification_name_key UNIQUE (qualification_name);


--
-- Name: role_master role_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_master
    ADD CONSTRAINT role_master_pkey PRIMARY KEY (role_id);


--
-- Name: role_master role_master_role_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_master
    ADD CONSTRAINT role_master_role_code_key UNIQUE (role_code);


--
-- Name: role_master role_master_role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_master
    ADD CONSTRAINT role_master_role_name_key UNIQUE (role_name);


--
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: segment_master segment_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segment_master
    ADD CONSTRAINT segment_master_pkey PRIMARY KEY (segment_id);


--
-- Name: student_academic_year student_academic_year_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_academic_year
    ADD CONSTRAINT student_academic_year_pkey PRIMARY KEY (student_year_id);


--
-- Name: student_assessment_mark student_assessment_mark_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment_mark
    ADD CONSTRAINT student_assessment_mark_pkey PRIMARY KEY (mark_id);


--
-- Name: student_assessment student_assessment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_pkey PRIMARY KEY (student_assessment_id);


--
-- Name: student_attendance student_attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_attendance
    ADD CONSTRAINT student_attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: student_center_assignment student_center_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_center_assignment
    ADD CONSTRAINT student_center_assignment_pkey PRIMARY KEY (student_center_assignment_id);


--
-- Name: student_master student_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_master
    ADD CONSTRAINT student_master_pkey PRIMARY KEY (student_id);


--
-- Name: student_master student_master_student_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_master
    ADD CONSTRAINT student_master_student_code_key UNIQUE (student_code);


--
-- Name: subject_master subject_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject_master
    ADD CONSTRAINT subject_master_pkey PRIMARY KEY (subject_id);


--
-- Name: subject_master subject_master_subject_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subject_master
    ADD CONSTRAINT subject_master_subject_name_key UNIQUE (subject_name);


--
-- Name: tuition_center tuition_center_center_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tuition_center
    ADD CONSTRAINT tuition_center_center_code_key UNIQUE (center_code);


--
-- Name: tuition_center tuition_center_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tuition_center
    ADD CONSTRAINT tuition_center_pkey PRIMARY KEY (center_id);


--
-- Name: tutor_centre_assignment tutor_centre_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_centre_assignment
    ADD CONSTRAINT tutor_centre_assignment_pkey PRIMARY KEY (tutor_assignment_id);


--
-- Name: tutor_master tutor_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_master
    ADD CONSTRAINT tutor_master_pkey PRIMARY KEY (tutor_id);


--
-- Name: tutor_master tutor_master_tutor_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_master
    ADD CONSTRAINT tutor_master_tutor_code_key UNIQUE (tutor_code);


--
-- Name: area_master uq_area_master_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_master
    ADD CONSTRAINT uq_area_master_name UNIQUE (area_name);


--
-- Name: assessment_master uq_assessment_name_year; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_master
    ADD CONSTRAINT uq_assessment_name_year UNIQUE (academic_year_id, assessment_name);


--
-- Name: assessment_subject uq_assessment_subject; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_subject
    ADD CONSTRAINT uq_assessment_subject UNIQUE (assessment_id, subject_id);


--
-- Name: attendance_submission uq_attendance_submission_center_date; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_submission
    ADD CONSTRAINT uq_attendance_submission_center_date UNIQUE (center_id, attendance_date);


--
-- Name: cluster_center uq_cluster_center_year; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_center
    ADD CONSTRAINT uq_cluster_center_year UNIQUE (center_id, academic_year_id);


--
-- Name: cluster_coordinator uq_cluster_coordinator_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator
    ADD CONSTRAINT uq_cluster_coordinator_code UNIQUE (cc_code);


--
-- Name: cluster_master uq_cluster_segment_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_master
    ADD CONSTRAINT uq_cluster_segment_name UNIQUE (segment_id, cluster_name);


--
-- Name: segment_master uq_segment_zone_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segment_master
    ADD CONSTRAINT uq_segment_zone_name UNIQUE (zone_id, segment_name);


--
-- Name: student_academic_year uq_student_academic_year; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_academic_year
    ADD CONSTRAINT uq_student_academic_year UNIQUE (student_id, academic_year_id);


--
-- Name: student_assessment uq_student_assessment; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT uq_student_assessment UNIQUE (assessment_id, student_id);


--
-- Name: student_assessment_mark uq_student_assessment_mark; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment_mark
    ADD CONSTRAINT uq_student_assessment_mark UNIQUE (student_assessment_id, assessment_subject_id);


--
-- Name: student_attendance uq_student_attendance_student_date; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_attendance
    ADD CONSTRAINT uq_student_attendance_student_date UNIQUE (student_id, attendance_date);


--
-- Name: ward_master uq_ward_district_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ward_master
    ADD CONSTRAINT uq_ward_district_number UNIQUE (district_name, ward_number);


--
-- Name: user_access user_access_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access
    ADD CONSTRAINT user_access_pkey PRIMARY KEY (user_access_id);


--
-- Name: user_person_assignment user_person_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_person_assignment
    ADD CONSTRAINT user_person_assignment_pkey PRIMARY KEY (user_id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: ward_master ward_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ward_master
    ADD CONSTRAINT ward_master_pkey PRIMARY KEY (ward_id);


--
-- Name: zone_master zone_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zone_master
    ADD CONSTRAINT zone_master_pkey PRIMARY KEY (zone_id);


--
-- Name: zone_master zone_master_zone_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zone_master
    ADD CONSTRAINT zone_master_zone_name_key UNIQUE (zone_name);


--
-- Name: idx_cc_assignment_academic_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cc_assignment_academic_year ON public.cluster_coordinator_assignment USING btree (academic_year_id);


--
-- Name: idx_cc_assignment_cc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cc_assignment_cc ON public.cluster_coordinator_assignment USING btree (cc_id);


--
-- Name: idx_cc_assignment_cluster; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cc_assignment_cluster ON public.cluster_coordinator_assignment USING btree (cluster_id);


--
-- Name: idx_cluster_center_academic_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cluster_center_academic_year ON public.cluster_center USING btree (academic_year_id);


--
-- Name: idx_cluster_center_cluster; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cluster_center_cluster ON public.cluster_center USING btree (cluster_id);


--
-- Name: idx_cluster_master_segment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cluster_master_segment ON public.cluster_master USING btree (segment_id);


--
-- Name: idx_role_permission_permission; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_permission_permission ON public.role_permission USING btree (permission_id);


--
-- Name: idx_segment_master_zone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_segment_master_zone ON public.segment_master USING btree (zone_id);


--
-- Name: idx_student_academic_year_academic_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_academic_year_academic_year ON public.student_academic_year USING btree (academic_year_id);


--
-- Name: idx_student_academic_year_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_academic_year_student ON public.student_academic_year USING btree (student_id);


--
-- Name: idx_student_assessment_assessment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_assessment_assessment ON public.student_assessment USING btree (assessment_id);


--
-- Name: idx_student_assessment_mark_assessment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_assessment_mark_assessment ON public.student_assessment_mark USING btree (student_assessment_id);


--
-- Name: idx_student_assessment_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_assessment_student ON public.student_assessment USING btree (student_id);


--
-- Name: idx_student_attendance_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_attendance_student ON public.student_attendance USING btree (student_id);


--
-- Name: idx_student_attendance_submission; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_attendance_submission ON public.student_attendance USING btree (submission_id);


--
-- Name: idx_student_center_assignment_academic_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_center_assignment_academic_year ON public.student_center_assignment USING btree (academic_year_id);


--
-- Name: idx_student_center_assignment_center; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_center_assignment_center ON public.student_center_assignment USING btree (center_id);


--
-- Name: idx_student_center_assignment_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_center_assignment_student ON public.student_center_assignment USING btree (student_id);


--
-- Name: idx_tuition_center_area; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tuition_center_area ON public.tuition_center USING btree (area_id);


--
-- Name: idx_tuition_center_ward; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tuition_center_ward ON public.tuition_center USING btree (ward_id);


--
-- Name: idx_tutor_centre_assignment_academic_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tutor_centre_assignment_academic_year ON public.tutor_centre_assignment USING btree (academic_year_id);


--
-- Name: idx_tutor_centre_assignment_center; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tutor_centre_assignment_center ON public.tutor_centre_assignment USING btree (center_id);


--
-- Name: idx_tutor_centre_assignment_tutor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tutor_centre_assignment_tutor ON public.tutor_centre_assignment USING btree (tutor_id);


--
-- Name: idx_user_access_center; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_access_center ON public.user_access USING btree (center_id);


--
-- Name: idx_user_access_cluster; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_access_cluster ON public.user_access USING btree (cluster_id);


--
-- Name: idx_user_access_segment; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_access_segment ON public.user_access USING btree (segment_id);


--
-- Name: idx_user_access_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_access_user ON public.user_access USING btree (user_id);


--
-- Name: idx_user_access_zone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_access_zone ON public.user_access USING btree (zone_id);


--
-- Name: idx_user_role_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_role ON public.user_role USING btree (role_id);


--
-- Name: assessment_master assessment_master_academic_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_master
    ADD CONSTRAINT assessment_master_academic_year_id_fkey FOREIGN KEY (academic_year_id) REFERENCES public.academic_year_master(academic_year_id);


--
-- Name: assessment_subject assessment_subject_assessment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_subject
    ADD CONSTRAINT assessment_subject_assessment_id_fkey FOREIGN KEY (assessment_id) REFERENCES public.assessment_master(assessment_id);


--
-- Name: assessment_subject assessment_subject_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_subject
    ADD CONSTRAINT assessment_subject_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject_master(subject_id);


--
-- Name: attendance_submission attendance_submission_cc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_submission
    ADD CONSTRAINT attendance_submission_cc_id_fkey FOREIGN KEY (cc_id) REFERENCES public.cluster_coordinator(cc_id);


--
-- Name: attendance_submission attendance_submission_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_submission
    ADD CONSTRAINT attendance_submission_center_id_fkey FOREIGN KEY (center_id) REFERENCES public.tuition_center(center_id);


--
-- Name: attendance_submission attendance_submission_submitted_by_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_submission
    ADD CONSTRAINT attendance_submission_submitted_by_user_fkey FOREIGN KEY (submitted_by_user_id) REFERENCES public.aems_user(user_id);


--
-- Name: cluster_coordinator_assignment fk_cc_assignment_cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator_assignment
    ADD CONSTRAINT fk_cc_assignment_cc FOREIGN KEY (cc_id) REFERENCES public.cluster_coordinator(cc_id);


--
-- Name: cluster_coordinator_assignment fk_cc_assignment_cluster; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator_assignment
    ADD CONSTRAINT fk_cc_assignment_cluster FOREIGN KEY (cluster_id) REFERENCES public.cluster_master(cluster_id);


--
-- Name: cluster_coordinator_assignment fk_cc_assignment_year; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_coordinator_assignment
    ADD CONSTRAINT fk_cc_assignment_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_year_master(academic_year_id);


--
-- Name: cluster_center fk_cluster_center_center; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_center
    ADD CONSTRAINT fk_cluster_center_center FOREIGN KEY (center_id) REFERENCES public.tuition_center(center_id);


--
-- Name: cluster_center fk_cluster_center_cluster; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_center
    ADD CONSTRAINT fk_cluster_center_cluster FOREIGN KEY (cluster_id) REFERENCES public.cluster_master(cluster_id);


--
-- Name: cluster_center fk_cluster_center_year; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_center
    ADD CONSTRAINT fk_cluster_center_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_year_master(academic_year_id);


--
-- Name: cluster_master fk_cluster_segment; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cluster_master
    ADD CONSTRAINT fk_cluster_segment FOREIGN KEY (segment_id) REFERENCES public.segment_master(segment_id);


--
-- Name: segment_master fk_segment_zone; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segment_master
    ADD CONSTRAINT fk_segment_zone FOREIGN KEY (zone_id) REFERENCES public.zone_master(zone_id);


--
-- Name: student_center_assignment fk_student_center_center; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_center_assignment
    ADD CONSTRAINT fk_student_center_center FOREIGN KEY (center_id) REFERENCES public.tuition_center(center_id);


--
-- Name: student_center_assignment fk_student_center_student; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_center_assignment
    ADD CONSTRAINT fk_student_center_student FOREIGN KEY (student_id) REFERENCES public.student_master(student_id);


--
-- Name: student_center_assignment fk_student_center_year; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_center_assignment
    ADD CONSTRAINT fk_student_center_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_year_master(academic_year_id);


--
-- Name: student_academic_year fk_student_year_academic_year; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_academic_year
    ADD CONSTRAINT fk_student_year_academic_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_year_master(academic_year_id);


--
-- Name: student_academic_year fk_student_year_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_academic_year
    ADD CONSTRAINT fk_student_year_group FOREIGN KEY (group_id) REFERENCES public.curriculum_group_master(group_id);


--
-- Name: student_academic_year fk_student_year_student; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_academic_year
    ADD CONSTRAINT fk_student_year_student FOREIGN KEY (student_id) REFERENCES public.student_master(student_id);


--
-- Name: tuition_center fk_tuition_center_area; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tuition_center
    ADD CONSTRAINT fk_tuition_center_area FOREIGN KEY (area_id) REFERENCES public.area_master(area_id);


--
-- Name: tutor_centre_assignment fk_tutor_assignment_center; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_centre_assignment
    ADD CONSTRAINT fk_tutor_assignment_center FOREIGN KEY (center_id) REFERENCES public.tuition_center(center_id);


--
-- Name: tutor_centre_assignment fk_tutor_assignment_tutor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_centre_assignment
    ADD CONSTRAINT fk_tutor_assignment_tutor FOREIGN KEY (tutor_id) REFERENCES public.tutor_master(tutor_id);


--
-- Name: tutor_centre_assignment fk_tutor_assignment_year; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_centre_assignment
    ADD CONSTRAINT fk_tutor_assignment_year FOREIGN KEY (academic_year_id) REFERENCES public.academic_year_master(academic_year_id);


--
-- Name: tutor_master fk_tutor_qualification; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tutor_master
    ADD CONSTRAINT fk_tutor_qualification FOREIGN KEY (qualification_id) REFERENCES public.qualification_master(qualification_id);


--
-- Name: role_permission role_permission_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permission_master(permission_id);


--
-- Name: role_permission role_permission_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role_master(role_id);


--
-- Name: student_assessment student_assessment_assessment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_assessment_id_fkey FOREIGN KEY (assessment_id) REFERENCES public.assessment_master(assessment_id);


--
-- Name: student_assessment student_assessment_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_center_id_fkey FOREIGN KEY (center_id) REFERENCES public.tuition_center(center_id);


--
-- Name: student_assessment student_assessment_evaluation_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_evaluation_group_id_fkey FOREIGN KEY (evaluation_group_id) REFERENCES public.evaluation_group_master(group_id);


--
-- Name: student_assessment_mark student_assessment_mark_assessment_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment_mark
    ADD CONSTRAINT student_assessment_mark_assessment_subject_id_fkey FOREIGN KEY (assessment_subject_id) REFERENCES public.assessment_subject(assessment_subject_id);


--
-- Name: student_assessment_mark student_assessment_mark_student_assessment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment_mark
    ADD CONSTRAINT student_assessment_mark_student_assessment_id_fkey FOREIGN KEY (student_assessment_id) REFERENCES public.student_assessment(student_assessment_id);


--
-- Name: student_assessment student_assessment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_master(student_id);


--
-- Name: student_assessment student_assessment_student_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_student_year_id_fkey FOREIGN KEY (student_year_id) REFERENCES public.student_academic_year(student_year_id);


--
-- Name: student_assessment student_assessment_test_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_assessment
    ADD CONSTRAINT student_assessment_test_status_fkey FOREIGN KEY (test_status) REFERENCES public.assessment_status_master(status_code);


--
-- Name: student_attendance student_attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_attendance
    ADD CONSTRAINT student_attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_master(student_id);


--
-- Name: student_attendance student_attendance_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_attendance
    ADD CONSTRAINT student_attendance_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.attendance_submission(submission_id);


--
-- Name: user_access user_access_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access
    ADD CONSTRAINT user_access_center_id_fkey FOREIGN KEY (center_id) REFERENCES public.tuition_center(center_id);


--
-- Name: user_access user_access_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access
    ADD CONSTRAINT user_access_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.cluster_master(cluster_id);


--
-- Name: user_access user_access_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access
    ADD CONSTRAINT user_access_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES public.segment_master(segment_id);


--
-- Name: user_access user_access_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access
    ADD CONSTRAINT user_access_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.aems_user(user_id);


--
-- Name: user_access user_access_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_access
    ADD CONSTRAINT user_access_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES public.zone_master(zone_id);


--
-- Name: user_person_assignment user_person_assignment_cc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_person_assignment
    ADD CONSTRAINT user_person_assignment_cc_id_fkey FOREIGN KEY (cc_id) REFERENCES public.cluster_coordinator(cc_id);


--
-- Name: user_person_assignment user_person_assignment_tutor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_person_assignment
    ADD CONSTRAINT user_person_assignment_tutor_id_fkey FOREIGN KEY (tutor_id) REFERENCES public.tutor_master(tutor_id);


--
-- Name: user_person_assignment user_person_assignment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_person_assignment
    ADD CONSTRAINT user_person_assignment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.aems_user(user_id);


--
-- Name: user_role user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role_master(role_id);


--
-- Name: user_role user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.aems_user(user_id);


--
-- PostgreSQL database dump complete
--

\unrestrict lMRnYknRtpwBeKKbuyzdIduSIvjX0LS1TJLL7dkQksuYSxMke9kPqrTJh1SyuXU

