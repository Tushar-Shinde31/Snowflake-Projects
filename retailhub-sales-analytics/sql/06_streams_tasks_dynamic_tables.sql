-- STEP 6 — Streams, Tasks & Dynamic Tables
USE DATABASE RETAIL_DW;
USE WAREHOUSE RETAIL_WH;
USE SCHEMA SILVER;

CREATE OR REPLACE STREAM SALES_STREAM
ON TABLE SALES_FINAL;

SHOW STREAMS;

SELECT *
FROM SALES_STREAM;

INSERT INTO SALES_FINAL
(
    order_id,
    customer_name,
    product,
    amount,
    order_date,
    status
)
VALUES
(
    1031,
    'Tushar Demo',
    'Laptop',
    85000,
    '2024-03-02',
    'HIGH_VALUE'
);

SELECT *
FROM SALES_STREAM;

SELECT
    METADATA$ACTION,
    METADATA$ISUPDATE,
    order_id,
    customer_name,
    product,
    amount
FROM SALES_STREAM;

USE SCHEMA GOLD;

CREATE OR REPLACE TABLE SALES_CDC_TARGET (
    order_id NUMBER,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    amount NUMBER(12,2),
    order_date DATE,
    status VARCHAR(30)
);

CREATE OR REPLACE TASK PROCESS_SALES_STREAM
WAREHOUSE = RETAIL_WH
SCHEDULE = '1 MINUTE'
WHEN SYSTEM$STREAM_HAS_DATA('RETAIL_DW.SILVER.SALES_STREAM')
AS
INSERT INTO RETAIL_DW.GOLD.SALES_CDC_TARGET
(
    order_id,
    customer_name,
    product,
    amount,
    order_date,
    status
)
SELECT
    order_id,
    customer_name,
    product,
    amount,
    order_date,
    status
FROM RETAIL_DW.SILVER.SALES_STREAM
WHERE METADATA$ACTION = 'INSERT';

SHOW TASKS;

ALTER TASK PROCESS_SALES_STREAM RESUME;

SHOW TASKS;

SELECT *
FROM RETAIL_DW.GOLD.SALES_CDC_TARGET;

SELECT *
FROM TABLE(
    INFORMATION_SCHEMA.TASK_HISTORY(
        TASK_NAME => 'RETAIL_DW.SILVER.PROCESS_SALES_STREAM',
        RESULT_LIMIT => 10
    )
)
ORDER BY SCHEDULED_TIME DESC;


USE SCHEMA GOLD;


CREATE OR REPLACE DYNAMIC TABLE SALES_DYNAMIC_SUMMARY
TARGET_LAG = '1 MINUTE'
WAREHOUSE = RETAIL_WH
AS
SELECT
    product,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales,
    AVG(amount) AS average_order_value
FROM RETAIL_DW.SILVER.SALES_FINAL
GROUP BY product;

SHOW DYNAMIC TABLES;

SELECT *
FROM SALES_DYNAMIC_SUMMARY
ORDER BY total_sales DESC;

USE SCHEMA SILVER;

INSERT INTO SALES_FINAL
(
    order_id,
    customer_name,
    product,
    amount,
    order_date,
    status
)
VALUES
(
    1032,
    'Dynamic Test Customer',
    'Mobile',
    50000,
    '2024-03-03',
    'HIGH_VALUE'
);