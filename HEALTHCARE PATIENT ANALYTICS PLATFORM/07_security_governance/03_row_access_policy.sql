

USE DATABASE HEALTHCARE_DB;

USE SCHEMA PATIENTS;

USE WAREHOUSE HEALTH_WH;



CREATE TABLE IF NOT EXISTS healthcare_role_city_access
(
    role_name   VARCHAR(100),
    city        VARCHAR(50)
);



INSERT INTO healthcare_role_city_access
(
    role_name,
    city
)
SELECT
    'HEALTHCARE_ANALYST',
    'Pune'
WHERE NOT EXISTS
(
    SELECT 1
    FROM healthcare_role_city_access
    WHERE role_name = 'HEALTHCARE_ANALYST'
      AND city = 'Pune'
);



CREATE ROW ACCESS POLICY IF NOT EXISTS patient_city_access_policy
AS
(
    city_value VARCHAR
)
RETURNS BOOLEAN
LANGUAGE SQL
AS
$$
    CASE

        WHEN CURRENT_ROLE() IN
        (
            'HEALTHCARE_DOCTOR',
            'ACCOUNTADMIN'
        )
        THEN TRUE

        WHEN CURRENT_ROLE() = 'HEALTHCARE_ANALYST'
        THEN EXISTS
        (
            SELECT 1
            FROM healthcare_role_city_access
            WHERE role_name = CURRENT_ROLE()
              AND city = city_value
        )

        ELSE FALSE

    END
$$;



ALTER TABLE patient_master
ADD ROW ACCESS POLICY patient_city_access_policy
ON (city);


SHOW ROW ACCESS POLICIES;