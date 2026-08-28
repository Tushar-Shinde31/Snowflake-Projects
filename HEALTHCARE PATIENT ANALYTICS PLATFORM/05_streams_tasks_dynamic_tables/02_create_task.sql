USE DATABASE HEALTHCARE_DB;


USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;

CREATE TABLE IF NOT EXISTS appointment_change_history
(
    appointment_id      VARCHAR(10),
    patient_id          VARCHAR(10),
    doctor_id           VARCHAR(10),
    appointment_date    DATE,
    appointment_time    TIME,
    appointment_type    VARCHAR(50),
    status              VARCHAR(30),
    department          VARCHAR(50),
    consultation_fee    NUMBER(10,2),

    change_action       VARCHAR(20),
    change_timestamp    TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE TASK IF NOT EXISTS process_appointment_stream
    WAREHOUSE = HEALTH_WH
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('HEALTHCARE_DB.PATIENTS.APPOINTMENT_STREAM')
AS
    INSERT INTO appointment_change_history
    (
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        appointment_type,
        status,
        department,
        consultation_fee,
        change_action
    )
     SELECT
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        appointment_type,
        status,
        department,
        consultation_fee,
        METADATA$ACTION
    FROM appointment_stream;


SHOW TASKS IN SCHEMA HEALTHCARE_DB.PATIENTS;

SELECT *
FROM appointment_change_history
ORDER BY change_timestamp DESC;