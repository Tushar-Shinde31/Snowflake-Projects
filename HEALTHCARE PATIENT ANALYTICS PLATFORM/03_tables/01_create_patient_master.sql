USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE TABLE IF NOT EXISTS patient_master
(
    patient_id          VARCHAR(10)     NOT NULL,
    patient_name        VARCHAR(100)    NOT NULL,
    gender              VARCHAR(20),
    date_of_birth       DATE,
    phone               VARCHAR(20),
    email               VARCHAR(150),
    blood_group         VARCHAR(5),
    city                VARCHAR(50),
    registration_date   DATE,

    CONSTRAINT pk_patient_master
        PRIMARY KEY (patient_id)
);

DESCRIBE TABLE patient_master;


SHOW TABLES LIKE 'PATIENT_MASTER';