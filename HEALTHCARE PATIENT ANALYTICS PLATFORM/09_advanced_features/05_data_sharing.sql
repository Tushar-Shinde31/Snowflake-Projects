USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE OR REPLACE SECURE VIEW insurance_appointment_analytics
AS
SELECT
    appointment_date,
    department,
    status,
    COUNT(*) AS appointment_count,
    SUM(consultation_fee) AS total_revenue,
    AVG(consultation_fee) AS average_fee
FROM staging_appointments
GROUP BY
    appointment_date,
    department,
    status;

SELECT *
FROM insurance_appointment_analytics
ORDER BY appointment_date, department;