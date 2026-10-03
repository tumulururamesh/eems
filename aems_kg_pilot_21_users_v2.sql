-- AEMS KG PILOT USER SETUP
-- 21 pilot users: 1 SI + 4 CCs + 16 Tutors
-- Username = business code
-- Initial pilot password = demo@123
-- AY 2026-2027 = academic_year_id 3
-- Run in avf_aems only.

BEGIN;

DO $$
BEGIN
    IF current_database() <> 'avf_aems' THEN
        RAISE EXCEPTION 'Wrong database: %. Expected avf_aems.', current_database();
    END IF;
END $$;

-- ---------------------------------------------------------
-- 1. Reset the existing KG SI account to the pilot password.
-- user_id 6 has already been converted to BANOTH ESHWAR / 26KG01.
-- Existing SEGMENT_INCHARGE role and KG SEGMENT access are preserved.
-- ---------------------------------------------------------

DO $$
DECLARE
    v_count integer;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM aems_user
    WHERE user_id = 6
      AND username = '26KG01'
      AND employee_code = '26KG01'
      AND full_name = 'BANOTH ESHWAR'
      AND active_flag = TRUE;

    IF v_count <> 1 THEN
        RAISE EXCEPTION 'Expected active KG SI account user_id=6 / 26KG01 was not found exactly as expected.';
    END IF;

    UPDATE aems_user
    SET password_hash = 'scrypt:32768:8:1$Kkxv5qqWVy4XGSgO$de46168124048a6980fe88533e5bcde98336081a7abd3f0c464dd798db09fb1398a363151fd7d332979a40c04c67df1f369bfc48e458a2e80796c4e8727b8d3a'
    WHERE user_id = 6;
END $$;

-- ---------------------------------------------------------
-- 2. Stage the 4 CC pilot users.
-- ---------------------------------------------------------

CREATE TEMP TABLE kg_cc_users (
    cc_code      varchar(20) PRIMARY KEY,
    cc_name      varchar(150) NOT NULL,
    cluster_name varchar(100) NOT NULL
) ON COMMIT DROP;

INSERT INTO kg_cc_users (cc_code, cc_name, cluster_name)
VALUES
    ('26KGCC01', 'DEVARAPALLY SWETHA REDDY', 'KG-CL-01'),
    ('26KGCC02', 'NAMMORI NAGALAXMI', 'KG-CL-02'),
    ('26KGCC03', 'RONGALA LOKESH RAO', 'KG-CL-03'),
    ('26KGCC04', 'MOHAMMAD GHOUSE', 'KG-CL-04');

-- ---------------------------------------------------------
-- 3. Stage the 16 Tutor pilot users.
-- ---------------------------------------------------------

CREATE TEMP TABLE kg_tutor_users (
    tutor_code  varchar(20) PRIMARY KEY,
    tutor_name  varchar(150) NOT NULL,
    center_code varchar(20) NOT NULL
) ON COMMIT DROP;

INSERT INTO kg_tutor_users (tutor_code, tutor_name, center_code)
VALUES
    ('26KGTT01', 'ARUKALA SHIVANI', '26KG01'),
    ('26KGTT02', 'PILLI ANUSHA', '26KG02'),
    ('26KGTT03', 'TELGAMALLA BHAVANI', '26KG03'),
    ('26KGTT04', 'JAVAJI VAISHNAVI', '26KG04'),
    ('26KGTT05', 'BADDAM NEHA', '26KG05'),
    ('26KGTT09', 'KETHAVATH TRISHA', '26KG09'),
    ('26KGTT11', 'JARUPULA SANGITHA', '26KG11'),
    ('26KGTT13', 'BATTINI SRAVANTHI', '26KG13'),
    ('26KGTT15', 'AERUKULA KRISHNAVENI', '26KG15'),
    ('26KGTT16', 'VANKODTH SHIRISHA', '26KG16'),
    ('26KGTT17', 'JILLA KALPANA', '26KG17'),
    ('26KGTT18', 'MADHANI HEMALATHA', '26KG18'),
    ('26KGTT19', 'BADHE LAXMI SAI SRI', '26KG19'),
    ('26KGTT20', 'GENTI KALPANA', '26KG20'),
    ('26KGTT22', 'MOHAMMAD ABDHULLA', '26KG22'),
    ('26KGTT23', 'METIKOII ANUSHA', '26KG23');

