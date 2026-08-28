

USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;



CREATE OR REPLACE SECURE VIEW secure_patient_analytics
AS
SELECT
    patient_id,
    patient_name,
    gender,
    date_of_birth,
    blood_group,
    city,
    registration_date
FROM patient_master;


CREATE OR REPLACE SECURE VIEW secure_appointment_analytics
AS
SELECT
    a.appointment_id,
    a.patient_id,
    p.patient_name,
    a.doctor_id,
    a.appointment_date,
    a.appointment_time,
    a.appointment_type,
    a.status,
    a.department,
    a.consultation_fee
FROM staging_appointments a
LEFT JOIN patient_master p
    ON a.patient_id = p.patient_id;



GRANT SELECT
ON VIEW secure_patient_analytics
TO ROLE HEALTHCARE_ANALYST;

GRANT SELECT
ON VIEW secure_patient_analytics
TO ROLE HEALTHCARE_DOCTOR;


GRANT SELECT
ON VIEW secure_appointment_analytics
TO ROLE HEALTHCARE_ANALYST;

GRANT SELECT
ON VIEW secure_appointment_analytics
TO ROLE HEALTHCARE_DOCTOR;



SHOW VIEWS IN SCHEMA HEALTHCARE_DB.PATIENTS;