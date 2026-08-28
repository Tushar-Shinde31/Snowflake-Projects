USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE TRANSIENT TABLE IF NOT EXISTS staging_appointments
(
    appointment_id      VARCHAR(10)     NOT NULL,
    patient_id          VARCHAR(10)     NOT NULL,
    doctor_id           VARCHAR(10)     NOT NULL,
    appointment_date    DATE,
    appointment_time    TIME,
    appointment_type    VARCHAR(50),
    status              VARCHAR(30),
    department          VARCHAR(50),
    consultation_fee    NUMBER(10,2)
);


DESCRIBE TABLE staging_appointments;

SHOW TABLES LIKE 'STAGING_APPOINTMENTS';