-- ---------------------------------------------------------
-- 4. Pre-load validation.
-- ---------------------------------------------------------

DO $$
DECLARE
    v_count integer;
BEGIN
    SELECT COUNT(*) INTO v_count FROM kg_cc_users;
    IF v_count <> 4 THEN
        RAISE EXCEPTION 'Expected 4 CC staging rows, found %.', v_count;
    END IF;

    SELECT COUNT(*) INTO v_count FROM kg_tutor_users;
    IF v_count <> 16 THEN
        RAISE EXCEPTION 'Expected 16 Tutor staging rows, found %.', v_count;
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM aems_user u
    WHERE u.username IN (
        SELECT cc_code FROM kg_cc_users
        UNION ALL
        SELECT tutor_code FROM kg_tutor_users
    );
    IF v_count <> 0 THEN
        RAISE EXCEPTION '% CC/Tutor pilot usernames already exist in aems_user.', v_count;
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM kg_cc_users s
    LEFT JOIN cluster_coordinator cc ON cc.cc_code = s.cc_code
    LEFT JOIN cluster_master cm ON cm.cluster_name = s.cluster_name
    WHERE cc.cc_id IS NULL OR cm.cluster_id IS NULL;
    IF v_count <> 0 THEN
        RAISE EXCEPTION '% CC staging rows cannot resolve CC or Cluster master.', v_count;
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM kg_tutor_users s
    LEFT JOIN tutor_master tm ON tm.tutor_code = s.tutor_code
    LEFT JOIN tuition_center tc ON tc.center_code = s.center_code
    WHERE tm.tutor_id IS NULL OR tc.center_id IS NULL;
    IF v_count <> 0 THEN
        RAISE EXCEPTION '% Tutor staging rows cannot resolve Tutor or AVLC master.', v_count;
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM role_master
    WHERE role_code IN ('CLUSTER_COORDINATOR', 'TUTOR');
    IF v_count <> 2 THEN
        RAISE EXCEPTION 'Required role codes CLUSTER_COORDINATOR and TUTOR were not both found.';
    END IF;
END $$;

-- ---------------------------------------------------------
-- 5. Create 4 CC aems_user accounts.
-- Copy mobile number from cluster_coordinator where available.
-- ---------------------------------------------------------

INSERT INTO aems_user
    (username, password_hash, full_name, mobile_no, employee_code, active_flag)
SELECT
    s.cc_code,
    'scrypt:32768:8:1$Kkxv5qqWVy4XGSgO$de46168124048a6980fe88533e5bcde98336081a7abd3f0c464dd798db09fb1398a363151fd7d332979a40c04c67df1f369bfc48e458a2e80796c4e8727b8d3a',
    cc.cc_name,
    cc.mobile_no,
    s.cc_code,
    TRUE
FROM kg_cc_users s
JOIN cluster_coordinator cc
  ON cc.cc_code = s.cc_code;

-- Assign CLUSTER_COORDINATOR role.
INSERT INTO user_role
    (user_id, role_id, assigned_from, active_flag)
SELECT
    u.user_id,
    rm.role_id,
    CURRENT_DATE,
    TRUE
FROM kg_cc_users s
JOIN aems_user u
  ON u.username = s.cc_code
JOIN role_master rm
  ON rm.role_code = 'CLUSTER_COORDINATOR';

-- Assign CLUSTER access.
INSERT INTO user_access
    (user_id, access_scope, cluster_id, assigned_from, active_flag)
SELECT
    u.user_id,
    'CLUSTER',
    cm.cluster_id,
    CURRENT_DATE,
    TRUE
FROM kg_cc_users s
JOIN aems_user u
  ON u.username = s.cc_code
JOIN cluster_master cm
  ON cm.cluster_name = s.cluster_name;

-- Link login to the actual CC person.
INSERT INTO user_person_assignment
    (user_id, cc_id, assigned_from, active_flag)
