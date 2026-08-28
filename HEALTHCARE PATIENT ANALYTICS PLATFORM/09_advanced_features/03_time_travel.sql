USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE TABLE IF NOT EXISTS patient_recovery_demo
AS
SELECT *
FROM patient_master;

SELECT COUNT(*) AS original_count
FROM patient_recovery_demo;


CREATE TABLE patient_recovery_demo_backup
CLONE patient_recovery_demo;

DELETE FROM patient_recovery_demoSELECT *
FROM patient_recovery_demo
WHERE patient_id = 'P001';
WHERE patient_id = 'P001';


