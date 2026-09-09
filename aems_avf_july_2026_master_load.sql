-- AEMS AVF Production master-data load from July 2026 workbook
-- Source: July 26 attd and MT 1(4).xlsx, sheet: JULY 26 FINAL DATA
-- No attendance, marks, test transactions, or inferred geography/hierarchy are loaded.
-- 5 conflicting student codes are intentionally excluded; see report at end.
BEGIN;
ALTER TABLE tuition_center ALTER COLUMN center_name DROP NOT NULL;
ALTER TABLE tutor_master ALTER COLUMN tutor_code DROP NOT NULL;
INSERT INTO academic_year_master (academic_year, active_flag) SELECT '2026-27', TRUE WHERE NOT EXISTS (SELECT 1 FROM academic_year_master WHERE academic_year='2026-27');
INSERT INTO cluster_coordinator (cc_name) SELECT 'CHARAN TEJ' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('CHARAN TEJ')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'DANDU AMRUTHA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('DANDU AMRUTHA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'GHOUSE' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('GHOUSE')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'KAVITHA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('KAVITHA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'LOKESH' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('LOKESH')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'MACHERLA ANITHA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('MACHERLA ANITHA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'MEKALI ASHWINI' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('MEKALI ASHWINI')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'NAGALAXMI' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('NAGALAXMI')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'RAMYA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('RAMYA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'SWETHA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('SWETHA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'TALARI SARITHA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('TALARI SARITHA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'VANGOORI PAVAN YADHAV' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('VANGOORI PAVAN YADHAV')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'VEMULA RADHIKA' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('VEMULA RADHIKA')));
INSERT INTO cluster_coordinator (cc_name) SELECT 'VIJAYALAXMI' WHERE NOT EXISTS (SELECT 1 FROM cluster_coordinator WHERE lower(trim(cc_name))=lower(trim('VIJAYALAXMI')));
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG01', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG02', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG03', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG04', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG05', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG06', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG07', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG08', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG09', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG10', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG11', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG12', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG13', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG14', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG15', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26AG16', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG01', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG02', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG03', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG04', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG05', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG06', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG07', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG08', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG09', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG10', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG11', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG12', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG13', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG14', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG15', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG16', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG17', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG18', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG19', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KG20', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP01', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP02', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP03', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP04', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP05', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP06', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP07', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26KP08', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP01', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP02', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP03', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP04', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP05', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP06', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP07', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP08', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP09', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP10', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP11', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP12', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26MP13', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV01', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV02', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV03', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV04', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV05', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV06', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV07', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV08', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV09', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV10', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV11', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV12', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV13', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV14', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV15', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV16', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV17', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26NV18', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP01', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP02', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP03', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP04', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP05', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP06', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP07', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP08', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP09', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP10', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP11', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP12', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP13', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP14', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP15', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tuition_center (center_code, center_name) VALUES ('26RP16', NULL) ON CONFLICT (center_code) DO NOTHING;
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'A. SHIVANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ABHILASH');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'AKHILESHWARA SAI PRASAD NAWLE');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'AKSHAYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'AKSHITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ALAGONI RISHIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ALYANA KAVYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ANUSHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ASHVITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ATHMAKUR SATHWIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'BARNANA GEETHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'BAYALA MAANVI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'BHANU PRASAD');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'BHAVANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'CHAPALA SRAVANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'CHARAN');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DANDUGULA  AMRUTHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DANGETI SATVIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DANNARAM SIRISHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DARSHIRALA CHANDHANA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DASARI ASMITHA RAI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DEVADI PADMA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DIVYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'DOTI LAXMI PRASANNA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GANGADEVI MOUNIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GELVKARA DHANUSHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GENTI KALPANA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GINNARAPU SNEHA PRIYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GOLLAPALLY JAYANTH');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GUNDA SHIRIHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GUNTALLA PAVANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'GUNTI SHIRISHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'HARIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'HARSHITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'HEMA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'INDRALA BHARANI CHARY');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'JANNU KEERTHI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'JYOTHIRMAHI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KAALA SWETHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KALPANA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KAMBLE SRUTHI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KAPPIDI SRI LAKSHMI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KATTA SWETHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KEERTHANA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KOLLI CHINNA PRIYANKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KOMALA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KRISHNA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KRISHNAVENI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KUKUMA SOWMYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'KUNDANAM BHAVYA SRI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'LAXMI PRIYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'LAXMI SAI SREE');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'MAKKA HEMALATHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'MEHARUNNISA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'MOHAMMAD AFREEN');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'MURDHAN SUJATHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'MUTHYALA VANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'MYADARI MAYURI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'NAMMORI SPANDANA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'NEHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'NIHARIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'NIKITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'PALLI POOJA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'POOJARI POOJA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'PRABHASINI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'RAVI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'RAZIYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'REKANDER ANITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'RITHIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'S.BHUVANESHWARI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SANDHYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SANGEETHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SANJEEV KUMAR');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SHAIK SHIFA BEGUM');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SHANIGARAM MISHRITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SHIRISHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SHIVANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SRAVANTHI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SRI PAVAN TEJA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SRIVANI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'SUPRIYA DUBEY');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'THATARI RITHWIKA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'TRISHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'VAISHNAVI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'VANTERU JUHITHA SRI ALEKHYA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'VEMULA ANJALI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'VEMULA NIKITHA');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'YASHWANTHI');
INSERT INTO tutor_master (tutor_code, tutor_name) VALUES (NULL, 'ZOHIIYA THABUSAM');
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0101', 'KARAMTHOTHU SRAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0102', 'KARAMTHOTHU MANOJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0103', 'CHEGONI PRANATHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0104', 'CHEGONI VEEKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0105', 'PANDULA BHAVYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0106', 'CHERUKU VARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0107', '.JATAVAT ANJANEYULU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0108', 'NALLA SIDHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0109', 'GUJJULA HARI CHARAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0110', 'RADAMONI HANUMA TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0111', 'MEDIPALLY DHANUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0112', 'GUTTHAVELLI SHIVA PRASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0113', 'RAGIPANI SUDIKSHA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0114', 'NADIGDTTU AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0115', 'NADIGDTTU HETANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0116', 'SRINATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0117', 'SITHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0118', 'MILKY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0119', 'WILLMS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0120', 'RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0121', 'DESHAVATH SIDDARTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0122', 'DESHAVATH RAM CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0201', 'NITHYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0202', 'ABHIGNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0203', 'YAKSHITH CHANDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0204', 'THANVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0205', 'HEMALETHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0206', 'AKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0207', 'VARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0208', 'VARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0209', 'DWARAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0210', 'RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0211', 'S.RITHVIK', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0212', 'YOUKI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0213', 'MASRATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0214', 'MADHIHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0215', 'AZAAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0216', 'K.AIRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0217', 'A.TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0218', 'C.HEMALATHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0219', 'J.ANJI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0220', 'M.DHANUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0221', 'D.RAM RISHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0222', 'S.VARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0223', 'MEESHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0301', 'T.NARASIMHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0302', 'N.MALLIKARJUNA  CHARY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0303', 'N.VAISHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0304', 'M.SHANMUKHA PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0305', 'CH.GANESH', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0306', 'M.SONY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0307', 'MD.BHUSAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0308', 'A.SHIVA', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0309', 'M.ANJALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0310', 'R.AMMULU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0311', 'R.AMRUTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0312', 'M.DHIPIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0313', 'RAMAVATH VADTHYA SWATHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0314', 'N.HARI PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0315', 'A.HAVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0316', 'G.ABHIRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0317', 'J.MANOHAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0318', 'M.NADHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0319', 'R.SHALINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0320', 'J.MADHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0321', 'D.ANJALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0322', 'M.DHIVYA HAMSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0323', 'M.MOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0324', 'KRISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0325', 'S.GOPI CHAND', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0326', 'R.NITHISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0327', 'TEJESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0328', 'AYESH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0329', 'G.SRI HARI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0330', 'N.SHIVA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0331', 'MD.MUSWVIR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0332', 'AYESHA FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0333', 'P.AISHWARYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0334', 'A.NAGAESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0401', 'G.SHIVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0402', 'SHRAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0403', 'BHANU PRASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0404', 'BHANU SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0405', 'SIDDHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0406', 'GAYATHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0407', 'ADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0408', 'LASYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0409', 'GANESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0410', 'NARESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0411', 'A.JESHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0412', 'VAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0413', 'NAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0414', 'AJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0415', 'ADVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0416', 'SONI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0417', 'AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0501', 'NAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0502', 'ADARSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0503', 'SRI LOWKYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0504', 'ANUJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0505', 'MAHA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0506', 'RAJESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0507', 'DIVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0508', 'SAI VEDHAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0509', 'RISHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0510', 'ASHWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0511', 'ARUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0512', 'SRI HARSHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0513', 'KAVERI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0514', 'SHIVA RANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0601', 'PAVAN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0602', 'NARSHIMA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0603', 'HEMALATHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0604', 'SHIVA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0605', 'JASVANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0701', 'AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0702', 'MEENAKSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0703', 'ABHIGANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0704', 'RADHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0705', 'RIZWANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0706', 'REHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0801', 'K.RISHANK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0802', 'B.VAISHNAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0803', 'P.DEEPTHI PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0804', 'K.SATHISH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0805', 'K.MOKSHITHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0806', 'D.PRAVALIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0807', 'D.LAXMI PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0808', 'M.MAHENDER', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0809', 'R.SUREKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0810', 'P.SUSHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0811', 'MSAI KRISHNA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0812', 'SREYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0813', 'KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0814', 'M.SRAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0901', 'L.GANESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0902', 'E.VAISHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0903', 'E.MOHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0904', 'B.BHARATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0905', 'N.DHATHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0906', 'N.ABHIRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0907', 'A.CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0908', 'D.SONU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0909', 'A.ISHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0910', 'A.SHANVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0911', 'A.ROHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0912', 'R.AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0913', 'N.ISHWARAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0914', 'MD.IYAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0915', 'MD.PFAIZAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0916', 'V.POOJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0917', 'CHAITRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG0918', 'AKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1006', 'G.ABHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1007', 'K.GRACY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1008', 'SUDNAIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1009', 'NIKITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1010', 'G.DHANALAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1011', 'K.POOJITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1012', 'E.GRACY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1013', 'N.NIKIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1014', 'UITTAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1015', 'NAGALAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1016', 'ANIRUDH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1017', 'AFIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1018', 'SHEBAZ', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1019', 'MIZBA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1020', 'MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1101', 'V.USHA VANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1102', 'B.SRUTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1103', 'P.JASWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1104', 'K.KESWARDANA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1105', 'B.KAVYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1106', 'E.HARI PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1107', 'T.TEJASVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1108', 'K.ADHITHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1109', 'A.PRABAKAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1110', 'M.SAITHARAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1111', 'CH.REVANTHI KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1112', 'K.DHANUSH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1113', 'K.SHIVA KUMAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1114', 'CH.DHATHASRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1115', 'DATHA SRI', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1116', 'CH.DHANUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1117', 'K.DIKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1118', 'K.HARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1119', 'R.KRISHNA KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1120', 'HIMA BINDHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1201', 'P.LAXMI VASAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1202', 'P.MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1203', 'G.SHIRISHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1204', 'G.SHRAVANTHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1205', 'G.DARSHINI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1206', 'G.RAGHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1207', 'NITHISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1208', 'E.SAIPRIYA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1209', 'AKSHITHA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1210', 'S.ARADHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1211', 'MOKSHITH', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1212', 'E.LOKESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1213', 'AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1301', 'SABAVATH MAHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1302', 'UPPALA AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1303', 'U.DEEPIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1304', 'KATRAVATH PAVAN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1305', 'MINKEEKAR JAYASRITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1306', 'PESARABANDA PALLAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1307', 'PESARABANDA RAMA TULASI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1308', 'NENAVATH SATHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1309', 'AMGOTH VAISHAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1310', 'AMGOTH RITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1311', 'MENUGOLA PRAVALIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1312', 'MENUGOLA BRAHAMARAMBIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1313', 'MENUGOLA JAGADAMIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1314', 'RAMAVATH DIVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1315', 'RAMAVATH NAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1316', 'AMGOTH DEEKSHASRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1317', 'TELKAR SUMITHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1318', 'TELKAR AKASHRA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1319', 'NALA BOTHULA SAIESHWAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1320', 'SHIVA MANI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1321', 'BATHINI AKSHARA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1322', 'MUNTI PALLAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1401', 'V. BHAVATHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1402', 'RITHIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1403', 'K.NIKITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1404', 'E.PAVAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1405', 'E.INDHU', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1406', 'E.HARIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1407', 'VAISHALI', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1408', 'SHIVANI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1501', 'DHARANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1502', 'RISHVIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1503', 'SARADHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1504', 'NAGA SHIVA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1505', 'DEEKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1506', 'SURYA GAYATHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1507', 'MYTHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1508', 'CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1509', 'HARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1510', 'M.KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1511', 'NAVADEEP', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1512', 'U.KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1513', 'SHRAVAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1514', 'SIRI CHANDANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1601', 'ARPITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1602', 'BHAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1603', 'MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1604', 'VARSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1605', 'SHARANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1606', 'PAVANI', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1607', 'GAGAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1608', 'BHANU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1609', 'YASHASWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1610', 'HAYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1611', 'CHATRANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1612', 'BLEESY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1613', 'PURSHOTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1614', 'RITHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1615', 'VIGNESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1616', 'SHARANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1617', 'UMA MAHESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1618', 'YOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1701', 'O.HONEY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1702', 'G.AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1703', 'O.HARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1704', 'O.VANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1705', 'K.BHAVANI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1706', 'K.RAMU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1707', 'M.GANESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1708', 'M.UMA SRI SATHYA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1709', 'K.PURUSHOTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1710', 'AKHILA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1711', 'RAJESHWARI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1712', 'MANI KANTHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1713', 'JESSY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1714', 'P.KARTHIK GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1715', 'P.KOUSHIK GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1716', 'BLESSY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1717', 'AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1801', 'TEJASHWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1802', 'LOKESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1803', 'K.NIHARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1804', 'K.KALYAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1805', 'K.SANTHOSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1806', 'ANSHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1807', 'ANJALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1808', 'SHIVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1809', 'VEENELA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1810', 'SUNNY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1811', 'HANVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1812', 'PURSHOTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1813', 'SHIVA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1814', 'BHAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1815', 'ARPITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1901', 'UGUDE KARTTHIK', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1902', 'UGUDE SHIVA TEJA', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1903', 'UGDE AKSHARA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1904', 'GOSTHI SURYA TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1905', 'MADSU GOPICHAND', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1906', 'GOSTHI ABHIRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1907', 'THIMAPURAM HIMAVARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1908', 'MADEP TEJASREE', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1909', 'MADEP MAHENDER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1910', 'KORRA KRISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1911', 'MALLAGALA GOUTHAMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1912', 'MALLAGALA PARNIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1913', 'BORRATH PRASHASTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1914', 'BORRATH FEEBHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1915', 'BORRATH AKSHAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1916', 'AJITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1917', 'VINITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1918', 'KORRA SRIHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1919', 'VISHNU VARDAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG1920', 'SHARATH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2001', 'VIGNESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2002', 'SAI KRISHNA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2003', 'E.GRACY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2004', 'NIHARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2005', 'HEMALATHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2006', 'MADHURA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2007', 'RISHANK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2008', 'P.SHUSHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2009', 'VAISHALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2010', 'RITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2011', 'PRAVEEN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KG2012', 'REVANTH NAYAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0101', 'CHINTHAKAYALA  ANUSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0102', 'CHINTHAYALA KAVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0103', 'TALARI VIDHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0104', 'SIRIGAPURAM LOKESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0105', 'VADDEPALLY HARSHITH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0106', 'CHINTHAKAYALA UMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0107', 'CHINTHAKAYALA BALAJI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0108', 'CHHINTAKAYALA BHAVYASREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0109', 'CHINTHAYALA MOUNIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0110', 'KOMPALLY MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0111', 'TALARI SHRAVAN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0112', 'PYATA SAHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0113', 'PYATA NOMITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0114', 'PYATA JAYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0115', 'GADDAM MEENAKSHI GOUD', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0116', 'BOYA UMA SREE', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0117', 'BOYA JASHWANTA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0118', 'BOYA PAVAN KALYAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0119', 'KETAVATH MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0120', 'KETAVATH RAKESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0201', 'KOMMU MOHITHESWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0202', 'PALAPARTHI  SAI LAXMI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0203', 'PALAPARTHI RAJESHWAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0204', 'KOMMU STELLA RANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0205', 'HUSSAIN HAMAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0206', 'KURUVA VARUN SANDESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0207', 'SHAKTHI VARSHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0208', 'PUPPALA AISHWARYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0209', 'KOMMU MILKY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0210', 'VERUKUPALLA ADVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0211', 'AMBOTHU KOUSHIK', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0212', 'ADHIKARI NITHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0213', 'GODDA SANVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0214', 'AKULA THARUN YADAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0215', 'AVISHETTY THARUNI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0216', 'HUSSAIN HAMZA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0217', 'MANLA SOWMYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0218', 'MANLA SHIVA KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0219', 'SHAKTHI BHAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0220', 'SHAKTHI PAYAL', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0221', 'PUPPALA HADVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0222', 'VERIKUPALA MANI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0223', 'JALA KAVYA YADAV', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0224', 'JALA AYUSH YADAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0225', 'JALA THANUSH YADAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0226', 'H. AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0301', 'BONKURU MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0302', 'MOHAMMAD ASMA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0303', 'MOHAMMAD RAHIM', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0304', 'KARANAMOLA NANDINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0305', 'KARANAMOLA  BINDU', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0306', 'KORANGIL VEDA VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0307', 'DOBBALI ANANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0308', 'YERIKULA MEENAKSHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0309', 'BOYA BHAVANI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0310', 'CHAKALI CHINTU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0311', 'KARANAMOLA SURYA TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0312', 'DOBBALI AKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0313', 'ADAPU RAM CHANDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0314', 'ADAPU MAHESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0315', 'KORANGIL KERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0316', 'KORANGIL CHAITHRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0317', 'YALSATH KEERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0318', 'YALSATH PAVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0319', 'BONKURU ARAVINDH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0320', 'JOGARA RIBIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0401', 'SAYED SAIF', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0402', 'MOHAMMED AAYAN', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0403', 'SUMIYA FATIMA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0404', 'MOHAMMED AYAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0405', 'MOHAMMED AMAN', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0406', 'NAZEEYA BEE', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0407', 'MOHAMMAD AZAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0408', 'AYESHA SIDDIQUE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0409', 'MOHAMMAD AZIM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0410', 'RIYAN KHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0411', 'MARIYAM FATIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0412', 'MOHAMMAD FARIYA BEGUM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0413', 'MOHAMMAD IBRAHIM', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0414', 'MAIRA FATIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0415', 'SAYED ALI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0416', 'RUMANA MEHVISH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0417', 'MAAHI FATIMA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0418', 'ALINA FATIMA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0419', 'MOHAMMAD ADYAAN', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0420', 'FARHAN KHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0421', 'MOHAMMAD AKBAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0422', 'ZARA FATIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0423', 'BHAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0501', 'BEAMAPOLLU MALLIKARJUN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0502', 'TALARI SUSHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0503', 'KOPPULA NAVADEEP', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0504', 'NENAVATH AJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0505', 'NENAVATH REVANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0506', 'BALEGADDA ABHINAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0507', 'KOMPALLY PRASANNA JYOTHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0508', 'KOMPALLY GUNA VAISHNAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0509', 'KONALA VASANTHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0510', 'BOJJA HARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0511', 'BOJJA VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0512', 'TALARI SRI DURGA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0513', 'YERUKALI VENKATESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0514', 'NENAVATH NISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0515', 'NENAVATH VARDHANMAN RATHOD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0516', 'NENAVATH VIRAJ RATHOD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0517', 'AMBOTH AKSHAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0518', 'AMBOTH SANJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0519', 'YERUKALI NAGESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0520', 'VASPULA RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0521', 'VARAKUMPALA GREETHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0522', 'VARAKUMPALA GREESHMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0523', 'DESHETTI SATHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0524', 'ANAGANI BHARATH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0525', 'MEKALI BHAVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0526', 'MMEKALI AKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0601', 'BALLARY VAJRA', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0602', 'THIPPARAPU BHAVVA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0603', 'CHOWHAN ARUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0604', 'BALLARY VEERA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0605', 'PAWAR SONALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0606', 'PAWAR DEEPTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0607', 'PAWAR NARSIMHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0608', 'CHOWHAN RAJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0609', 'CHOWHAN  AKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0610', 'CHOWHAN ARYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0611', 'PAWAR RADHE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0612', 'SODULU SHIVA SHANKAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0613', 'M.AISHWARYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0614', 'D.GANESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0615', 'M.EASHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0616', 'D.MAHESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0617', 'M.AKASH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0618', 'V.RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0619', 'V.RITHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0620', 'S.SHIVA', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0621', 'D.SWAPNA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0622', 'M.JAI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0623', 'P.VISHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0624', 'P.DEEPTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0625', 'M.MADHU', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0701', 'BOJJA JYOSHNA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0702', 'BOJJA NIHAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0703', 'BOJJA VILAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0704', 'VADDE PARDIV NANDAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0705', 'VADDE MANVIK TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0706', 'BOJA NEERAJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0707', 'BOJA BHANU TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0708', 'PONGULA CHETAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0709', 'PONGULA RACHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0710', 'BOYA DEEPAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0711', 'CHAKALI KARTIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0712', 'RITHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0713', 'KETHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0714', 'DHANVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0801', 'SAKALI SRUTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0802', 'SAKALI VIJAY KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0803', 'RATNAVATH PRANITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0804', 'RAMAVATH PAWANKALYAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0805', 'KATHOLU HARSHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0806', 'ESLAVATH KISHORE', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0807', 'NINAVATH DISHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0808', 'SANTHAGIRI LAXMI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0809', 'BANDARU RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0810', 'BOYA SUSILA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0811', 'BOYA SAI VIKRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0812', 'KARUKONDA DRUTHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0813', 'RAMAVATH VASANTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0814', 'ESLAVATH ANJANIKUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0815', 'RATHLAVAT SREYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0816', 'PATAN AKBAR BASHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0817', 'JOREGALA RAMYASREE', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0818', 'BOYA KOTHAM SWATHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0819', 'SANTHAGIRI HARIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0820', 'KOMPALLY TEJUMAI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0901', 'KETHAVATH GOUTHAMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0902', 'KETHAVATH RISHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0903', 'SABAVATH SHASHWITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0904', 'SABAVATH GAYATHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0905', 'KAVALI RAKESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0906', 'PONGULA DUHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0907', 'GODUGU YASWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0908', 'SAKALI SAI', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0909', 'NINAVATH JASHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0910', 'NINAVATH MADHAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0911', 'REMAVATH VASANTH NAYAK', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0912', 'YERUKALI VARUN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0913', 'U.VARSHITH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0914', 'B.ESHAWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0915', 'P.NITHISH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0916', 'K.SANJANA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0917', 'P.ABHIRAM', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0918', 'P.RAMCHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV0919', 'RUTHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1001', 'CHERUKURI SATHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1002', 'KETHAVATH DEEWANA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1003', 'GODUGU AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1004', 'SOMGURAM YASHESWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1005', 'MUMUDI SWATHI SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1006', 'MUDHA RISHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1007', 'GANDAM JAIKANTH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1008', 'DOMALA GANESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1009', 'MEGHAVATH KARTHIK', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1010', 'MEGHAVATH HEMANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1011', 'SUNKOS VAISHNAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1012', 'PULETHURA MARTIN LUTHER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1013', 'NENAVATH NAVADEEP', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1101', 'KOTIGERI NARESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1102', 'DODDU CHANDHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1103', 'GOUD CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1104', 'KOMPALLY RAKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1105', 'BALEGADDA DEEPU SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1106', 'GOUDDA PRABHAS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1107', 'KONIGIRI JEEVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1108', 'NAWLE BALESHWARA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1109', 'CHINTAKINDI SATHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1110', 'CHAVALA ABHINANDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1111', 'GANDAM PAVAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1201', 'GOTTI AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1202', 'KOPPULA JESHWANTH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1203', 'DHARMAVARAPU LAHARI SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1204', 'KOPPULA ANJI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1205', 'BOODHUR VAISHNAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1206', 'DHARMAVARAPU ADITHYA', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1207', 'MERUGU THANUVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1208', 'RAMAVATH ABHIRAM', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1209', 'ATHATI SIRI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1210', 'KROORA NIHARIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1211', 'MUDAVATH PRINYANKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1212', 'KROORA DEEPIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1213', 'RAMAVATH ABHINAV SAI', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1301', 'MUDHAVATH JAIRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1302', 'MUDHAVATH SAVITHNAYAT', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1303', 'SABAVATH SAI', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1304', 'POPPULA HANISHTHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1305', 'GUNTI VIGNESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1306', 'MUDHAVATH SIDDU', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1307', 'GUNTI ANJALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1308', 'GUNTI VARSHITH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1309', 'PONGULA PRANAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1310', 'MUDAVATH SRISAILAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1311', 'MUDAVATH HINDU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1312', 'SAKULA BHUMIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1313', 'RAMAVATH VAISHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1314', 'RAMAVATH SRIJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1315', 'KETHAVATH GOWTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1316', 'MUDAVATH SINDHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1401', 'GUNTI LOKESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1402', 'GUNTI PAVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1403', 'VANAM SESHWITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1404', 'DOTI HARHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1405', 'GUDDA MANI KANTA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1406', 'AMBOTH LOKESH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1407', 'KATIKELA SHIVA KUMAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1408', 'YERUKALI JAYAKANTH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1409', 'VANAM YOGESHWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1410', 'JETAVATH AKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1411', 'SRIVALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1412', 'JENNI ROHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1501', 'KUNDANAM SAHARSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1502', 'SABHANI DEESHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1503', 'SABHANI AKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1504', 'RAMAVATH GOWTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1505', 'RAMAVATH GOPI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1506', 'T.THAKSITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1507', 'D.SINDHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1508', 'BAIROJU SATHVIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1509', 'K.LAVANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1510', 'T.ESHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1511', 'BAIROJU SAHASRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1512', 'RAMAVATH SAI KIRAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1601', 'CHITHRAM DIVYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1602', 'SABAVATH ASHWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1603', 'CHITHRAM VISHRUTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1604', 'SABAVATH NAGA CHAITANYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1605', 'JANAGAM VAIDEHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1606', 'BIJANAPALLY AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1607', 'KERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1608', 'RAMAVATH AKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1609', 'SABAVATH NANDHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1610', 'CHITHRAM PAVANA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1611', 'JANAGAM SREEJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1612', 'RAMAVATH AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1613', 'MUDAVATH REVATHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1614', 'RAMAVATH ANKITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1701', 'KOPPULA JAYANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1702', 'SABAVATH ROHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1703', 'GANDHAM KARTHIK', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1704', 'MAHIJA NAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1705', 'ESLAVATH ABHINANDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1706', 'PONGULA JANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1707', 'DAVID NAISIN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1708', 'ESLAVATH NAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1709', 'MAHIJA DEEKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1710', 'KAALE AADYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1801', 'KADDARU SATHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1802', 'KADAARU KOMALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1803', 'NAGOLE LAVANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1804', 'MUDAVATH SAKITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1805', 'TALARI VIGNESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1806', 'YERUKALI DHARANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26NV1807', 'MUDAVATH VARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0101', 'K.HARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0102', 'NAZERA FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0103', 'SHIVA KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0104', 'P.DAYANAND', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0105', 'K.PRANAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0106', 'DEEPAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0107', 'HUMEZA SULTHANA', 'Girl', 'U') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0108', 'SABIYA', 'Girl', 'U') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0109', 'SUSKANTH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0110', 'B.HARINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0111', 'SASIKANTH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0112', 'RISHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0113', 'SAJAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0114', 'HAJARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0115', 'SRINIDHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0116', 'B.PRABHAS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0117', 'B.VEENA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0118', 'VENNELA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0119', 'REHMAN KHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0120', 'ALIYA BEGUM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0121', 'HARINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0122', 'KAILASH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0123', 'DEEPANSHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0124', 'SHIVAM KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0125', 'CHAITANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0126', 'MUBEENA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0127', 'MUNNI KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0128', 'MAHESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0129', 'SAFURA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0201', 'DEV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0202', 'MD IMRAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0203', 'SHEKAR KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0204', 'AYUSH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0205', 'SHUSHANTH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0206', 'JANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0207', 'AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0208', 'NARESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0209', 'ASHOK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0210', 'RAM CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0211', 'SAI TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0212', 'PREETHAM KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0213', 'HARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0214', 'TANVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0215', 'ADRITI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0216', 'ROHAN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0217', 'SUSHMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0218', 'AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0219', 'SUMAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0220', 'KAMAL BASHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0221', 'PRIYA DARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0222', 'MOKSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0223', 'YESHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0224', 'MD.AMIR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0225', 'MD.SABEER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0301', 'ANKITHA SAWANTH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0302', 'AVANTHIKA SAWANTH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0303', 'ANUSHKA SAWANTH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0304', 'AYUSH SAWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0305', 'SAI CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0306', 'CHANDANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0307', 'BHAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0308', 'BHAVYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0309', 'JYOSHNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0310', 'MOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0311', 'SOWMYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0312', 'RADHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0313', 'SIDDIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0314', 'SAHASRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0401', 'SAHASRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0402', 'DARSHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0403', 'SRINATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0404', 'HARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0405', 'RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0406', 'SHRUTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0407', 'RITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0408', 'BHANU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0409', 'HANSIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0410', 'REKHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0411', 'RESHMIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0412', 'SUKANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0413', 'MANISHWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0414', 'PAVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0415', 'ABHISHEK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0416', 'SAI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0417', 'JESHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0418', 'AKIRA NANDAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0419', 'KUSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0420', 'NITHYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0501', 'REEBIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0502', 'CHOTU KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0503', 'K.SHIRISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0504', 'SHIVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0505', 'PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0506', 'PAYAL', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0507', 'PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0508', 'ARBIND KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0509', 'ANKUSH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0510', 'M.SINDHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0511', 'HABEEBA BEGUM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0512', 'HANSIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0513', 'BHAVYASRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0514', 'GAYATHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0601', 'ANAND KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0602', 'ALOK KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0603', 'LAXMI KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0604', 'KARNI PRANITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0605', 'ANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0606', 'SHANMUKH RAO', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0607', 'TRIYAMBAKAM PANDITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0608', 'KARNI SRI BHARGAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0609', 'SANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0610', 'ANSHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0611', 'T.GOURI LAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0612', 'NAKKA DASARI MOKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0613', 'T.ARUSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0614', 'BHANSHIN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0615', 'B.RITHVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0616', 'ABDUL ASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0617', 'VIKAS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0618', 'RADHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0619', 'B.JESHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0620', 'NAKKA DASARI CHAITRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0621', 'AYASHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0622', 'FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0623', 'MAHAMMED ASMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0624', 'MAHAMMED DASRAF', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0625', 'SUSANNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0626', 'SURYA TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0627', 'HIMASREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0628', 'RADHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0629', 'VIJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0630', 'SUJITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0701', 'SULTHAN NAKSHATRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0702', 'SULTHAN MOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0703', 'MANDULA .VICKY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0704', 'MANDULA AKASH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0705', 'GUMMADIVELLI VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0706', 'GUMMADIVELLI GOUTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0707', 'B.AKHILA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0708', 'AKKAVATHULA AYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0709', 'ULIGI SUPRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0710', 'AMRUTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0711', 'SIRI VENNELA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0712', 'AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0713', 'VASURANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0714', 'G.ANJALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0715', 'HARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0716', 'B.MAHESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0717', 'SHIVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0718', 'RITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0719', 'RIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0801', 'A.LOUKYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0802', 'A.LASYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0803', 'D.AKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0804', 'D.AKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0805', 'U.JAHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0806', 'U.SHANMUKHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0807', 'U.ADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0808', 'K.AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0809', 'DIKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0810', 'RITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0811', 'NIKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0901', 'ALEKHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0902', 'K.SUSHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0903', 'B.HARISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0904', 'SANVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0905', 'G.YOCHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0906', 'G.SOUMYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0907', 'G.LASYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0908', 'A.CHANDUSRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0909', 'A.YASHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0910', 'NITHIN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0911', 'POORNA CHANDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP0912', 'TEJASHWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1001', 'SRISTI KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1002', 'PRUDHVI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1003', 'LAXMI PRASANNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1004', 'SANGHARSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1005', 'M.PRAJWAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1006', 'GOUTHAMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1007', 'LAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1008', 'K.VIDYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1009', 'E.ADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1010', 'G.GOUTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1011', 'G VARUN TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1012', 'ASIF', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1013', 'J DHARANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1014', 'BHARATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1015', 'A DHEWAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1016', 'K GNAPIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1017', 'K JUSHUA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1018', 'B NITHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1019', 'M BHOMIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1020', 'K HARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1021', 'SAJID', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1022', 'S RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1023', 'M SHARVAN GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1024', 'B SAI PRASANNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1025', 'D RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1026', 'K BHOOMIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1027', 'K PRATHUSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1028', 'B JHANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1029', 'B YAMINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1030', 'M AKASHITA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1031', 'J NIKIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1032', 'A NANDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1033', 'B BHOOMIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1034', 'SIDDI KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1035', 'J SUMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1036', 'K KRISHNA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1037', 'RIDDHI KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1038', 'K NANCY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1039', 'S PRITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1040', 'B SUSHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1041', 'PRITHVEN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1101', 'LAKSHMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1102', 'MUSKAN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1103', 'CHATURYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1104', 'BHUVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1105', 'SANKEERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1106', 'SUSHMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1107', 'DURGA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1108', 'LIKITHA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1109', 'VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1110', 'AMULYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1111', 'VARSHA VARDINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1112', 'HARSHA VARDHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1113', 'VALENTINA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1114', 'VENISSA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1115', 'BHANU PRASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1116', 'NIKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1117', 'KRISHNA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1118', 'RAMBABU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1119', 'KUNAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1120', 'ADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1121', 'UDAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1122', 'ABHIBIND', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1123', 'VIJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1124', 'ATHUL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1201', 'HARI CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1202', 'VYSHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1203', 'RAM CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1204', 'SATHVIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1205', 'VISHNU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1206', 'VEER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1207', 'AKHIRA NANDAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1208', 'SAHISTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1209', 'M.VEER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1210', 'KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1211', 'SAMIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1212', 'TEJAL', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1213', 'USHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1214', 'YASHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1215', 'DUSHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1216', 'DEEKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1217', 'ASMITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1218', 'ISHANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1219', 'SHRAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1220', 'ZOHRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1221', 'SRI VIDHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1222', 'SRI VANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1223', 'AKSHAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1224', 'THANU SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1225', 'VARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1301', 'SUPRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1302', 'SHRUTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1303', 'ABHIGYANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1304', 'SAMIKSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1305', 'SURAJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1306', 'VIKRANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1307', 'MANISHWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1308', 'KUSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1309', 'THARUN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1401', 'JAI RAM TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1402', 'SATHVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1403', 'SARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1404', 'KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1405', 'NADIYA SULTANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1406', 'SATHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1407', 'SRINIDHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1408', 'FARHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1409', 'ESHWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1410', 'DARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1411', 'ARVIND', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1412', 'THANUJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1413', 'BHAVISYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1414', 'SANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1415', 'ABRAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1416', 'ASHWIN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1417', 'PRIYANSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1418', 'THAISEEN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1419', 'HARSHA VARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1420', 'NAGALAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1501', 'KAJAL', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1502', 'RADHAKUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1503', 'PALLAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1504', 'BHAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1505', 'K.ANUSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1506', 'RAM CHARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1507', 'PRABHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1508', 'KANISTA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1509', 'SAI SINDHU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1510', 'NAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1511', 'G. VIDHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1512', 'PRASANNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1513', 'SONA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1514', 'YESHMITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1515', 'DEVANSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1516', 'ADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1517', 'RADINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1518', 'ARUN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1519', 'TANUJ VARMA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1520', 'R.SATHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1521', 'MALLIKARJUN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1522', 'ASHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1523', 'RAGHURAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1524', 'IMRAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1525', 'PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1526', 'AYATHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1527', 'RITHVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1601', 'V.BALARIKSHIT', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1602', 'SAHASHRA GOUTHAMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1603', 'ANANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1604', 'RAGHU VARUN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1605', 'UDAY BALADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1606', 'VISHNU VARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1607', 'HAARINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1608', 'SIDDHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1609', 'GOUTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1610', 'SHIVA PRASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1611', 'JAHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1612', 'SAI VARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1613', 'BALA VIKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1614', 'ROHIT', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26RP1615', 'BHAVAN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0101', 'THURKAPALLY KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0102', 'PALETI KARAN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0103', 'PALETI TEJA KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0104', 'THURKAPALLY VARUN TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0105', 'DUNNA PAVAN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0106', 'DUNNA THARUN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0107', 'RANGOJI ESHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0108', 'RANGOJI NAGESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0109', 'MOHAMAD ZOYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0110', 'MOHAMAD SHAISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0111', 'SHAIK UMAIR', 'Boy', 'U') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0112', 'SHAIK UZMA', 'Girl', 'U') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0113', 'PUTTA INDRAJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0114', 'PUTTA UDAY KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0115', 'ROHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0116', 'CHARANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0117', 'AESHAMALLA UKTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0118', 'PRANAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0119', 'BOGGULA RUCHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0120', 'BOGGULA SHESHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0121', 'SRI VIDHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0122', 'ZEESHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0123', 'MOHAMAD  THABRES', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0124', 'MOHAMAD ALISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0125', 'KOMARAVELLI AKSHITHTEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0201', 'KASAMINA SATHVIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0202', 'AESHAMALLA SRIJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0203', 'KATHIJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0204', 'MUZZAMIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0205', 'HAMSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0206', 'DEEPAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0207', 'PRABHUDAS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0208', 'BHARSHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0209', 'KASANI VARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0210', 'KASANI MANI KANTHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0211', 'KASANI VIGENESH YADAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0212', 'KASANI NAVANETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0213', 'AKASH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0214', 'EDLA LINCY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0215', 'EDLA ARON SAMSUMITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0216', 'KASAMINA RIDWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0217', 'PALETI RAKSHITHA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0218', 'PALETI KEERTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0219', 'EDIA HADDSHA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0220', 'AESHAMALLA KRITHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0221', 'PAVITHRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0222', 'AMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0301', 'MUNDUGULA HARSHAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0302', 'MYADARI NIKHILESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0303', 'MYADARI DEVANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0304', 'MUNDUGULA SHARANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0305', 'CHOUDARY ROSHINI KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0306', 'ABJEETH JAISWAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0307', 'AASHFIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0308', 'ADIBA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0309', 'AYAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0310', 'SIDHARTHA BEZOS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0311', 'MALIGE DHODI SAHASRA PRAGNAA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0401', 'PAMPARI TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0402', 'PATLAWAT SREE VALLI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0403', 'PAMPARI YASHASHWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0404', 'PAMPARI VIJAYA SHREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0405', 'MADHUR KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0406', 'JESSICA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0407', 'JITHENDAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0408', 'JEEVITHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0409', 'HINDUJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0410', 'AKULA GEETHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0411', 'AKULA SUPRITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0412', 'BOMMAKANTI ADHARSH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0413', 'BOMMAKANTI MANVITH', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0414', 'BOMMAKANTI SAMPATH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0415', 'PUJALA NIRMAYI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0416', 'PUJALA NISHKRUTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0417', 'MIKEESHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0418', 'PREETHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0501', 'AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0502', 'JEINFEYASMINH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0503', 'AMULYA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0504', 'HARSHITH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0505', 'LOKESH', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0506', 'DAKSHITH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0507', 'RISHWITH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0508', 'DANUSHREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0509', 'KEERTHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0510', 'CHERRY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0511', 'KERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0512', 'JAWSHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0513', 'DEEPIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0514', 'DIVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0515', 'SAHASRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0516', 'AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0517', 'AVANTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0601', 'TEEGAPURAM JAYANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0602', 'KANDAL CHITRA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0603', 'KANDAL PRANEETH', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0604', 'MANCHARLA PRANATHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0605', 'SHAIK HAJARA SANIA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0606', 'DONAKANTI SRIYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0607', 'ERABAYULA MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0608', 'NAMALA LIKHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0609', 'BORAGALLA RASAGNYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0610', 'TAPPETA SANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0611', 'TAPPETA ANOK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0612', 'ERABAYULU RAGAVENDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0613', 'ERABAYULU DEVENDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0614', 'MARAPALLY VISHMAYI', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0615', 'AKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0616', 'TEEGAPURAM VEDANTH', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0617', 'CHINTALA NAUSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0618', 'CHINTALA DEVA CHANDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0619', 'SHAIK MURTUZA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0620', 'SHAIK MUSTHAFA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0701', 'EALAUANDULA ALANKRUTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0702', 'EALAUANDULA UDITHAXAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0703', 'JANGITI HARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0704', 'SUNCHU ANANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0705', 'SUNCHU RAKSHITHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0706', 'JANJALA PRINCIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0707', 'KAMSANI KOUSHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0708', 'KAMSANI KEDHAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0709', 'CHITTYALA AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0710', 'JANGITI PURVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0711', 'JANGITI RITHVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0712', 'JANGITI CHARANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0713', 'JANGITI TEJASRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0714', 'GADDAM YASHASWI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0715', 'GADDAM YOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0716', 'THALAPALLY ASHISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0717', 'DUDDEDA SHRESHTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0718', 'NAGINIDE JOEL', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0719', 'NAGINIDE PAVITRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0801', 'GELUKARA NIDHISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0802', 'PRIYANSHU SINGH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0803', 'K ANKITHA YADAV', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0804', 'SUPRIYA SINGH', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0805', 'CHINTHA MOKSHIT', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0806', 'POTAKARI MANANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0807', 'SOUDURU KOMALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0808', 'GADDAPATI ABHILASH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0809', 'SHAIK SANIA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0810', 'PADVGUMMALU YADAIAH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0811', 'RADAPAKA SRI HALYA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0812', 'GUNJAKAR AAROHI', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0813', 'BODDU MAHA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0814', 'BATTA RAKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0815', 'BATTA VINITH VARSHAN', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0816', 'SHAIK SUHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0817', 'BONTHA HARSHITHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0818', 'BONTHA AMULYA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0819', 'KASANI THARUN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0820', 'GELULARA CHASIKA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0821', 'K.DHANUSHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0822', 'V.PRANEETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0823', 'MD.ARMAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0824', 'V.MUKESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0825', 'PILLI RAMYA SRI', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0901', 'BALURUGU SREE ARADHMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0902', 'VEMULA KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0903', 'BANOTH LAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0904', 'ORSU SANKEERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0905', 'ORSU THANUJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0906', 'ORSU RISHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0907', 'BALURUGU DINESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0908', 'MAKKALA THANUJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0909', 'MAKKALA SRIHIK TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0910', 'ORAGANTI DHAYVAKRUPA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0911', 'BONTHA AADHYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0912', 'BONTHA ADVIKTEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0913', 'SHIVARATHRI GANESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0914', 'SHIVARATHRI THARUN TEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0915', 'BOLLEDULA KEERTHI SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0916', 'GOLLENA BHARADWAJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG0917', 'BONTHA BRUVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1001', 'ALAKUNTA VARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1002', 'CHARLAPALLY HARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1003', 'DAYYALA THANMAYU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1004', 'DAYYALA YAKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1005', 'SHIVARATHRI STELLA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1006', 'ORSU AKHILA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1007', 'VALLAPU KULPA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1008', 'ALAKUNTLA SANMUKTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1009', 'PALLAPU HANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1010', 'CHARLAPALLY VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1011', 'CHARLAPALLU MOKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1012', 'SHIVARATHRI AMMULU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1013', 'SHERLA DEEKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1014', 'SHIVARATHRI AJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1015', 'VADLAKONDA RESHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1016', 'BITKUR ROHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1017', 'SADEVADA BAVESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1018', 'PONNA SAI PRANEETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1019', 'BABARAV INGALE SHREYASH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1020', 'BITKURI VEDANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1021', 'CHIRRA VIGENESWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1022', 'CHIRRA SMANSI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1023', 'PONNA DURGA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1024', 'BITKURI GOUTHAM BHAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1101', 'MABITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1102', 'EDIGI SHIVARSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1103', 'KUKKALA SALOMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1104', 'KUKKALA VINAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1105', 'GURIKALA THARUNTEJA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1106', 'EDIGI SHIVA SHANKAR GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1107', 'BHAGYARI VISHAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1108', 'KOLLI LAKSHMI NATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1109', 'AMMULU', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1110', 'URIBAITI JAHNAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1111', 'KESHAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1112', 'AKSHAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1201', 'MASTAN BEE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1202', 'KARINNISA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1203', 'ABDUL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1204', 'VIKRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1205', 'CHINDAM SHASHANK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1206', 'JANGIR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1207', 'AYESHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1208', 'KAREEMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1209', 'JAKKALURU RANGANATHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1210', 'VIDYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1211', 'BHAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1212', 'SOHAIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1301', 'AMREEN BHAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1302', 'SYED AMREEN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1303', 'SYED BIBI HAZEERA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1304', 'SYED MAHABOOBEE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1305', 'SYED NASRIN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1306', 'SYED RAMEEZA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1307', 'BOYA SANJANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1308', 'VISHNU PRIYANKA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1309', 'SHAIK SUMERA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1310', 'SHAIK AMREEN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1311', 'AMMULU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1312', 'MEGHAMALA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1313', 'RAHUL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1314', 'SHAIK JHANGIR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1401', 'GONE AARSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1402', 'GONE DEEKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1403', 'GANDHAM CHETAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1404', 'GANDHAM PRANVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1405', 'GANDHAMALLA MANIKANTA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1406', 'DANDEMA KIRANANDAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1407', 'DANDEM VEDHAMSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1408', 'CHINTAKAYALA BHAVISHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1409', 'PALLAPU BHAVYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1501', 'NAIKEE MAMATHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1502', 'NAIKEE SIRISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1503', 'NAIKEE RADHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1504', 'LASKAR HAMSIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1505', 'AKANSHA SHINDA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1506', 'AKANSHA AKASHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1507', 'ERRA MANISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1508', 'ERRA AANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1509', 'JOGU MARGAVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1510', 'PAKA SHIVAPRASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1511', 'DANDEM DIVYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1512', 'PAKA THANUSRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1513', 'DANTERPALLY PRASHAATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1514', 'DANTERPALLY SUSHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1601', 'VAISHANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1602', 'P VARSHENI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1603', 'VARSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1604', 'S KOMALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1605', 'P PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1606', 'S ANKITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1607', 'J LAHARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1608', 'J LAVANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1609', 'S VYSHANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1610', 'J PRARDHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1611', 'SRILAKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1612', 'J NEVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1613', 'A TULASI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1614', 'J POOMA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1615', 'S GRASY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1616', 'P MAHIPAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1617', 'SATHVIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1618', 'JASSIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1619', 'AISHU', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26AG1620', 'SAMEL RAJU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0101', 'BOLA NANDHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0102', 'BOLA KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0103', 'ANNARAM PARINITHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0104', 'ANNARAM LASYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0105', 'GOUTHAM KOWSHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0106', 'VARSHA GOUTHAM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0107', 'DAVULAGARI GOUTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0108', 'NAGAPUR ADVITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0109', 'CHINTHAPALLY SHARANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0110', 'CHINTHAPALLY SRIVALLI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0111', 'BOGI VINDHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0112', 'PULDANDI RIYANSHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0113', 'PULDANDI VANSHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0114', 'GAMINI SAAHUS PRINCE', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0115', 'MYATHARI JOSEPH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0116', 'MYTHARI SAMUEL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0117', 'A MANJU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0118', 'A ANJU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0119', 'ARSHU GOUTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0120', 'ARVI GOUTHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0121', 'SANDHEEP KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0122', 'BATNA BHRAKSHAYINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0123', 'NAKKA ABHIMANYU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0124', 'NAKKA VENKATESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0125', 'NAKKA JESHVANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0126', 'A PREETI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0127', 'B GREESHMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0128', 'B BHAVYA SHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0129', 'AAKANKSHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0130', 'BANOTH HEMA SAI BINDU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0131', 'BANOTH PRANEETH TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0132', 'BEGARI PRANAY KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0133', 'S VRISHANK SAGAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0134', 'S SHASHANK SAGAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0135', 'K YASHASVI SAROJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0136', 'ARYAN SAROJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0137', 'SAROJ ARADHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0138', 'P ANKITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0139', 'AYUSH SAROJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0140', 'N NITHYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0141', 'T ABHINAV TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0142', 'V VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0143', 'V VYSHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0144', 'K VANSHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0145', 'CH KOUSHAL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0146', 'B KRISHNAVENI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0201', 'VEMULA HARSHAVARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0202', 'VEMULA YAMINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0203', 'VEMULA PALLAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0204', 'ASNAGARI PRINCE', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0205', 'ASNAGARI PRANAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0206', 'ASNAGARI PRANEETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0207', 'M SANVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0208', 'M HANVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0209', 'M YOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0210', 'G YOKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0211', 'GADDAPARA SATHVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0212', 'V SAI KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0213', 'GUNTI AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0214', 'GUNTI ADITHYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0215', 'KAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0216', 'G PAVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0217', 'M JOHNY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0218', 'G AKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0219', 'AAVULA HEMA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0220', 'AAVULA VARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0221', 'P NEHANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0222', 'P VIHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0301', 'P KRITHIKESHWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0302', 'P SAI PRANAY YADAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0303', 'U DHANUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0304', 'K AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0305', 'U BHAVIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0306', 'M RANI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0307', 'M PRABHU', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0308', 'E ABHISHEK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0309', 'G SAI PALLAVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0310', 'G LASYA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0311', 'E MANASREE', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0312', 'K HARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0313', 'K AVANTHIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0314', 'K SRIVALLI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0315', 'P DEEPTHI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0316', 'B PENTAIAH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0317', 'D PRANAY KUMAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0318', 'D GOUTHAMI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0319', 'V SIRISHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0320', 'E ABHINAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0321', 'G LAHARIKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0322', 'G MADHAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0323', 'K JAHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0324', 'P JAYASREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0325', 'P ANANYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0326', 'M DURGESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0327', 'P HARSHAVARDHAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0328', 'M SUHASINI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0329', 'ROHIT REDDY', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0330', 'VIJAY KUMAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0331', 'K JAYASREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0332', 'K AADHYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0333', 'K VIKRAM', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0401', 'SK AKBAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0402', 'SK ASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0403', 'THALHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0404', 'AYESHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0405', 'ISMAIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0406', 'MUZAFFER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0407', 'BUSHRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0408', 'RAHEEM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0409', 'SANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0410', 'ALINA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0411', 'SD ASAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0412', 'SYED AYESHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0413', 'ALISHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0414', 'AKBAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0415', 'FASIYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0416', 'RAHEN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0417', 'SOHAIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0418', 'MAHIRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0419', 'SIDDIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0420', 'SADHEKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0501', 'S MANIKANTA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0502', 'S OMKAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0503', 'S POOJITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0504', 'S JYOSHNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0505', 'P SHUBHAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0506', 'P HEMASREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0507', 'D RAGHAVENDRA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0508', 'M SIDDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0509', 'D BHARATH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0510', 'P SRINIDHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0511', 'P HARSHA VARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0512', 'K POOJITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0513', 'K MOKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0514', 'B JAHANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0515', 'K DEEPIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0516', 'D SOMBA SHEKAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0517', 'K YUVARAJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0518', 'K NIHARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0519', 'K YUVA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0520', 'K KUSAM CHANDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0521', 'D CHARAN TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0522', 'D RAJIV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0523', 'NAGESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0524', 'JYOTESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0525', 'JANSI PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0526', 'M DURYODHANA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0527', 'SAI PRIYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0528', 'ESHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0601', 'PONNADA AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0602', 'K ANANYA YADAV', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0603', 'K AKRUTHI YADAV', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0604', 'J NIKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0605', 'J JEEVANA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0606', 'S LAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0607', 'S JHANSI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0608', 'B KOUSHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0609', 'B CHAITHANYA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0610', 'B DEEKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0611', 'B JAHANAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0612', 'A JASWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0613', 'D SAHITHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0614', 'G NANDHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0615', 'B SANKETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0616', 'B SATHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0617', 'MONALISA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0618', 'Y SATHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0619', 'ARCHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0620', 'Y KATHYAYINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0621', 'D LIKITH SAI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0622', 'S CHANDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0623', 'GUNNA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0624', 'B RAHUL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0625', 'B MALLESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0626', 'B PAVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0627', 'T SHANKAR RAO', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0628', 'T HEMA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0629', 'VISHNU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0630', 'LASYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0631', 'SOHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0701', 'SYED ARHAAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0702', 'SYED ARMAAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0703', 'D MAHEER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0704', 'D CHANDRIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0705', 'AISHA VEAN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0706', 'J ABHISHEK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0707', 'V SEVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0708', 'SYED MUKTHADIR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0709', 'P PRIYANSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0710', 'P AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0711', 'B BHAVIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0712', 'B SARTHAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0713', 'ANUSHKA SAI KUMAR SURYA VAMSI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0714', 'K RAKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0715', 'K VAISHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0716', 'DEVARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0717', 'T SWAPNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0718', 'P CHANDINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0719', 'P BHAGYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0720', 'ALIZA NAAZ', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0721', 'MOHAMMAS AZAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0801', 'B JOSHNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0802', 'B RASHMITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0803', 'T ABHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0804', 'D JASHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0805', 'N OOHARANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0806', 'T RUSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0807', 'M LASYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0808', 'M DINESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0809', 'N JAYAVARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0810', 'R SANTHOSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0811', 'D MOHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0812', 'T TEJASWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0813', 'T SHARMILA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0814', 'A TEJASWINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0815', 'N MOHANSAI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0816', 'A RAMYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0817', 'A BUJJI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0818', 'N YOCHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0901', 'G HEMA CHANDRIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0902', 'G PRERANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0903', 'G MOKSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0904', 'T AKANSHA THARUK', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0905', 'O JOSHEPH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0906', 'M AMITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0907', 'T NIKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0908', 'CH SUNIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0909', 'T HARSHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0910', 'M AMRUTHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0911', 'P LATHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0912', 'MOUNIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0913', 'SINDHURA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0914', 'JASHVEER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0915', 'AISWARYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0916', 'B RUPA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0917', 'B AKSHARA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP0918', 'CHANDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1001', 'M PRAGNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1002', 'RUTHWIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1003', 'KOLLI HARSHITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1004', 'AKKALDEV UJWALA YADAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1005', 'AKKALDEV BHAVIKA YADAV', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1006', 'K THARAKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1007', 'TULASI KAVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1008', 'VAJJULA NIHARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1009', 'SATHWIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1010', 'KOTHA HEMANTH NAIDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1011', 'KOLLI NAVANEETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1012', 'K SAI THARUN TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1013', 'KOTHA MOUNIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1101', 'LAV KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1102', 'KUSH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1103', 'GOVIND KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1104', 'PRETHAM KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1105', 'KISHAN KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1106', 'M MANIKANTA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1107', 'ADITHYA KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1108', 'GANESH KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1109', 'VIJAY KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1110', 'VISHNU KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1111', 'REETHA KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1112', 'KARTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1113', 'T MANIKANTA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1114', 'ADITHYA GIRI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1115', 'RAJVEERGIRI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1116', 'SATYAMGIRI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1117', 'KRISHNA KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1201', 'B KALEBU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1202', 'MORLA SAI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1203', 'MORLA VAIBHAV TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1204', 'V RANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1205', 'SNEHA KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1206', 'ISHIKA KUMARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1207', 'S SHIVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1208', 'M SWATHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1209', 'G ANURADHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1210', 'G DEVID VARMA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1211', 'G PAVAN KUMAR', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1212', 'M VISHRUTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1213', 'ANSH', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1214', 'RASHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1215', 'RITESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1216', 'ADDITHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1217', 'SHIVANI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1301', 'K SRI LAXMI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1302', 'K DINESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1303', 'K MOUNIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1304', 'YAGNA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1305', 'MANOJ KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1306', 'SANVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1307', 'SAHASRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1308', 'RIKVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1309', 'VARSHITHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1310', 'K MANOJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1311', 'K HASINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1314', 'ASHA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1315', 'ARCHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1316', 'BAJRANGI', 'Boy', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26MP1317', 'MANDEEP', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0101', 'SURYA VAMSHI MALHARI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0102', 'SANDEPAGALA MAHENDER', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0103', 'OMKAR RATHOD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0104', 'MADDE ASHOK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0105', 'V. GUNAVARDHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0106', 'RATHOD POOJA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0107', 'MUDAVATH AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0108', 'CHITLAPALLY MINAKSHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0109', 'GUNNA MANOJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0110', 'SANGETAGOLA BUNNY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0111', 'V.CHETRAN KRISHNA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0112', 'ADDALA MOHINI DURGA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0113', 'KAKI MADDILETI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0114', 'KETHAPALLY INDU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0115', 'RATHOD KARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0116', 'REHANA BEGUM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0117', 'AMGOTH VISHAL NAYAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0118', 'KETHAPALLY NANDANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0119', 'CHAKALI CHAMUNDESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0120', 'KALAYAMULA KOUSHIK YADAV', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0121', 'CHINTA ABHINAVA SAKETH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0122', 'BANDALA ANIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0123', 'JANNE MANOJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0124', 'DASARAJULA SAI KIRAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0125', 'ALAKANTI MANISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0126', 'POTHUGANTI PRAMOD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0127', 'PUTTAPAKULA PRANITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0128', 'TADIGREESHMA REDDY', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0129', 'YATALARAMCHARAN', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0130', 'MADDE ANJALI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0131', 'RAMAVATH PREMKARTHIK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0201', 'PARI TIWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0202', 'ANURAG TIWARI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0203', 'ANUSHKA RAJ', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0204', 'ADARSH RAJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0205', 'RALI JAYANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0206', 'KOCHERALA DAVID', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0207', 'GUNNA AVANTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0208', 'M. MAMATHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0209', 'RATHOD NIDHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0210', 'RATHOD NITHYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0211', 'GANGA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0212', 'KAMBLE KARAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0213', 'U DHANASRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0214', 'HARIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0215', 'DEVIKA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0216', 'DIVYA', 'Girl', NULL) ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0217', 'ANU SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0218', 'NITHYA SRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0219', 'REHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0220', 'MOHAMMAD VALIANUDDIN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0221', 'PATLAVATH SHAMKU', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0222', 'PAVAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0223', 'SUFIYA BEGUM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0224', 'A DEEKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0225', 'TADAV NAVYA SREE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0226', 'BODDEPALLI JAHNAVI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0227', 'RISHI VARDHAN GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0228', 'U. MANASA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0229', 'AUGUSTEEN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0230', 'VINAY NAYAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0301', 'SANJUPAJAL ANU', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0302', 'RATHOD NEHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0303', 'RATHOD HARSHA VARDHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0304', 'KAPIL NARSHING UTKAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0305', 'RATHOD ASWITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0306', 'M.MAHESH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0307', 'ARJUN NAYAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0308', 'GOUNIKADI ABHIRAM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0309', 'SIRUVATI BANU TEJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0310', 'AHAM RAJ', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0311', 'CHITLAPALI MYTHRI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0312', 'CHITLAPALI MAHESHWARI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0313', 'TANVITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0314', 'AKKIMANI SAHASRA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0315', 'POTHUGANTI SAI KEERTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0316', 'JAMES', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0317', 'RATHOD SHIVA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0318', 'MOODE KEERTHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0319', 'M.GOURI NANDAN NAYAK', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0320', 'N. RENUKA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0321', 'E. NEHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0401', 'SHRUTHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0402', 'S HARSHINI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0403', 'MEKALA VAMSHI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0404', 'MEKALA AJITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0405', 'PREETHI', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0406', 'SHUSVANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0407', 'KAUR DIVYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0408', 'ORUSU RAJESHWAR', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0409', 'NISHWANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0501', 'MOHAMMAD ZAIN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0502', 'MOHAMMAD ZEESHAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0503', 'MOHAMMAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0504', 'SADIYA SULTANA', 'Girl', 'U') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0505', 'NIMRA NAAZ', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0506', 'FIRDOUS', 'Girl', 'U') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0507', 'MOHAMMAD HASNES REHEM', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0508', 'SHAIK NUSEEBA NOOR', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0509', 'SHAIK SAFAAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0510', 'MOHAMMAD OMER PASHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0511', 'AQSA FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0512', 'ALIZA FATIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0513', 'MOHAMMAD ANAS', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0514', 'MOHAMMAD ARFATH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0515', 'AYESHA FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0516', 'MARIYAM FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0517', 'ZAINAB FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0518', 'KHADIJA FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0519', 'MARIYAM', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0520', 'ZERA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0521', 'SAMAD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0522', 'SHOYEB', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0523', 'SHIREEN', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0524', 'SHIFA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0525', 'AYAAN', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0601', 'PUPPAL AKHIL', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0602', 'K GEETHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0603', 'VADDERA MEGHANA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0604', 'KOMMU VIVEK MADHU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0605', 'VADDERA SANDEEP', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0606', 'GNANADEEPIKA DULGAJ', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0607', 'MD MUDASIR ABDUL MUKHID', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0608', 'LETLA ESHWAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0609', 'DOMATI SAI CHANDU', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0610', 'SHARANYA SRI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0611', 'DUDEKULA ASIYA FATHIMA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0612', 'VEDDERA SANDEEP', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0613', 'VEVAN REDDY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0614', 'M SAMATHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0615', 'G JAINITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0616', 'SANJAY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0617', 'PULICHERLA MOHAN SAI ARUN TEJ REDDY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0618', 'J VIJENDRA VARMA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0619', 'LAW KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0620', 'N PUSHPA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0621', 'K SNEHA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0622', 'K AARVI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0623', 'PULICHERIA SAI DURGATHRISANK REDDY', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0624', 'SHANIGARAM MANVITH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0701', 'PATHAKOTI HEMANTH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0702', 'PATHAKOTI SAI ESHWAR', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0703', 'KUNCHALA MOHIT KUMAR', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0704', 'DOMATI DEEKSHITHA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0705', 'CHIDUGU BHANU PRASAD GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0706', 'CHIDUGU ASHWITH GOUD', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0707', 'MYATHARI MANISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0708', 'E SHIVA PRASANNA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0709', 'CHAKALI  AKHILA', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0710', 'B AMIT ACHARI', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0711', 'S AKSHAYA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0712', 'KRUTHIKA', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0713', 'VADDERN KIRANMAYE', 'Girl', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0714', 'LINGALA DIVYA SREE', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0715', 'B PRAVEEN ACHARI', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0716', 'NARASIMHA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0717', 'A SATISH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0718', 'GUDEPU SHIVA', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0801', 'BODA DEVANUSH', 'Boy', 'E') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0802', 'ASIS KUMAR DIGAJ', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0803', 'VADDE ABHINASH', 'Boy', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_master (student_code, student_name, gender, medium) VALUES ('26KP0804', 'RAJIYA KUMARI', 'Girl', 'T') ON CONFLICT (student_code) DO NOTHING;
INSERT INTO student_center_assignment (student_id, center_id, academic_year_id, active_flag)
SELECT sm.student_id, tc.center_id, ay.academic_year_id, TRUE
FROM (VALUES
('26KG0101','26KG01'),
('26KG0102','26KG01'),
('26KG0103','26KG01'),
('26KG0104','26KG01'),
('26KG0105','26KG01'),
('26KG0106','26KG01'),
('26KG0107','26KG01'),
('26KG0108','26KG01'),
('26KG0109','26KG01'),
('26KG0110','26KG01'),
('26KG0111','26KG01'),
('26KG0112','26KG01'),
('26KG0113','26KG01'),
('26KG0114','26KG01'),
('26KG0115','26KG01'),
('26KG0116','26KG01'),
('26KG0117','26KG01'),
('26KG0118','26KG01'),
('26KG0119','26KG01'),
('26KG0120','26KG01'),
('26KG0121','26KG01'),
('26KG0122','26KG01'),
('26KG0201','26KG02'),
('26KG0202','26KG02'),
('26KG0203','26KG02'),
('26KG0204','26KG02'),
('26KG0205','26KG02'),
('26KG0206','26KG02'),
('26KG0207','26KG02'),
('26KG0208','26KG02'),
('26KG0209','26KG02'),
('26KG0210','26KG02'),
('26KG0211','26KG02'),
('26KG0212','26KG02'),
('26KG0213','26KG02'),
('26KG0214','26KG02'),
('26KG0215','26KG02'),
('26KG0216','26KG02'),
('26KG0217','26KG02'),
('26KG0218','26KG02'),
('26KG0219','26KG02'),
('26KG0220','26KG02'),
('26KG0221','26KG02'),
('26KG0222','26KG02'),
('26KG0223','26KG02'),
('26KG0301','26KG03'),
('26KG0302','26KG03'),
('26KG0303','26KG03'),
('26KG0304','26KG03'),
('26KG0305','26KG03'),
('26KG0306','26KG03'),
('26KG0307','26KG03'),
('26KG0308','26KG03'),
('26KG0309','26KG03'),
('26KG0310','26KG03'),
('26KG0311','26KG03'),
('26KG0312','26KG03'),
('26KG0313','26KG03'),
('26KG0314','26KG03'),
('26KG0315','26KG03'),
('26KG0316','26KG03'),
('26KG0317','26KG03'),
('26KG0318','26KG03'),
('26KG0319','26KG03'),
('26KG0320','26KG03'),
('26KG0321','26KG03'),
('26KG0322','26KG03'),
('26KG0323','26KG03'),
('26KG0324','26KG03'),
('26KG0325','26KG03'),
('26KG0326','26KG03'),
('26KG0327','26KG03'),
('26KG0328','26KG03'),
('26KG0329','26KG03'),
('26KG0330','26KG03'),
('26KG0331','26KG03'),
('26KG0332','26KG03'),
('26KG0333','26KG03'),
('26KG0334','26KG03'),
('26KG0401','26KG04'),
('26KG0402','26KG04'),
('26KG0403','26KG04'),
('26KG0404','26KG04'),
('26KG0405','26KG04'),
('26KG0406','26KG04'),
('26KG0407','26KG04'),
('26KG0408','26KG04'),
('26KG0409','26KG04'),
('26KG0410','26KG04'),
('26KG0411','26KG04'),
('26KG0412','26KG04'),
('26KG0413','26KG04'),
('26KG0414','26KG04'),
('26KG0415','26KG04'),
('26KG0416','26KG04'),
('26KG0417','26KG04'),
('26KG0501','26KG05'),
('26KG0502','26KG05'),
('26KG0503','26KG05'),
('26KG0504','26KG05'),
('26KG0505','26KG05'),
('26KG0506','26KG05'),
('26KG0507','26KG05'),
('26KG0508','26KG05'),
('26KG0509','26KG05'),
('26KG0510','26KG05'),
('26KG0511','26KG05'),
('26KG0512','26KG05'),
('26KG0513','26KG05'),
('26KG0514','26KG05'),
('26KG0601','26KG06'),
('26KG0602','26KG06'),
('26KG0603','26KG06'),
('26KG0604','26KG06'),
('26KG0605','26KG06'),
('26KG0701','26KG07'),
('26KG0702','26KG07'),
('26KG0703','26KG07'),
('26KG0704','26KG07'),
('26KG0705','26KG07'),
('26KG0706','26KG07'),
('26KG0801','26KG08'),
('26KG0802','26KG08'),
('26KG0803','26KG08'),
('26KG0804','26KG08'),
('26KG0805','26KG08'),
('26KG0806','26KG08'),
('26KG0807','26KG08'),
('26KG0808','26KG08'),
('26KG0809','26KG08'),
('26KG0810','26KG08'),
('26KG0811','26KG08'),
('26KG0812','26KG08'),
('26KG0813','26KG08'),
('26KG0814','26KG08'),
('26KG0901','26KG09'),
('26KG0902','26KG09'),
('26KG0903','26KG09'),
('26KG0904','26KG09'),
('26KG0905','26KG09'),
('26KG0906','26KG09'),
('26KG0907','26KG09'),
('26KG0908','26KG09'),
('26KG0909','26KG09'),
('26KG0910','26KG09'),
('26KG0911','26KG09'),
('26KG0912','26KG09'),
('26KG0913','26KG09'),
('26KG0914','26KG09'),
('26KG0915','26KG09'),
('26KG0916','26KG09'),
('26KG0917','26KG09'),
('26KG0918','26KG09'),
('26KG1006','26KG10'),
('26KG1007','26KG10'),
('26KG1008','26KG10'),
('26KG1009','26KG10'),
('26KG1010','26KG10'),
('26KG1011','26KG10'),
('26KG1012','26KG10'),
('26KG1013','26KG10'),
('26KG1014','26KG10'),
('26KG1015','26KG10'),
('26KG1016','26KG10'),
('26KG1017','26KG10'),
('26KG1018','26KG10'),
('26KG1019','26KG10'),
('26KG1020','26KG10'),
('26KG1101','26KG11'),
('26KG1102','26KG11'),
('26KG1103','26KG11'),
('26KG1104','26KG11'),
('26KG1105','26KG11'),
('26KG1106','26KG11'),
('26KG1107','26KG11'),
('26KG1108','26KG11'),
('26KG1109','26KG11'),
('26KG1110','26KG11'),
('26KG1111','26KG11'),
('26KG1112','26KG11'),
('26KG1113','26KG11'),
('26KG1114','26KG11'),
('26KG1115','26KG11'),
('26KG1116','26KG11'),
('26KG1117','26KG11'),
('26KG1118','26KG11'),
('26KG1119','26KG11'),
('26KG1120','26KG11'),
('26KG1201','26KG12'),
('26KG1202','26KG12'),
('26KG1203','26KG12'),
('26KG1204','26KG12'),
('26KG1205','26KG12'),
('26KG1206','26KG12'),
('26KG1207','26KG12'),
('26KG1208','26KG12'),
('26KG1209','26KG12'),
('26KG1210','26KG12'),
('26KG1211','26KG12'),
('26KG1212','26KG12'),
('26KG1213','26KG12'),
('26KG1301','26KG13'),
('26KG1302','26KG13'),
('26KG1303','26KG13'),
('26KG1304','26KG13'),
('26KG1305','26KG13'),
('26KG1306','26KG13'),
('26KG1307','26KG13'),
('26KG1308','26KG13'),
('26KG1309','26KG13'),
('26KG1310','26KG13'),
('26KG1311','26KG13'),
('26KG1312','26KG13'),
('26KG1313','26KG13'),
('26KG1314','26KG13'),
('26KG1315','26KG13'),
('26KG1316','26KG13'),
('26KG1317','26KG13'),
('26KG1318','26KG13'),
('26KG1319','26KG13'),
('26KG1320','26KG13'),
('26KG1321','26KG13'),
('26KG1322','26KG13'),
('26KG1401','26KG14'),
('26KG1402','26KG14'),
('26KG1403','26KG14'),
('26KG1404','26KG14'),
('26KG1405','26KG14'),
('26KG1406','26KG14'),
('26KG1407','26KG14'),
('26KG1408','26KG14'),
('26KG1501','26KG15'),
('26KG1502','26KG15'),
('26KG1503','26KG15'),
('26KG1504','26KG15'),
('26KG1505','26KG15'),
('26KG1506','26KG15'),
('26KG1507','26KG15'),
('26KG1508','26KG15'),
('26KG1509','26KG15'),
('26KG1510','26KG15'),
('26KG1511','26KG15'),
('26KG1512','26KG15'),
('26KG1513','26KG15'),
('26KG1514','26KG15'),
('26KG1601','26KG16'),
('26KG1602','26KG16'),
('26KG1603','26KG16'),
('26KG1604','26KG16'),
('26KG1605','26KG16'),
('26KG1606','26KG16'),
('26KG1607','26KG16'),
('26KG1608','26KG16'),
('26KG1609','26KG16'),
('26KG1610','26KG16'),
('26KG1611','26KG16'),
('26KG1612','26KG16'),
('26KG1613','26KG16'),
('26KG1614','26KG16'),
('26KG1615','26KG16'),
('26KG1616','26KG16'),
('26KG1617','26KG16'),
('26KG1618','26KG16'),
('26KG1701','26KG17'),
('26KG1702','26KG17'),
('26KG1703','26KG17'),
('26KG1704','26KG17'),
('26KG1705','26KG17'),
('26KG1706','26KG17'),
('26KG1707','26KG17'),
('26KG1708','26KG17'),
('26KG1709','26KG17'),
('26KG1710','26KG17'),
('26KG1711','26KG17'),
('26KG1712','26KG17'),
('26KG1713','26KG17'),
('26KG1714','26KG17'),
('26KG1715','26KG17'),
('26KG1716','26KG17'),
('26KG1717','26KG17'),
('26KG1801','26KG18'),
('26KG1802','26KG18'),
('26KG1803','26KG18'),
('26KG1804','26KG18'),
('26KG1805','26KG18'),
('26KG1806','26KG18'),
('26KG1807','26KG18'),
('26KG1808','26KG18'),
('26KG1809','26KG18'),
('26KG1810','26KG18'),
('26KG1811','26KG18'),
('26KG1812','26KG18'),
('26KG1813','26KG18'),
('26KG1814','26KG18'),
('26KG1815','26KG18'),
('26KG1901','26KG19'),
('26KG1902','26KG19'),
('26KG1903','26KG19'),
('26KG1904','26KG19'),
('26KG1905','26KG19'),
('26KG1906','26KG19'),
('26KG1907','26KG19'),
('26KG1908','26KG19'),
('26KG1909','26KG19'),
('26KG1910','26KG19'),
('26KG1911','26KG19'),
('26KG1912','26KG19'),
('26KG1913','26KG19'),
('26KG1914','26KG19'),
('26KG1915','26KG19'),
('26KG1916','26KG19'),
('26KG1917','26KG19'),
('26KG1918','26KG19'),
('26KG1919','26KG19'),
('26KG1920','26KG19'),
('26KG2001','26KG20'),
('26KG2002','26KG20'),
('26KG2003','26KG20'),
('26KG2004','26KG20'),
('26KG2005','26KG20'),
('26KG2006','26KG20'),
('26KG2007','26KG20'),
('26KG2008','26KG20'),
('26KG2009','26KG20'),
('26KG2010','26KG20'),
('26KG2011','26KG20'),
('26KG2012','26KG20'),
('26NV0101','26NV01'),
('26NV0102','26NV01'),
('26NV0103','26NV01'),
('26NV0104','26NV01'),
('26NV0105','26NV01'),
('26NV0106','26NV01'),
('26NV0107','26NV01'),
('26NV0108','26NV01'),
('26NV0109','26NV01'),
('26NV0110','26NV01'),
('26NV0111','26NV01'),
('26NV0112','26NV01'),
('26NV0113','26NV01'),
('26NV0114','26NV01'),
('26NV0115','26NV01'),
('26NV0116','26NV01'),
('26NV0117','26NV01'),
('26NV0118','26NV01'),
('26NV0119','26NV01'),
('26NV0120','26NV01'),
('26NV0201','26NV02'),
('26NV0202','26NV02'),
('26NV0203','26NV02'),
('26NV0204','26NV02'),
('26NV0205','26NV02'),
('26NV0206','26NV02'),
('26NV0207','26NV02'),
('26NV0208','26NV02'),
('26NV0209','26NV02'),
('26NV0210','26NV02'),
('26NV0211','26NV02'),
('26NV0212','26NV02'),
('26NV0213','26NV02'),
('26NV0214','26NV02'),
('26NV0215','26NV02'),
('26NV0216','26NV02'),
('26NV0217','26NV02'),
('26NV0218','26NV02'),
('26NV0219','26NV02'),
('26NV0220','26NV02'),
('26NV0221','26NV02'),
('26NV0222','26NV02'),
('26NV0223','26NV02'),
('26NV0224','26NV02'),
('26NV0225','26NV02'),
('26NV0226','26NV02'),
('26NV0301','26NV03'),
('26NV0302','26NV03'),
('26NV0303','26NV03'),
('26NV0304','26NV03'),
('26NV0305','26NV03'),
('26NV0306','26NV03'),
('26NV0307','26NV03'),
('26NV0308','26NV03'),
('26NV0309','26NV03'),
('26NV0310','26NV03'),
('26NV0311','26NV03'),
('26NV0312','26NV03'),
('26NV0313','26NV03'),
('26NV0314','26NV03'),
('26NV0315','26NV03'),
('26NV0316','26NV03'),
('26NV0317','26NV03'),
('26NV0318','26NV03'),
('26NV0319','26NV03'),
('26NV0320','26NV03'),
('26NV0401','26NV04'),
('26NV0402','26NV04'),
('26NV0403','26NV04'),
('26NV0404','26NV04'),
('26NV0405','26NV04'),
('26NV0406','26NV04'),
('26NV0407','26NV04'),
('26NV0408','26NV04'),
('26NV0409','26NV04'),
('26NV0410','26NV04'),
('26NV0411','26NV04'),
('26NV0412','26NV04'),
('26NV0413','26NV04'),
('26NV0414','26NV04'),
('26NV0415','26NV04'),
('26NV0416','26NV04'),
('26NV0417','26NV04'),
('26NV0418','26NV04'),
('26NV0419','26NV04'),
('26NV0420','26NV04'),
('26NV0421','26NV04'),
('26NV0422','26NV04'),
('26NV0423','26NV04'),
('26NV0501','26NV05'),
('26NV0502','26NV05'),
('26NV0503','26NV05'),
('26NV0504','26NV05'),
('26NV0505','26NV05'),
('26NV0506','26NV05'),
('26NV0507','26NV05'),
('26NV0508','26NV05'),
('26NV0509','26NV05'),
('26NV0510','26NV05'),
('26NV0511','26NV05'),
('26NV0512','26NV05'),
('26NV0513','26NV05'),
('26NV0514','26NV05'),
('26NV0515','26NV05'),
('26NV0516','26NV05'),
('26NV0517','26NV05'),
('26NV0518','26NV05'),
('26NV0519','26NV05'),
('26NV0520','26NV05'),
('26NV0521','26NV05'),
('26NV0522','26NV05'),
('26NV0523','26NV05'),
('26NV0524','26NV05'),
('26NV0525','26NV05'),
('26NV0526','26NV05'),
('26NV0601','26NV06'),
('26NV0602','26NV06'),
('26NV0603','26NV06'),
('26NV0604','26NV06'),
('26NV0605','26NV06'),
('26NV0606','26NV06'),
('26NV0607','26NV06'),
('26NV0608','26NV06'),
('26NV0609','26NV06'),
('26NV0610','26NV06'),
('26NV0611','26NV06'),
('26NV0612','26NV06'),
('26NV0613','26NV06'),
('26NV0614','26NV06'),
('26NV0615','26NV06'),
('26NV0616','26NV06'),
('26NV0617','26NV06'),
('26NV0618','26NV06'),
('26NV0619','26NV06'),
('26NV0620','26NV06'),
('26NV0621','26NV06'),
('26NV0622','26NV06'),
('26NV0623','26NV06'),
('26NV0624','26NV06'),
('26NV0625','26NV06'),
('26NV0701','26NV07'),
('26NV0702','26NV07'),
('26NV0703','26NV07'),
('26NV0704','26NV07'),
('26NV0705','26NV07'),
('26NV0706','26NV07'),
('26NV0707','26NV07'),
('26NV0708','26NV07'),
('26NV0709','26NV07'),
('26NV0710','26NV07'),
('26NV0711','26NV07'),
('26NV0712','26NV07'),
('26NV0713','26NV07'),
('26NV0714','26NV07'),
('26NV0801','26NV08'),
('26NV0802','26NV08'),
('26NV0803','26NV08'),
('26NV0804','26NV08'),
('26NV0805','26NV08'),
('26NV0806','26NV08'),
('26NV0807','26NV08'),
('26NV0808','26NV08'),
('26NV0809','26NV08'),
('26NV0810','26NV08'),
('26NV0811','26NV08'),
('26NV0812','26NV08'),
('26NV0813','26NV08'),
('26NV0814','26NV08'),
('26NV0815','26NV08'),
('26NV0816','26NV08'),
('26NV0817','26NV08'),
('26NV0818','26NV08'),
('26NV0819','26NV08'),
('26NV0820','26NV08'),
('26NV0901','26NV09'),
('26NV0902','26NV09'),
('26NV0903','26NV09'),
('26NV0904','26NV09'),
('26NV0905','26NV09'),
('26NV0906','26NV09'),
('26NV0907','26NV09'),
('26NV0908','26NV09'),
('26NV0909','26NV09'),
('26NV0910','26NV09'),
('26NV0911','26NV09'),
('26NV0912','26NV09'),
('26NV0913','26NV09'),
('26NV0914','26NV09'),
('26NV0915','26NV09'),
('26NV0916','26NV09'),
('26NV0917','26NV09'),
('26NV0918','26NV09'),
('26NV0919','26NV09'),
('26NV1001','26NV10'),
('26NV1002','26NV10'),
('26NV1003','26NV10'),
('26NV1004','26NV10'),
('26NV1005','26NV10'),
('26NV1006','26NV10'),
('26NV1007','26NV10'),
('26NV1008','26NV10'),
('26NV1009','26NV10'),
('26NV1010','26NV10'),
('26NV1011','26NV10'),
('26NV1012','26NV10'),
('26NV1013','26NV10'),
('26NV1101','26NV11'),
('26NV1102','26NV11'),
('26NV1103','26NV11'),
('26NV1104','26NV11'),
('26NV1105','26NV11'),
('26NV1106','26NV11'),
('26NV1107','26NV11'),
('26NV1108','26NV11'),
('26NV1109','26NV11'),
('26NV1110','26NV11'),
('26NV1111','26NV11'),
('26NV1201','26NV12'),
('26NV1202','26NV12'),
('26NV1203','26NV12'),
('26NV1204','26NV12'),
('26NV1205','26NV12'),
('26NV1206','26NV12'),
('26NV1207','26NV12'),
('26NV1208','26NV12'),
('26NV1209','26NV12'),
('26NV1210','26NV12'),
('26NV1211','26NV12'),
('26NV1212','26NV12'),
('26NV1213','26NV12'),
('26NV1301','26NV13'),
('26NV1302','26NV13'),
('26NV1303','26NV13'),
('26NV1304','26NV13'),
('26NV1305','26NV13'),
('26NV1306','26NV13'),
('26NV1307','26NV13'),
('26NV1308','26NV13'),
('26NV1309','26NV13'),
('26NV1310','26NV13'),
('26NV1311','26NV13'),
('26NV1312','26NV13'),
('26NV1313','26NV13'),
('26NV1314','26NV13'),
('26NV1315','26NV13'),
('26NV1316','26NV13'),
('26NV1401','26NV14'),
('26NV1402','26NV14'),
('26NV1403','26NV14'),
('26NV1404','26NV14'),
('26NV1405','26NV14'),
('26NV1406','26NV14'),
('26NV1407','26NV14'),
('26NV1408','26NV14'),
('26NV1409','26NV14'),
('26NV1410','26NV14'),
('26NV1411','26NV14'),
('26NV1412','26NV14'),
('26NV1501','26NV15'),
('26NV1502','26NV15'),
('26NV1503','26NV15'),
('26NV1504','26NV15'),
('26NV1505','26NV15'),
('26NV1506','26NV15'),
('26NV1507','26NV15'),
('26NV1508','26NV15'),
('26NV1509','26NV15'),
('26NV1510','26NV15'),
('26NV1511','26NV15'),
('26NV1512','26NV15'),
('26NV1601','26NV16'),
('26NV1602','26NV16'),
('26NV1603','26NV16'),
('26NV1604','26NV16'),
('26NV1605','26NV16'),
('26NV1606','26NV16'),
('26NV1607','26NV16'),
('26NV1608','26NV16'),
('26NV1609','26NV16'),
('26NV1610','26NV16'),
('26NV1611','26NV16'),
('26NV1612','26NV16'),
('26NV1613','26NV16'),
('26NV1614','26NV16'),
('26NV1701','26NV17'),
('26NV1702','26NV17'),
('26NV1703','26NV17'),
('26NV1704','26NV17'),
('26NV1705','26NV17'),
('26NV1706','26NV17'),
('26NV1707','26NV17'),
('26NV1708','26NV17'),
('26NV1709','26NV17'),
('26NV1710','26NV17'),
('26NV1801','26NV18'),
('26NV1802','26NV18'),
('26NV1803','26NV18'),
('26NV1804','26NV18'),
('26NV1805','26NV18'),
('26NV1806','26NV18'),
('26NV1807','26NV18'),
('26RP0101','26RP01'),
('26RP0102','26RP01'),
('26RP0103','26RP01'),
('26RP0104','26RP01'),
('26RP0105','26RP01'),
('26RP0106','26RP01'),
('26RP0107','26RP01'),
('26RP0108','26RP01'),
('26RP0109','26RP01'),
('26RP0110','26RP01'),
('26RP0111','26RP01'),
('26RP0112','26RP01'),
('26RP0113','26RP01'),
('26RP0114','26RP01'),
('26RP0115','26RP01'),
('26RP0116','26RP01'),
('26RP0117','26RP01'),
('26RP0118','26RP01'),
('26RP0119','26RP01'),
('26RP0120','26RP01'),
('26RP0121','26RP01'),
('26RP0122','26RP01'),
('26RP0123','26RP01'),
('26RP0124','26RP01'),
('26RP0125','26RP01'),
('26RP0126','26RP01'),
('26RP0127','26RP01'),
('26RP0128','26RP01'),
('26RP0129','26RP01'),
('26RP0201','26RP02'),
('26RP0202','26RP02'),
('26RP0203','26RP02'),
('26RP0204','26RP02'),
('26RP0205','26RP02'),
('26RP0206','26RP02'),
('26RP0207','26RP02'),
('26RP0208','26RP02'),
('26RP0209','26RP02'),
('26RP0210','26RP02'),
('26RP0211','26RP02'),
('26RP0212','26RP02'),
('26RP0213','26RP02'),
('26RP0214','26RP02'),
('26RP0215','26RP02'),
('26RP0216','26RP02'),
('26RP0217','26RP02'),
('26RP0218','26RP02'),
('26RP0219','26RP02'),
('26RP0220','26RP02'),
('26RP0221','26RP02'),
('26RP0222','26RP02'),
('26RP0223','26RP02'),
('26RP0224','26RP02'),
('26RP0225','26RP02'),
('26RP0301','26RP03'),
('26RP0302','26RP03'),
('26RP0303','26RP03'),
('26RP0304','26RP03'),
('26RP0305','26RP03'),
('26RP0306','26RP03'),
('26RP0307','26RP03'),
('26RP0308','26RP03'),
('26RP0309','26RP03'),
('26RP0310','26RP03'),
('26RP0311','26RP03'),
('26RP0312','26RP03'),
('26RP0313','26RP03'),
('26RP0314','26RP03'),
('26RP0401','26RP04'),
('26RP0402','26RP04'),
('26RP0403','26RP04'),
('26RP0404','26RP04'),
('26RP0405','26RP04'),
('26RP0406','26RP04'),
('26RP0407','26RP04'),
('26RP0408','26RP04'),
('26RP0409','26RP04'),
('26RP0410','26RP04'),
('26RP0411','26RP04'),
('26RP0412','26RP04'),
('26RP0413','26RP04'),
('26RP0414','26RP04'),
('26RP0415','26RP04'),
('26RP0416','26RP04'),
('26RP0417','26RP04'),
('26RP0418','26RP04'),
('26RP0419','26RP04'),
('26RP0420','26RP04'),
('26RP0501','26RP05'),
('26RP0502','26RP05'),
('26RP0503','26RP05'),
('26RP0504','26RP05'),
('26RP0505','26RP05'),
('26RP0506','26RP05'),
('26RP0507','26RP05'),
('26RP0508','26RP05'),
('26RP0509','26RP05'),
('26RP0510','26RP05'),
('26RP0511','26RP05'),
('26RP0512','26RP05'),
('26RP0513','26RP05'),
('26RP0514','26RP05'),
('26RP0601','26RP06'),
('26RP0602','26RP06'),
('26RP0603','26RP06'),
('26RP0604','26RP06'),
('26RP0605','26RP06'),
('26RP0606','26RP06'),
('26RP0607','26RP06'),
('26RP0608','26RP06'),
('26RP0609','26RP06'),
('26RP0610','26RP06'),
('26RP0611','26RP06'),
('26RP0612','26RP06'),
('26RP0613','26RP06'),
('26RP0614','26RP06'),
('26RP0615','26RP06'),
('26RP0616','26RP06'),
('26RP0617','26RP06'),
('26RP0618','26RP06'),
('26RP0619','26RP06'),
('26RP0620','26RP06'),
('26RP0621','26RP06'),
('26RP0622','26RP06'),
('26RP0623','26RP06'),
('26RP0624','26RP06'),
('26RP0625','26RP06'),
('26RP0626','26RP06'),
('26RP0627','26RP06'),
('26RP0628','26RP06'),
('26RP0629','26RP06'),
('26RP0630','26RP06'),
('26RP0701','26RP07'),
('26RP0702','26RP07'),
('26RP0703','26RP07'),
('26RP0704','26RP07'),
('26RP0705','26RP07'),
('26RP0706','26RP07'),
('26RP0707','26RP07'),
('26RP0708','26RP07'),
('26RP0709','26RP07'),
('26RP0710','26RP07'),
('26RP0711','26RP07'),
('26RP0712','26RP07'),
('26RP0713','26RP07'),
('26RP0714','26RP07'),
('26RP0715','26RP07'),
('26RP0716','26RP07'),
('26RP0717','26RP07'),
('26RP0718','26RP07'),
('26RP0719','26RP07'),
('26RP0801','26RP08'),
('26RP0802','26RP08'),
('26RP0803','26RP08'),
('26RP0804','26RP08'),
('26RP0805','26RP08'),
('26RP0806','26RP08'),
('26RP0807','26RP08'),
('26RP0808','26RP08'),
('26RP0809','26RP08'),
('26RP0810','26RP08'),
('26RP0811','26RP08'),
('26RP0901','26RP09'),
('26RP0902','26RP09'),
('26RP0903','26RP09'),
('26RP0904','26RP09'),
('26RP0905','26RP09'),
('26RP0906','26RP09'),
('26RP0907','26RP09'),
('26RP0908','26RP09'),
('26RP0909','26RP09'),
('26RP0910','26RP09'),
('26RP0911','26RP09'),
('26RP0912','26RP09'),
('26RP1001','26RP10'),
('26RP1002','26RP10'),
('26RP1003','26RP10'),
('26RP1004','26RP10'),
('26RP1005','26RP10'),
('26RP1006','26RP10'),
('26RP1007','26RP10'),
('26RP1008','26RP10'),
('26RP1009','26RP10'),
('26RP1010','26RP10'),
('26RP1011','26RP10'),
('26RP1012','26RP10'),
('26RP1013','26RP10'),
('26RP1014','26RP10'),
('26RP1015','26RP10'),
('26RP1016','26RP10'),
('26RP1017','26RP10'),
('26RP1018','26RP10'),
('26RP1019','26RP10'),
('26RP1020','26RP10'),
('26RP1021','26RP10'),
('26RP1022','26RP10'),
('26RP1023','26RP10'),
('26RP1024','26RP10'),
('26RP1025','26RP10'),
('26RP1026','26RP10'),
('26RP1027','26RP10'),
('26RP1028','26RP10'),
('26RP1029','26RP10'),
('26RP1030','26RP10'),
('26RP1031','26RP10'),
('26RP1032','26RP10'),
('26RP1033','26RP10'),
('26RP1034','26RP10'),
('26RP1035','26RP10'),
('26RP1036','26RP10'),
('26RP1037','26RP10'),
('26RP1038','26RP10'),
('26RP1039','26RP10'),
('26RP1040','26RP10'),
('26RP1041','26RP10'),
('26RP1101','26RP11'),
('26RP1102','26RP11'),
('26RP1103','26RP11'),
('26RP1104','26RP11'),
('26RP1105','26RP11'),
('26RP1106','26RP11'),
('26RP1107','26RP11'),
('26RP1108','26RP11'),
('26RP1109','26RP11'),
('26RP1110','26RP11'),
('26RP1111','26RP11'),
('26RP1112','26RP11'),
('26RP1113','26RP11'),
('26RP1114','26RP11'),
('26RP1115','26RP11'),
('26RP1116','26RP11'),
('26RP1117','26RP11'),
('26RP1118','26RP11'),
('26RP1119','26RP11'),
('26RP1120','26RP11'),
('26RP1121','26RP11'),
('26RP1122','26RP11'),
('26RP1123','26RP11'),
('26RP1124','26RP11'),
('26RP1201','26RP12'),
('26RP1202','26RP12'),
('26RP1203','26RP12'),
('26RP1204','26RP12'),
('26RP1205','26RP12'),
('26RP1206','26RP12'),
('26RP1207','26RP12'),
('26RP1208','26RP12'),
('26RP1209','26RP12'),
('26RP1210','26RP12'),
('26RP1211','26RP12'),
('26RP1212','26RP12'),
('26RP1213','26RP12'),
('26RP1214','26RP12'),
('26RP1215','26RP12'),
('26RP1216','26RP12'),
('26RP1217','26RP12'),
('26RP1218','26RP12'),
('26RP1219','26RP12'),
('26RP1220','26RP12'),
('26RP1221','26RP12'),
('26RP1222','26RP12'),
('26RP1223','26RP12'),
('26RP1224','26RP12'),
('26RP1225','26RP12'),
('26RP1301','26RP13'),
('26RP1302','26RP13'),
('26RP1303','26RP13'),
('26RP1304','26RP13'),
('26RP1305','26RP13'),
('26RP1306','26RP13'),
('26RP1307','26RP13'),
('26RP1308','26RP13'),
('26RP1309','26RP13'),
('26RP1401','26RP14'),
('26RP1402','26RP14'),
('26RP1403','26RP14'),
('26RP1404','26RP14'),
('26RP1405','26RP14'),
('26RP1406','26RP14'),
('26RP1407','26RP14'),
('26RP1408','26RP14'),
('26RP1409','26RP14'),
('26RP1410','26RP14'),
('26RP1411','26RP14'),
('26RP1412','26RP14'),
('26RP1413','26RP14'),
('26RP1414','26RP14'),
('26RP1415','26RP14'),
('26RP1416','26RP14'),
('26RP1417','26RP14'),
('26RP1418','26RP14'),
('26RP1419','26RP14'),
('26RP1420','26RP14'),
('26RP1501','26RP15'),
('26RP1502','26RP15'),
('26RP1503','26RP15'),
('26RP1504','26RP15'),
('26RP1505','26RP15'),
('26RP1506','26RP15'),
('26RP1507','26RP15'),
('26RP1508','26RP15'),
('26RP1509','26RP15'),
('26RP1510','26RP15'),
('26RP1511','26RP15'),
('26RP1512','26RP15'),
('26RP1513','26RP15'),
('26RP1514','26RP15'),
('26RP1515','26RP15'),
('26RP1516','26RP15'),
('26RP1517','26RP15'),
('26RP1518','26RP15'),
('26RP1519','26RP15'),
('26RP1520','26RP15'),
('26RP1521','26RP15'),
('26RP1522','26RP15'),
('26RP1523','26RP15'),
('26RP1524','26RP15'),
('26RP1525','26RP15'),
('26RP1526','26RP15'),
('26RP1527','26RP15'),
('26RP1601','26RP16'),
('26RP1602','26RP16'),
('26RP1603','26RP16'),
('26RP1604','26RP16'),
('26RP1605','26RP16'),
('26RP1606','26RP16'),
('26RP1607','26RP16'),
('26RP1608','26RP16'),
('26RP1609','26RP16'),
('26RP1610','26RP16'),
('26RP1611','26RP16'),
('26RP1612','26RP16'),
('26RP1613','26RP16'),
('26RP1614','26RP16'),
('26RP1615','26RP16'),
('26AG0101','26AG01'),
('26AG0102','26AG01'),
('26AG0103','26AG01'),
('26AG0104','26AG01'),
('26AG0105','26AG01'),
('26AG0106','26AG01'),
('26AG0107','26AG01'),
('26AG0108','26AG01'),
('26AG0109','26AG01'),
('26AG0110','26AG01'),
('26AG0111','26AG01'),
('26AG0112','26AG01'),
('26AG0113','26AG01'),
('26AG0114','26AG01'),
('26AG0115','26AG01'),
('26AG0116','26AG01'),
('26AG0117','26AG01'),
('26AG0118','26AG01'),
('26AG0119','26AG01'),
('26AG0120','26AG01'),
('26AG0121','26AG01'),
('26AG0122','26AG01'),
('26AG0123','26AG01'),
('26AG0124','26AG01'),
('26AG0125','26AG01'),
('26AG0201','26AG02'),
('26AG0202','26AG02'),
('26AG0203','26AG02'),
('26AG0204','26AG02'),
('26AG0205','26AG02'),
('26AG0206','26AG02'),
('26AG0207','26AG02'),
('26AG0208','26AG02'),
('26AG0209','26AG02'),
('26AG0210','26AG02'),
('26AG0211','26AG02'),
('26AG0212','26AG02'),
('26AG0213','26AG02'),
('26AG0214','26AG02'),
('26AG0215','26AG02'),
('26AG0216','26AG02'),
('26AG0217','26AG02'),
('26AG0218','26AG02'),
('26AG0219','26AG02'),
('26AG0220','26AG02'),
('26AG0221','26AG02'),
('26AG0222','26AG02'),
('26AG0301','26AG03'),
('26AG0302','26AG03'),
('26AG0303','26AG03'),
('26AG0304','26AG03'),
('26AG0305','26AG03'),
('26AG0306','26AG03'),
('26AG0307','26AG03'),
('26AG0308','26AG03'),
('26AG0309','26AG03'),
('26AG0310','26AG03'),
('26AG0311','26AG03'),
('26AG0401','26AG04'),
('26AG0402','26AG04'),
('26AG0403','26AG04'),
('26AG0404','26AG04'),
('26AG0405','26AG04'),
('26AG0406','26AG04'),
('26AG0407','26AG04'),
('26AG0408','26AG04'),
('26AG0409','26AG04'),
('26AG0410','26AG04'),
('26AG0411','26AG04'),
('26AG0412','26AG04'),
('26AG0413','26AG04'),
('26AG0414','26AG04'),
('26AG0415','26AG04'),
('26AG0416','26AG04'),
('26AG0417','26AG04'),
('26AG0418','26AG04'),
('26AG0501','26AG05'),
('26AG0502','26AG05'),
('26AG0503','26AG05'),
('26AG0504','26AG05'),
('26AG0505','26AG05'),
('26AG0506','26AG05'),
('26AG0507','26AG05'),
('26AG0508','26AG05'),
('26AG0509','26AG05'),
('26AG0510','26AG05'),
('26AG0511','26AG05'),
('26AG0512','26AG05'),
('26AG0513','26AG05'),
('26AG0514','26AG05'),
('26AG0515','26AG05'),
('26AG0516','26AG05'),
('26AG0517','26AG05'),
('26AG0601','26AG06'),
('26AG0602','26AG06'),
('26AG0603','26AG06'),
('26AG0604','26AG06'),
('26AG0605','26AG06'),
('26AG0606','26AG06'),
('26AG0607','26AG06'),
('26AG0608','26AG06'),
('26AG0609','26AG06'),
('26AG0610','26AG06'),
('26AG0611','26AG06'),
('26AG0612','26AG06'),
('26AG0613','26AG06'),
('26AG0614','26AG06'),
('26AG0615','26AG06'),
('26AG0616','26AG06'),
('26AG0617','26AG06'),
('26AG0618','26AG06'),
('26AG0619','26AG06'),
('26AG0620','26AG06'),
('26AG0701','26AG07'),
('26AG0702','26AG07'),
('26AG0703','26AG07'),
('26AG0704','26AG07'),
('26AG0705','26AG07'),
('26AG0706','26AG07'),
('26AG0707','26AG07'),
('26AG0708','26AG07'),
('26AG0709','26AG07'),
('26AG0710','26AG07'),
('26AG0711','26AG07'),
('26AG0712','26AG07'),
('26AG0713','26AG07'),
('26AG0714','26AG07'),
('26AG0715','26AG07'),
('26AG0716','26AG07'),
('26AG0717','26AG07'),
('26AG0718','26AG07'),
('26AG0719','26AG07'),
('26AG0801','26AG08'),
('26AG0802','26AG08'),
('26AG0803','26AG08'),
('26AG0804','26AG08'),
('26AG0805','26AG08'),
('26AG0806','26AG08'),
('26AG0807','26AG08'),
('26AG0808','26AG08'),
('26AG0809','26AG08'),
('26AG0810','26AG08'),
('26AG0811','26AG08'),
('26AG0812','26AG08'),
('26AG0813','26AG08'),
('26AG0814','26AG08'),
('26AG0815','26AG08'),
('26AG0816','26AG08'),
('26AG0817','26AG08'),
('26AG0818','26AG08'),
('26AG0819','26AG08'),
('26AG0820','26AG08'),
('26AG0821','26AG08'),
('26AG0822','26AG08'),
('26AG0823','26AG08'),
('26AG0824','26AG08'),
('26AG0825','26AG08'),
('26AG0901','26AG09'),
('26AG0902','26AG09'),
('26AG0903','26AG09'),
('26AG0904','26AG09'),
('26AG0905','26AG09'),
('26AG0906','26AG09'),
('26AG0907','26AG09'),
('26AG0908','26AG09'),
('26AG0909','26AG09'),
('26AG0910','26AG09'),
('26AG0911','26AG09'),
('26AG0912','26AG09'),
('26AG0913','26AG09'),
('26AG0914','26AG09'),
('26AG0915','26AG09'),
('26AG0916','26AG09'),
('26AG0917','26AG09'),
('26AG1001','26AG10'),
('26AG1002','26AG10'),
('26AG1003','26AG10'),
('26AG1004','26AG10'),
('26AG1005','26AG10'),
('26AG1006','26AG10'),
('26AG1007','26AG10'),
('26AG1008','26AG10'),
('26AG1009','26AG10'),
('26AG1010','26AG10'),
('26AG1011','26AG10'),
('26AG1012','26AG10'),
('26AG1013','26AG10'),
('26AG1014','26AG10'),
('26AG1015','26AG10'),
('26AG1016','26AG10'),
('26AG1017','26AG10'),
('26AG1018','26AG10'),
('26AG1019','26AG10'),
('26AG1020','26AG10'),
('26AG1021','26AG10'),
('26AG1022','26AG10'),
('26AG1023','26AG10'),
('26AG1024','26AG10'),
('26AG1101','26AG11'),
('26AG1102','26AG11'),
('26AG1103','26AG11'),
('26AG1104','26AG11'),
('26AG1105','26AG11'),
('26AG1106','26AG11'),
('26AG1107','26AG11'),
('26AG1108','26AG11'),
('26AG1109','26AG11'),
('26AG1110','26AG11'),
('26AG1111','26AG11'),
('26AG1112','26AG11'),
('26AG1201','26AG12'),
('26AG1202','26AG12'),
('26AG1203','26AG12'),
('26AG1204','26AG12'),
('26AG1205','26AG12'),
('26AG1206','26AG12'),
('26AG1207','26AG12'),
('26AG1208','26AG12'),
('26AG1209','26AG12'),
('26AG1210','26AG12'),
('26AG1211','26AG12'),
('26AG1212','26AG12'),
('26AG1301','26AG13'),
('26AG1302','26AG13'),
('26AG1303','26AG13'),
('26AG1304','26AG13'),
('26AG1305','26AG13'),
('26AG1306','26AG13'),
('26AG1307','26AG13'),
('26AG1308','26AG13'),
('26AG1309','26AG13'),
('26AG1310','26AG13'),
('26AG1311','26AG13'),
('26AG1312','26AG13'),
('26AG1313','26AG13'),
('26AG1314','26AG13'),
('26AG1401','26AG14'),
('26AG1402','26AG14'),
('26AG1403','26AG14'),
('26AG1404','26AG14'),
('26AG1405','26AG14'),
('26AG1406','26AG14'),
('26AG1407','26AG14'),
('26AG1408','26AG14'),
('26AG1409','26AG14'),
('26AG1501','26AG15'),
('26AG1502','26AG15'),
('26AG1503','26AG15'),
('26AG1504','26AG15'),
('26AG1505','26AG15'),
('26AG1506','26AG15'),
('26AG1507','26AG15'),
('26AG1508','26AG15'),
('26AG1509','26AG15'),
('26AG1510','26AG15'),
('26AG1511','26AG15'),
('26AG1512','26AG15'),
('26AG1513','26AG15'),
('26AG1514','26AG15'),
('26AG1601','26AG16'),
('26AG1602','26AG16'),
('26AG1603','26AG16'),
('26AG1604','26AG16'),
('26AG1605','26AG16'),
('26AG1606','26AG16'),
('26AG1607','26AG16'),
('26AG1608','26AG16'),
('26AG1609','26AG16'),
('26AG1610','26AG16'),
('26AG1611','26AG16'),
('26AG1612','26AG16'),
('26AG1613','26AG16'),
('26AG1614','26AG16'),
('26AG1615','26AG16'),
('26AG1616','26AG16'),
('26AG1617','26AG16'),
('26AG1618','26AG16'),
('26AG1619','26AG16'),
('26AG1620','26AG16'),
('26MP0101','26MP01'),
('26MP0102','26MP01'),
('26MP0103','26MP01'),
('26MP0104','26MP01'),
('26MP0105','26MP01'),
('26MP0106','26MP01'),
('26MP0107','26MP01'),
('26MP0108','26MP01'),
('26MP0109','26MP01'),
('26MP0110','26MP01'),
('26MP0111','26MP01'),
('26MP0112','26MP01'),
('26MP0113','26MP01'),
('26MP0114','26MP01'),
('26MP0115','26MP01'),
('26MP0116','26MP01'),
('26MP0117','26MP01'),
('26MP0118','26MP01'),
('26MP0119','26MP01'),
('26MP0120','26MP01'),
('26MP0121','26MP01'),
('26MP0122','26MP01'),
('26MP0123','26MP01'),
('26MP0124','26MP01'),
('26MP0125','26MP01'),
('26MP0126','26MP01'),
('26MP0127','26MP01'),
('26MP0128','26MP01'),
('26MP0129','26MP01'),
('26MP0130','26MP01'),
('26MP0131','26MP01'),
('26MP0132','26MP01'),
('26MP0133','26MP01'),
('26MP0134','26MP01'),
('26MP0135','26MP01'),
('26MP0136','26MP01'),
('26MP0137','26MP01'),
('26MP0138','26MP01'),
('26MP0139','26MP01'),
('26MP0140','26MP01'),
('26MP0141','26MP01'),
('26MP0142','26MP01'),
('26MP0143','26MP01'),
('26MP0144','26MP01'),
('26MP0145','26MP01'),
('26MP0146','26MP01'),
('26MP0201','26MP02'),
('26MP0202','26MP02'),
('26MP0203','26MP02'),
('26MP0204','26MP02'),
('26MP0205','26MP02'),
('26MP0206','26MP02'),
('26MP0207','26MP02'),
('26MP0208','26MP02'),
('26MP0209','26MP02'),
('26MP0210','26MP02'),
('26MP0211','26MP02'),
('26MP0212','26MP02'),
('26MP0213','26MP02'),
('26MP0214','26MP02'),
('26MP0215','26MP02'),
('26MP0216','26MP02'),
('26MP0217','26MP02'),
('26MP0218','26MP02'),
('26MP0219','26MP02'),
('26MP0220','26MP02'),
('26MP0221','26MP02'),
('26MP0222','26MP02'),
('26MP0301','26MP03'),
('26MP0302','26MP03'),
('26MP0303','26MP03'),
('26MP0304','26MP03'),
('26MP0305','26MP03'),
('26MP0306','26MP03'),
('26MP0307','26MP03'),
('26MP0308','26MP03'),
('26MP0309','26MP03'),
('26MP0310','26MP03'),
('26MP0311','26MP03'),
('26MP0312','26MP03'),
('26MP0313','26MP03'),
('26MP0314','26MP03'),
('26MP0315','26MP03'),
('26MP0316','26MP03'),
('26MP0317','26MP03'),
('26MP0318','26MP03'),
('26MP0319','26MP03'),
('26MP0320','26MP03'),
('26MP0321','26MP03'),
('26MP0322','26MP03'),
('26MP0323','26MP03'),
('26MP0324','26MP03'),
('26MP0325','26MP03'),
('26MP0326','26MP03'),
('26MP0327','26MP03'),
('26MP0328','26MP03'),
('26MP0329','26MP03'),
('26MP0330','26MP03'),
('26MP0331','26MP03'),
('26MP0332','26MP03'),
('26MP0333','26MP03'),
('26MP0401','26MP04'),
('26MP0402','26MP04'),
('26MP0403','26MP04'),
('26MP0404','26MP04'),
('26MP0405','26MP04'),
('26MP0406','26MP04'),
('26MP0407','26MP04'),
('26MP0408','26MP04'),
('26MP0409','26MP04'),
('26MP0410','26MP04'),
('26MP0411','26MP04'),
('26MP0412','26MP04'),
('26MP0413','26MP04'),
('26MP0414','26MP04'),
('26MP0415','26MP04'),
('26MP0416','26MP04'),
('26MP0417','26MP04'),
('26MP0418','26MP04'),
('26MP0419','26MP04'),
('26MP0420','26MP04'),
('26MP0501','26MP05'),
('26MP0502','26MP05'),
('26MP0503','26MP05'),
('26MP0504','26MP05'),
('26MP0505','26MP05'),
('26MP0506','26MP05'),
('26MP0507','26MP05'),
('26MP0508','26MP05'),
('26MP0509','26MP05'),
('26MP0510','26MP05'),
('26MP0511','26MP05'),
('26MP0512','26MP05'),
('26MP0513','26MP05'),
('26MP0514','26MP05'),
('26MP0515','26MP05'),
('26MP0516','26MP05'),
('26MP0517','26MP05'),
('26MP0518','26MP05'),
('26MP0519','26MP05'),
('26MP0520','26MP05'),
('26MP0521','26MP05'),
('26MP0522','26MP05'),
('26MP0523','26MP05'),
('26MP0524','26MP05'),
('26MP0525','26MP05'),
('26MP0526','26MP05'),
('26MP0527','26MP05'),
('26MP0528','26MP05'),
('26MP0601','26MP06'),
('26MP0602','26MP06'),
('26MP0603','26MP06'),
('26MP0604','26MP06'),
('26MP0605','26MP06'),
('26MP0606','26MP06'),
('26MP0607','26MP06'),
('26MP0608','26MP06'),
('26MP0609','26MP06'),
('26MP0610','26MP06'),
('26MP0611','26MP06'),
('26MP0612','26MP06'),
('26MP0613','26MP06'),
('26MP0614','26MP06'),
('26MP0615','26MP06'),
('26MP0616','26MP06'),
('26MP0617','26MP06'),
('26MP0618','26MP06'),
('26MP0619','26MP06'),
('26MP0620','26MP06'),
('26MP0621','26MP06'),
('26MP0622','26MP06'),
('26MP0623','26MP06'),
('26MP0624','26MP06'),
('26MP0625','26MP06'),
('26MP0626','26MP06'),
('26MP0627','26MP06'),
('26MP0628','26MP06'),
('26MP0629','26MP06'),
('26MP0630','26MP06'),
('26MP0631','26MP06'),
('26MP0701','26MP07'),
('26MP0702','26MP07'),
('26MP0703','26MP07'),
('26MP0704','26MP07'),
('26MP0705','26MP07'),
('26MP0706','26MP07'),
('26MP0707','26MP07'),
('26MP0708','26MP07'),
('26MP0709','26MP07'),
('26MP0710','26MP07'),
('26MP0711','26MP07'),
('26MP0712','26MP07'),
('26MP0713','26MP07'),
('26MP0714','26MP07'),
('26MP0715','26MP07'),
('26MP0716','26MP07'),
('26MP0717','26MP07'),
('26MP0718','26MP07'),
('26MP0719','26MP07'),
('26MP0720','26MP07'),
('26MP0721','26MP07'),
('26MP0801','26MP08'),
('26MP0802','26MP08'),
('26MP0803','26MP08'),
('26MP0804','26MP08'),
('26MP0805','26MP08'),
('26MP0806','26MP08'),
('26MP0807','26MP08'),
('26MP0808','26MP08'),
('26MP0809','26MP08'),
('26MP0810','26MP08'),
('26MP0811','26MP08'),
('26MP0812','26MP08'),
('26MP0813','26MP08'),
('26MP0814','26MP08'),
('26MP0815','26MP08'),
('26MP0816','26MP08'),
('26MP0817','26MP08'),
('26MP0818','26MP08'),
('26MP0901','26MP09'),
('26MP0902','26MP09'),
('26MP0903','26MP09'),
('26MP0904','26MP09'),
('26MP0905','26MP09'),
('26MP0906','26MP09'),
('26MP0907','26MP09'),
('26MP0908','26MP09'),
('26MP0909','26MP09'),
('26MP0910','26MP09'),
('26MP0911','26MP09'),
('26MP0912','26MP09'),
('26MP0913','26MP09'),
('26MP0914','26MP09'),
('26MP0915','26MP09'),
('26MP0916','26MP09'),
('26MP0917','26MP09'),
('26MP0918','26MP09'),
('26MP1001','26MP10'),
('26MP1002','26MP10'),
('26MP1003','26MP10'),
('26MP1004','26MP10'),
('26MP1005','26MP10'),
('26MP1006','26MP10'),
('26MP1007','26MP10'),
('26MP1008','26MP10'),
('26MP1009','26MP10'),
('26MP1010','26MP10'),
('26MP1011','26MP10'),
('26MP1012','26MP10'),
('26MP1013','26MP10'),
('26MP1101','26MP11'),
('26MP1102','26MP11'),
('26MP1103','26MP11'),
('26MP1104','26MP11'),
('26MP1105','26MP11'),
('26MP1106','26MP11'),
('26MP1107','26MP11'),
('26MP1108','26MP11'),
('26MP1109','26MP11'),
('26MP1110','26MP11'),
('26MP1111','26MP11'),
('26MP1112','26MP11'),
('26MP1113','26MP11'),
('26MP1114','26MP11'),
('26MP1115','26MP11'),
('26MP1116','26MP11'),
('26MP1117','26MP11'),
('26MP1201','26MP12'),
('26MP1202','26MP12'),
('26MP1203','26MP12'),
('26MP1204','26MP12'),
('26MP1205','26MP12'),
('26MP1206','26MP12'),
('26MP1207','26MP12'),
('26MP1208','26MP12'),
('26MP1209','26MP12'),
('26MP1210','26MP12'),
('26MP1211','26MP12'),
('26MP1212','26MP12'),
('26MP1213','26MP12'),
('26MP1214','26MP12'),
('26MP1215','26MP12'),
('26MP1216','26MP12'),
('26MP1217','26MP12'),
('26MP1301','26MP13'),
('26MP1302','26MP13'),
('26MP1303','26MP13'),
('26MP1304','26MP13'),
('26MP1305','26MP13'),
('26MP1306','26MP13'),
('26MP1307','26MP13'),
('26MP1308','26MP13'),
('26MP1309','26MP13'),
('26MP1310','26MP13'),
('26MP1311','26MP13'),
('26MP1314','26MP13'),
('26MP1315','26MP13'),
('26MP1316','26MP13'),
('26MP1317','26MP13'),
('26KP0101','26KP01'),
('26KP0102','26KP01'),
('26KP0103','26KP01'),
('26KP0104','26KP01'),
('26KP0105','26KP01'),
('26KP0106','26KP01'),
('26KP0107','26KP01'),
('26KP0108','26KP01'),
('26KP0109','26KP01'),
('26KP0110','26KP01'),
('26KP0111','26KP01'),
('26KP0112','26KP01'),
('26KP0113','26KP01'),
('26KP0114','26KP01'),
('26KP0115','26KP01'),
('26KP0116','26KP01'),
('26KP0117','26KP01'),
('26KP0118','26KP01'),
('26KP0119','26KP01'),
('26KP0120','26KP01'),
('26KP0121','26KP01'),
('26KP0122','26KP01'),
('26KP0123','26KP01'),
('26KP0124','26KP01'),
('26KP0125','26KP01'),
('26KP0126','26KP01'),
('26KP0127','26KP01'),
('26KP0128','26KP01'),
('26KP0129','26KP01'),
('26KP0130','26KP01'),
('26KP0131','26KP01'),
('26KP0201','26KP02'),
('26KP0202','26KP02'),
('26KP0203','26KP02'),
('26KP0204','26KP02'),
('26KP0205','26KP02'),
('26KP0206','26KP02'),
('26KP0207','26KP02'),
('26KP0208','26KP02'),
('26KP0209','26KP02'),
('26KP0210','26KP02'),
('26KP0211','26KP02'),
('26KP0212','26KP02'),
('26KP0213','26KP02'),
('26KP0214','26KP02'),
('26KP0215','26KP02'),
('26KP0216','26KP02'),
('26KP0217','26KP02'),
('26KP0218','26KP02'),
('26KP0219','26KP02'),
('26KP0220','26KP02'),
('26KP0221','26KP02'),
('26KP0222','26KP02'),
('26KP0223','26KP02'),
('26KP0224','26KP02'),
('26KP0225','26KP02'),
('26KP0226','26KP02'),
('26KP0227','26KP02'),
('26KP0228','26KP02'),
('26KP0229','26KP02'),
('26KP0230','26KP02'),
('26KP0301','26KP03'),
('26KP0302','26KP03'),
('26KP0303','26KP03'),
('26KP0304','26KP03'),
('26KP0305','26KP03'),
('26KP0306','26KP03'),
('26KP0307','26KP03'),
('26KP0308','26KP03'),
('26KP0309','26KP03'),
('26KP0310','26KP03'),
('26KP0311','26KP03'),
('26KP0312','26KP03'),
('26KP0313','26KP03'),
('26KP0314','26KP03'),
('26KP0315','26KP03'),
('26KP0316','26KP03'),
('26KP0317','26KP03'),
('26KP0318','26KP03'),
('26KP0319','26KP03'),
('26KP0320','26KP03'),
('26KP0321','26KP03'),
('26KP0401','26KP04'),
('26KP0402','26KP04'),
('26KP0403','26KP04'),
('26KP0404','26KP04'),
('26KP0405','26KP04'),
('26KP0406','26KP04'),
('26KP0407','26KP04'),
('26KP0408','26KP04'),
('26KP0409','26KP04'),
('26KP0501','26KP05'),
('26KP0502','26KP05'),
('26KP0503','26KP05'),
('26KP0504','26KP05'),
('26KP0505','26KP05'),
('26KP0506','26KP05'),
('26KP0507','26KP05'),
('26KP0508','26KP05'),
('26KP0509','26KP05'),
('26KP0510','26KP05'),
('26KP0511','26KP05'),
('26KP0512','26KP05'),
('26KP0513','26KP05'),
('26KP0514','26KP05'),
('26KP0515','26KP05'),
('26KP0516','26KP05'),
('26KP0517','26KP05'),
('26KP0518','26KP05'),
('26KP0519','26KP05'),
('26KP0520','26KP05'),
('26KP0521','26KP05'),
('26KP0522','26KP05'),
('26KP0523','26KP05'),
('26KP0524','26KP05'),
('26KP0525','26KP05'),
('26KP0601','26KP06'),
('26KP0602','26KP06'),
('26KP0603','26KP06'),
('26KP0604','26KP06'),
('26KP0605','26KP06'),
('26KP0606','26KP06'),
('26KP0607','26KP06'),
('26KP0608','26KP06'),
('26KP0609','26KP06'),
('26KP0610','26KP06'),
('26KP0611','26KP06'),
('26KP0612','26KP06'),
('26KP0613','26KP06'),
('26KP0614','26KP06'),
('26KP0615','26KP06'),
('26KP0616','26KP06'),
('26KP0617','26KP06'),
('26KP0618','26KP06'),
('26KP0619','26KP06'),
('26KP0620','26KP06'),
('26KP0621','26KP06'),
('26KP0622','26KP06'),
('26KP0623','26KP06'),
('26KP0624','26KP06'),
('26KP0701','26KP07'),
('26KP0702','26KP07'),
('26KP0703','26KP07'),
('26KP0704','26KP07'),
('26KP0705','26KP07'),
('26KP0706','26KP07'),
('26KP0707','26KP07'),
('26KP0708','26KP07'),
('26KP0709','26KP07'),
('26KP0710','26KP07'),
('26KP0711','26KP07'),
('26KP0712','26KP07'),
('26KP0713','26KP07'),
('26KP0714','26KP07'),
('26KP0715','26KP07'),
('26KP0716','26KP07'),
('26KP0717','26KP07'),
('26KP0718','26KP07'),
('26KP0801','26KP08'),
('26KP0802','26KP08'),
('26KP0803','26KP08'),
('26KP0804','26KP08')
) AS src(student_code, center_code)
JOIN student_master sm ON sm.student_code=src.student_code
JOIN tuition_center tc ON tc.center_code=src.center_code
JOIN academic_year_master ay ON ay.academic_year='2026-27'
WHERE NOT EXISTS (SELECT 1 FROM student_center_assignment sca WHERE sca.student_id=sm.student_id AND sca.center_id=tc.center_id AND sca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG01' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='CHAPALA SRAVANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG02' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KATTA SWETHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG03' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='MYADARI MAYURI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG04' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GINNARAPU SNEHA PRIYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG05' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KUKUMA SOWMYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG06' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GOLLAPALLY JAYANTH' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG07' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='JANNU KEERTHI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG08' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GELVKARA DHANUSHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG09' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GUNTI SHIRISHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG10' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='VANTERU JUHITHA SRI ALEKHYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG11' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KOLLI CHINNA PRIYANKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG12' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='THATARI RITHWIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG13' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DARSHIRALA CHANDHANA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG14' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='BAYALA MAANVI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG15' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DANGETI SATVIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26AG16' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='POOJARI POOJA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG01' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='A. SHIVANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG02' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ANUSHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG03' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='BHAVANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG04' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='VAISHNAVI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG05' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='NEHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG06' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KOMALA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG07' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='HARIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG08' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ABHILASH' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG09' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='TRISHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, FALSE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG10' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SRI PAVAN TEJA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG10' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='NIKITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG11' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SANGEETHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG12' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='CHARAN' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG13' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SRAVANTHI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG14' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SHIVANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG15' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KRISHNAVENI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG16' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SHIRISHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG17' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KALPANA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG18' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='HEMA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG19' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='LAXMI SAI SREE' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KG20' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GENTI KALPANA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP01' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='RAZIYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP02' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SANJEEV KUMAR' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP03' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='VAISHNAVI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP04' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DANDUGULA  AMRUTHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP05' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='MOHAMMAD AFREEN' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP06' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KRISHNA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP07' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='AKSHAYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26KP08' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='REKANDER ANITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP01' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DANNARAM SIRISHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP02' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='VEMULA ANJALI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP03' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='VEMULA NIKITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP04' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='MEHARUNNISA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP05' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ALYANA KAVYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP06' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='MAKKA HEMALATHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP07' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ZOHIIYA THABUSAM' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP08' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='BARNANA GEETHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP09' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='PALLI POOJA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP10' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DEVADI PADMA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP11' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SUPRIYA DUBEY' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP12' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='VAISHNAVI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26MP13' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KAMBLE SRUTHI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV01' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='MURDHAN SUJATHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV02' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SHANIGARAM MISHRITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV03' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='INDRALA BHARANI CHARY' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV04' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SHAIK SHIFA BEGUM' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV05' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='NAMMORI SPANDANA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV06' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='MUTHYALA VANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV07' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DASARI ASMITHA RAI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV08' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KAPPIDI SRI LAKSHMI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV09' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='S.BHUVANESHWARI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV10' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ALAGONI RISHIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV11' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='AKHILESHWARA SAI PRASAD NAWLE' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV12' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ATHMAKUR SATHWIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV13' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GANGADEVI MOUNIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV14' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DOTI LAXMI PRASANNA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV15' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KUNDANAM BHAVYA SRI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV16' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GUNTALLA PAVANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV17' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KAALA SWETHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26NV18' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='GUNDA SHIRIHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP01' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='KEERTHANA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP02' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='PRABHASINI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP03' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SANDHYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP04' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='SRIVANI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP05' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='HARIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP06' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='YASHWANTHI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP07' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='LAXMI PRIYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP08' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='NIHARIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP09' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='AKSHITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP10' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='BHANU PRASAD' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP11' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='RAVI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP12' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='RITHIKA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP13' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='JYOTHIRMAHI' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP14' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='HARSHITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP15' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='DIVYA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
INSERT INTO tutor_centre_assignment (tutor_id, center_id, academic_year_id, active_flag) SELECT tm.tutor_id, tc.center_id, ay.academic_year_id, TRUE FROM tutor_master tm JOIN tuition_center tc ON tc.center_code='26RP16' JOIN academic_year_master ay ON ay.academic_year='2026-27' WHERE tm.tutor_name='ASHVITHA' AND NOT EXISTS (SELECT 1 FROM tutor_centre_assignment tca WHERE tca.tutor_id=tm.tutor_id AND tca.center_id=tc.center_id AND tca.academic_year_id=ay.academic_year_id);
COMMIT;
SELECT 'academic_year' AS item, COUNT(*)::bigint AS count FROM academic_year_master WHERE academic_year='2026-27' UNION ALL
SELECT 'centres', COUNT(*) FROM tuition_center UNION ALL
SELECT 'ccs', COUNT(*) FROM cluster_coordinator UNION ALL
SELECT 'tutors', COUNT(*) FROM tutor_master UNION ALL
SELECT 'students', COUNT(*) FROM student_master UNION ALL
SELECT 'student_center_assignments_2026_27', COUNT(*) FROM student_center_assignment sca JOIN academic_year_master ay ON ay.academic_year_id=sca.academic_year_id WHERE ay.academic_year='2026-27' UNION ALL
SELECT 'tutor_centre_assignments_2026_27', COUNT(*) FROM tutor_centre_assignment tca JOIN academic_year_master ay ON ay.academic_year_id=tca.academic_year_id WHERE ay.academic_year='2026-27';
-- Conflicting student codes intentionally excluded:
-- 26KG1001: BABBLU / SRI PAVAN TEJA / 26KG10 | V. DATHA SRI / NIKITHA / 26KG10
-- 26KG1002: MD.ADHIL / SRI PAVAN TEJA / 26KG10 | E. NAKSHATRA / NIKITHA / 26KG10
-- 26KG1003: SAHEBA / SRI PAVAN TEJA / 26KG10 | E.HARSHITHA / NIKITHA / 26KG10
-- 26KG1004: NAZMIN / SRI PAVAN TEJA / 26KG10 | N.HIMABINDHU / NIKITHA / 26KG10
-- 26KG1005: TEJA SREE / SRI PAVAN TEJA / 26KG10 | N.HIMAJASRI / NIKITHA / 26KG10