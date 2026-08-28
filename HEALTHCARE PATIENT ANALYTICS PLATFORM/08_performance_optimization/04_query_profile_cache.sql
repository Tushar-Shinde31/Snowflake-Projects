USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

ALTER SESSION SET USE_CACHED_RESULT = FALSE;

SELECT
    department,
    status,
    COUNT(*) AS appointment_count,
    SUM(consultation_fee) AS total_revenue
FROM staging_appointments
GROUP BY
    department,
    status
ORDER BY
    department,
    status;