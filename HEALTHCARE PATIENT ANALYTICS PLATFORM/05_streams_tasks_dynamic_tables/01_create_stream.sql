USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE STREAM IF NOT EXISTS appointment_stream
ON TABLE staging_appointments
APPEND_ONLY = FALSE;

SHOW STREAMS IN SCHEMA HEALTHCARE_DB.PATIENTS;

DESCRIBE STREAM appointment_stream;

INSERT INTO staging_appointments
(
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    appointment_time,
    appointment_type,
    status,
    department,
    consultation_fee
)
VALUES
(
    'A0061',
    'P001',
    'D001',
    '2026-08-20',
    '10:30:00',
    'Consultation',
    'Scheduled',
    'Cardiology',
    1000
);

SELECT *
FROM appointment_stream;