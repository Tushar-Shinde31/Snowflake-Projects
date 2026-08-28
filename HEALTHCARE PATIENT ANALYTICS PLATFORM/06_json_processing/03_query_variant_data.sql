

USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;


SELECT
    payload
FROM appointment_api_logs
LIMIT 5;

SELECT
    payload:log_id::VARCHAR AS log_id,
    payload:appointment_id::VARCHAR AS appointment_id,
    payload:event_type::VARCHAR AS event_type,
    payload:diagnosis::VARCHAR AS diagnosis,
    payload:event_timestamp::TIMESTAMP_NTZ AS event_timestamp
FROM appointment_api_logs
ORDER BY event_timestamp;

SELECT
    payload:log_id::VARCHAR AS log_id,

    payload:patient:id::VARCHAR AS patient_id,

    payload:patient:name::VARCHAR AS patient_name,

    payload:doctor:id::VARCHAR AS doctor_id,

    payload:doctor:name::VARCHAR AS doctor_name

FROM appointment_api_logs;

SELECT
    payload:log_id::VARCHAR AS log_id,
    payload:patient:id::VARCHAR AS patient_id,
    symptom.value::VARCHAR AS symptom
FROM appointment_api_logs,
LATERAL FLATTEN(
    INPUT => payload:symptoms
) symptom
ORDER BY log_id;

SELECT
    payload:log_id::VARCHAR AS log_id,

    payload:appointment_id::VARCHAR AS appointment_id,

    payload:patient:id::VARCHAR AS patient_id,

    payload:patient:name::VARCHAR AS patient_name,

    payload:doctor:id::VARCHAR AS doctor_id,

    payload:doctor:name::VARCHAR AS doctor_name,

    symptom.value::VARCHAR AS symptom,

    payload:diagnosis::VARCHAR AS diagnosis,

    payload:event_type::VARCHAR AS event_type,

    payload:event_timestamp::TIMESTAMP_NTZ AS event_timestamp

FROM appointment_api_logs,

LATERAL FLATTEN(
    INPUT => payload:symptoms
) symptom

ORDER BY event_timestamp;