SELECT
    u.user_id,
    cc.cc_id,
    CURRENT_DATE,
    TRUE
FROM kg_cc_users s
JOIN aems_user u
  ON u.username = s.cc_code
JOIN cluster_coordinator cc
  ON cc.cc_code = s.cc_code;

-- ---------------------------------------------------------
-- 6. Create 16 Tutor aems_user accounts.
-- Copy mobile number from tutor_master where available.
-- ---------------------------------------------------------

INSERT INTO aems_user
    (username, password_hash, full_name, mobile_no, employee_code, active_flag)
SELECT
    s.tutor_code,
    'scrypt:32768:8:1$Kkxv5qqWVy4XGSgO$de46168124048a6980fe88533e5bcde98336081a7abd3f0c464dd798db09fb1398a363151fd7d332979a40c04c67df1f369bfc48e458a2e80796c4e8727b8d3a',
    tm.tutor_name,
    tm.mobile_no,
    s.tutor_code,
    TRUE
FROM kg_tutor_users s
JOIN tutor_master tm
  ON tm.tutor_code = s.tutor_code;

-- Assign TUTOR role.
INSERT INTO user_role
    (user_id, role_id, assigned_from, active_flag)
SELECT
    u.user_id,
    rm.role_id,
    CURRENT_DATE,
    TRUE
FROM kg_tutor_users s
JOIN aems_user u
  ON u.username = s.tutor_code
JOIN role_master rm
  ON rm.role_code = 'TUTOR';

-- Assign CENTRE access.
INSERT INTO user_access
    (user_id, access_scope, center_id, assigned_from, active_flag)
SELECT
    u.user_id,
    'CENTRE',
    tc.center_id,
    CURRENT_DATE,
    TRUE
FROM kg_tutor_users s
JOIN aems_user u
  ON u.username = s.tutor_code
JOIN tuition_center tc
  ON tc.center_code = s.center_code;

-- Link login to the actual Tutor person.
INSERT INTO user_person_assignment
    (user_id, tutor_id, assigned_from, active_flag)
SELECT
    u.user_id,
    tm.tutor_id,
    CURRENT_DATE,
    TRUE
FROM kg_tutor_users s
JOIN aems_user u
  ON u.username = s.tutor_code
JOIN tutor_master tm
  ON tm.tutor_code = s.tutor_code;

-- ---------------------------------------------------------
-- 7. Post-load validation.
-- ---------------------------------------------------------

DO $$
DECLARE
    v_si integer;
    v_cc integer;
    v_tutor integer;
    v_cc_person integer;
    v_tutor_person integer;
