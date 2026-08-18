USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE TEMPORARY TABLE IF NOT EXISTS temp_reports
(
    report_id       VARCHAR(20),
    patient_id      VARCHAR(10),
    report_type     VARCHAR(50),
    report_date     DATE,
    report_status   VARCHAR(30),
    report_value    NUMBER(12,2),
    created_at      TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


DESCRIBE TABLE temp_reports;


SHOW TABLES LIKE 'TEMP_REPORTS';