
USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

LIST @HEALTHCARE_INTERNAL_STAGE;


SELECT
    $1 AS patient_id,
    $2 AS patient_name,
    $3 AS gender,
    $4 AS date_of_birth,
    $5 AS phone,
    $6 AS email,
    $7 AS blood_group,
    $8 AS city,
    $9 AS registration_date
FROM @HEALTHCARE_INTERNAL_STAGE/patients.csv
(
    FILE_FORMAT => 'HEALTHCARE_DB.PATIENTS.HEALTHCARE_CSV_FORMAT'
)
LIMIT 10;


SELECT
    $1 AS doctor_id,
    $2 AS doctor_name,
    $3 AS specialization,
    $4 AS hospital,
    $5 AS experience_years,
    $6 AS consultation_fee,
    $7 AS city
FROM @HEALTHCARE_INTERNAL_STAGE/doctors.csv
(
    FILE_FORMAT => 'HEALTHCARE_DB.PATIENTS.HEALTHCARE_CSV_FORMAT'
)
LIMIT 10;


SELECT
    $1 AS appointment_id,
    $2 AS patient_id,
    $3 AS doctor_id,
    $4 AS appointment_date,
    $5 AS appointment_time,
    $6 AS appointment_type,
    $7 AS status,
    $8 AS department,
    $9 AS consultation_fee
FROM @HEALTHCARE_INTERNAL_STAGE/appointments.csv
(
    FILE_FORMAT => 'HEALTHCARE_DB.PATIENTS.HEALTHCARE_CSV_FORMAT'
)
LIMIT 10;