BEGIN
    SELECT COUNT(*) INTO v_si
    FROM aems_user u
    JOIN user_role ur ON ur.user_id = u.user_id AND ur.active_flag = TRUE
    JOIN role_master rm ON rm.role_id = ur.role_id
    JOIN user_access ua ON ua.user_id = u.user_id AND ua.active_flag = TRUE
    JOIN segment_master sm ON sm.segment_id = ua.segment_id
    WHERE u.username = '26KG01'
      AND u.active_flag = TRUE
      AND rm.role_code = 'SEGMENT_INCHARGE'
      AND ua.access_scope = 'SEGMENT'
      AND sm.segment_name = 'KG';

    SELECT COUNT(*) INTO v_cc
    FROM kg_cc_users s
    JOIN aems_user u ON u.username = s.cc_code AND u.active_flag = TRUE
    JOIN user_role ur ON ur.user_id = u.user_id AND ur.active_flag = TRUE
    JOIN role_master rm ON rm.role_id = ur.role_id
    JOIN user_access ua ON ua.user_id = u.user_id AND ua.active_flag = TRUE
    JOIN cluster_master cm ON cm.cluster_id = ua.cluster_id
    WHERE rm.role_code = 'CLUSTER_COORDINATOR'
      AND ua.access_scope = 'CLUSTER'
      AND cm.cluster_name = s.cluster_name;

    SELECT COUNT(*) INTO v_tutor
    FROM kg_tutor_users s
    JOIN aems_user u ON u.username = s.tutor_code AND u.active_flag = TRUE
    JOIN user_role ur ON ur.user_id = u.user_id AND ur.active_flag = TRUE
    JOIN role_master rm ON rm.role_id = ur.role_id
    JOIN user_access ua ON ua.user_id = u.user_id AND ua.active_flag = TRUE
    JOIN tuition_center tc ON tc.center_id = ua.center_id
    WHERE rm.role_code = 'TUTOR'
      AND ua.access_scope = 'CENTRE'
      AND tc.center_code = s.center_code;

    SELECT COUNT(*) INTO v_cc_person
    FROM kg_cc_users s
    JOIN aems_user u ON u.username = s.cc_code
    JOIN user_person_assignment upa
      ON upa.user_id = u.user_id
     AND upa.active_flag = TRUE
    JOIN cluster_coordinator cc
      ON cc.cc_id = upa.cc_id
     AND cc.cc_code = s.cc_code;

    SELECT COUNT(*) INTO v_tutor_person
    FROM kg_tutor_users s
    JOIN aems_user u ON u.username = s.tutor_code
    JOIN user_person_assignment upa
      ON upa.user_id = u.user_id
     AND upa.active_flag = TRUE
    JOIN tutor_master tm
      ON tm.tutor_id = upa.tutor_id
     AND tm.tutor_code = s.tutor_code;

    IF v_si <> 1 THEN
        RAISE EXCEPTION 'KG SI validation failed: expected 1, found %.', v_si;
    END IF;
    IF v_cc <> 4 THEN
        RAISE EXCEPTION 'KG CC validation failed: expected 4, found %.', v_cc;
    END IF;
    IF v_tutor <> 16 THEN
        RAISE EXCEPTION 'KG Tutor validation failed: expected 16, found %.', v_tutor;
    END IF;
    IF v_cc_person <> 4 THEN
        RAISE EXCEPTION 'CC person-link validation failed: expected 4, found %.', v_cc_person;
    END IF;
    IF v_tutor_person <> 16 THEN
        RAISE EXCEPTION 'Tutor person-link validation failed: expected 16, found %.', v_tutor_person;
    END IF;
END $$;

COMMIT;

-- ---------------------------------------------------------
-- 8. Verification report (password hashes intentionally omitted).
-- Expected: 21 rows.
-- ---------------------------------------------------------

SELECT
    u.user_id,
    u.username,
    u.employee_code,
    u.full_name,
    rm.role_code,
    ua.access_scope,
    sm.segment_name,
    cm.cluster_name,
    tc.center_code,
    CASE
        WHEN upa.cc_id IS NOT NULL THEN cc.cc_code
        WHEN upa.tutor_id IS NOT NULL THEN tm.tutor_code
        ELSE NULL
    END AS person_code
FROM aems_user u
JOIN user_role ur
  ON ur.user_id = u.user_id
 AND ur.active_flag = TRUE
JOIN role_master rm
  ON rm.role_id = ur.role_id
JOIN user_access ua
  ON ua.user_id = u.user_id
 AND ua.active_flag = TRUE
LEFT JOIN segment_master sm
  ON sm.segment_id = ua.segment_id
LEFT JOIN cluster_master cm
  ON cm.cluster_id = ua.cluster_id
LEFT JOIN tuition_center tc
  ON tc.center_id = ua.center_id
LEFT JOIN user_person_assignment upa
  ON upa.user_id = u.user_id
 AND upa.active_flag = TRUE
LEFT JOIN cluster_coordinator cc
  ON cc.cc_id = upa.cc_id
LEFT JOIN tutor_master tm
  ON tm.tutor_id = upa.tutor_id
WHERE u.username = '26KG01'
   OR u.username LIKE '26KGCC%'
   OR u.username LIKE '26KGTT%'
ORDER BY
    CASE rm.role_code
        WHEN 'SEGMENT_INCHARGE' THEN 1
        WHEN 'CLUSTER_COORDINATOR' THEN 2
        WHEN 'TUTOR' THEN 3
        ELSE 9
    END,
    u.username;
