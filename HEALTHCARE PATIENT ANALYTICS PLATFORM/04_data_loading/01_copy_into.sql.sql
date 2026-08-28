USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;


CREATE TABLE IF NOT EXISTS doctor_master
(
    doctor_id           VARCHAR(10)     NOT NULL,
    doctor_name         VARCHAR(100)    NOT NULL,
    specialization      VARCHAR(100),
    hospital            VARCHAR(150),
    experience_years    NUMBER(3,0),
    consultation_fee    NUMBER(10,2),
    city                VARCHAR(50),

    CONSTRAINT pk_doctor_master
        PRIMARY KEY (doctor_id)
);


COPY INTO patient_master
FROM @HEALTHCARE_INTERNAL_STAGE/patients.csv
FILE_FORMAT = (
    FORMAT_NAME = 'HEALTHCARE_DB.PATIENTS.HEALTHCARE_CSV_FORMAT'
)
ON_ERROR = 'ABORT_STATEMENT';



COPY INTO doctor_master
FROM @HEALTHCARE_INTERNAL_STAGE/doctors.csv
FILE_FORMAT = (
    FORMAT_NAME = 'HEALTHCARE_DB.PATIENTS.HEALTHCARE_CSV_FORMAT'
)
ON_ERROR = 'ABORT_STATEMENT';


COPY INTO staging_appointments
FROM @HEALTHCARE_INTERNAL_STAGE/appointments.csv
FILE_FORMAT = (
    FORMAT_NAME = 'HEALTHCARE_DB.PATIENTS.HEALTHCARE_CSV_FORMAT'
)
ON_ERROR = 'ABORT_STATEMENT';



SELECT COUNT(*) AS patient_count
FROM patient_master;



SELECT COUNT(*) AS doctor_count
FROM doctor_master;


SELECT COUNT(*) AS appointment_count
FROM staging_appointments;



SELECT *
FROM patient_master
ORDER BY patient_id
LIMIT 10;


SELECT *
FROM doctor_master
ORDER BY doctor_id
LIMIT 10;


SELECT *
FROM staging_appointments
ORDER BY appointment_id
LIMIT 10;