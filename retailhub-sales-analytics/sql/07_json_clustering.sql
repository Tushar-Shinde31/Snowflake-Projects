-- STEP 8 — JSON + VARIANT + Clustering
USE DATABASE RETAIL_DW;

USE WAREHOUSE RETAIL_WH;

USE SCHEMA BRONZE;

CREATE OR REPLACE TABLE MOBILE_LOGS_RAW (
    log_id NUMBER AUTOINCREMENT,
    raw_data VARIANT
);

INSERT INTO MOBILE_LOGS_RAW (raw_data)
SELECT PARSE_JSON('{
    "event_id": "E1001",
    "customer_id": "C101",
    "device": "iPhone",
    "event_type": "login",
    "event_time": "2024-02-01 08:15:00",
    "location": {
        "city": "Mumbai",
        "country": "India"
    }
}');

INSERT INTO MOBILE_LOGS_RAW (raw_data)
SELECT PARSE_JSON('{
    "event_id": "E1002",
    "customer_id": "C102",
    "device": "Android",
    "event_type": "product_view",
    "event_time": "2024-02-01 09:20:00",
    "location": {
        "city": "Pune",
        "country": "India"
    }
}');

INSERT INTO MOBILE_LOGS_RAW (raw_data)
SELECT PARSE_JSON('{
    "event_id": "E1003",
    "customer_id": "C103",
    "device": "iPhone",
    "event_type": "add_to_cart",
    "event_time": "2024-02-01 10:05:00",
    "location": {
        "city": "Delhi",
        "country": "India"
    }
}');

INSERT INTO MOBILE_LOGS_RAW (raw_data)
SELECT PARSE_JSON('{
    "event_id": "E1004",
    "customer_id": "C104",
    "device": "Android",
    "event_type": "purchase",
    "event_time": "2024-02-01 11:30:00",
    "location": {
        "city": "Bangalore",
        "country": "India"
    }
}');

INSERT INTO MOBILE_LOGS_RAW (raw_data)
SELECT PARSE_JSON('{
    "event_id": "E1005",
    "customer_id": "C105",
    "device": "iPhone",
    "event_type": "logout",
    "event_time": "2024-02-01 12:45:00",
    "location": {
        "city": "Hyderabad",
        "country": "India"
    }
}');

SELECT *
FROM MOBILE_LOGS_RAW;

SELECT
    raw_data:event_id::VARCHAR AS event_id,
    raw_data:customer_id::VARCHAR AS customer_id,
    raw_data:device::VARCHAR AS device,
    raw_data:event_type::VARCHAR AS event_type,
    raw_data:event_time::TIMESTAMP AS event_time
FROM MOBILE_LOGS_RAW;

USE SCHEMA SILVER;

CREATE OR REPLACE TABLE MOBILE_LOGS_CLEAN AS
SELECT
    raw_data:event_id::VARCHAR AS event_id,
    raw_data:customer_id::VARCHAR AS customer_id,
    raw_data:device::VARCHAR AS device,
    raw_data:event_type::VARCHAR AS event_type,
    raw_data:event_time::TIMESTAMP AS event_time,
    raw_data:location.city::VARCHAR AS city,
    raw_data:location.country::VARCHAR AS country
FROM RETAIL_DW.BRONZE.MOBILE_LOGS_RAW;

SELECT *
FROM MOBILE_LOGS_CLEAN;

USE SCHEMA BRONZE;

CREATE OR REPLACE TABLE SALES_CLUSTERED
CLUSTER BY (order_date)
AS
SELECT *
FROM SALES_RAW;

SELECT *
FROM SALES_CLUSTERED
WHERE order_date
BETWEEN '2024-02-01' AND '2024-02-29';

SELECT SYSTEM$CLUSTERING_INFORMATION('SALES_RAW');

SELECT SYSTEM$CLUSTERING_INFORMATION(
    'RETAIL_DW.BRONZE.SALES_CLUSTERED'
);

SELECT SYSTEM$CLUSTERING_DEPTH(
    'RETAIL_DW.BRONZE.SALES_CLUSTERED'
);

SELECT *
FROM SALES_CLUSTERED
WHERE order_date >= '2024-02-01'
  AND order_date < '2024-03-01';