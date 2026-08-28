USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE DYNAMIC TABLE IF NOT EXISTS appointment_daily_analytics
(
    appointment_date       DATE,
    department             VARCHAR(50),
    total_appointments     NUMBER,
    completed_appointments NUMBER,
    cancelled_appointments NUMBER,
    scheduled_appointments NUMBER,
    no_show_appointments   NUMBER
)
TARGET_LAG = '5 MINUTES'
WAREHOUSE = HEALTH_WH
AS
SELECT
    appointment_date,
    department,

    COUNT(*) AS total_appointments,

    COUNT_IF(status = 'Completed')
        AS completed_appointments,

    COUNT_IF(status = 'Cancelled')
        AS cancelled_appointments,

    COUNT_IF(status = 'Scheduled')
        AS scheduled_appointments,

    COUNT_IF(status = 'No Show')
        AS no_show_appointments

FROM staging_appointments
GROUP BY
    appointment_date,
    department;

SHOW DYNAMIC TABLES IN SCHEMA HEALTHCARE_DB.PATIENTS;

-- Stream
SELECT *
FROM appointment_stream;

-- Change history
SELECT *
FROM appointment_change_history
ORDER BY change_timestamp DESC;

-- Dynamic table
SELECT *
FROM appointment_daily_analytics
ORDER BY appointment_date, department;

SHOW STREAMS IN SCHEMA HEALTHCARE_DB.PATIENTS;

SHOW TASKS IN SCHEMA HEALTHCARE_DB.PATIENTS;

SHOW DYNAMIC TABLES IN SCHEMA HEALTHCARE_DB.PATIENTS;