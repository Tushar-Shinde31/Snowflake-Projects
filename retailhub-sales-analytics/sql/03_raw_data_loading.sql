USE WAREHOUSE RETAIL_WH;

USE DATABASE RETAIL_DW;

USE SCHEMA BRONZE;

SELECT
    CURRENT_DATABASE(),
    CURRENT_SCHEMA(),
    CURRENT_WAREHOUSE();

CREATE OR REPLACE TABLE SALES_RAW (
    order_id NUMBER,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    amount NUMBER(12,2),
    order_date DATE
);

DESC TABLE SALES_RAW;

-- Load the CSV
COPY INTO SALES_RAW
FROM @RETAIL_STAGE
FILE_FORMAT = (
    FORMAT_NAME = 'RETAIL_CSV_FORMAT'
);

SELECT *
FROM SALES_RAW
ORDER BY order_id;

-- Check Row Count
SELECT COUNT(*) AS total_rows
FROM SALES_RAW;

-- Check NULL Values
SELECT
    COUNT(*) AS total_rows,
    COUNT_IF(order_id IS NULL) AS null_order_id,
    COUNT_IF(customer_name IS NULL) AS null_customer_name,
    COUNT_IF(product IS NULL) AS null_product,
    COUNT_IF(amount IS NULL) AS null_amount,
    COUNT_IF(order_date IS NULL) AS null_order_date
FROM SALES_RAW;

-- Check Duplicate Orders
SELECT
    order_id,
    COUNT(*) AS cnt
FROM SALES_RAW
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check Amount Values
SELECT
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount,
    AVG(amount) AS average_amount,
    SUM(amount) AS total_sales
FROM SALES_RAW;

-- Check the Data by Product
SELECT
    product,
    COUNT(*) AS orders,
    SUM(amount) AS total_sales
FROM SALES_RAW
GROUP BY product
ORDER BY total_sales DESC;

-- Check COPY History
SELECT *
FROM TABLE(
    INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME => 'RETAIL_DW.BRONZE.SALES_RAW',
        START_TIME => DATEADD('hour', -1, CURRENT_TIMESTAMP())
    )
)
ORDER BY LAST_LOAD_TIME DESC;03_raw_data_loading