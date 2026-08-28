
USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;



CREATE MASKING POLICY IF NOT EXISTS patient_phone_mask
AS
(
    phone_value VARCHAR
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
    CASE
        WHEN CURRENT_ROLE() IN ('HEALTHCARE_DOCTOR', 'ACCOUNTADMIN')
            THEN phone_value
        ELSE
            '**********'
    END
$$;




CREATE MASKING POLICY IF NOT EXISTS patient_email_mask
AS
(
    email_value VARCHAR
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
    CASE
        WHEN CURRENT_ROLE() IN ('HEALTHCARE_DOCTOR', 'ACCOUNTADMIN')
            THEN email_value
        ELSE
            '********@masked.com'
    END
$$;


ALTER TABLE patient_master
MODIFY COLUMN phone
SET MASKING POLICY patient_phone_mask;



ALTER TABLE patient_master
MODIFY COLUMN email
SET MASKING POLICY patient_email_mask;



SHOW MASKING POLICIES;