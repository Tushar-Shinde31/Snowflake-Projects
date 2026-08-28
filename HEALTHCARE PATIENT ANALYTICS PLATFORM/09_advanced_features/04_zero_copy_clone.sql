USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE OR REPLACE TABLE patient_master_dev
CLONE patient_master;

SELECT COUNT(*) AS production_rows
FROM patient_master;

SELECT COUNT(*) AS cloned_rows
FROM patient_master_dev;