-- =========================================================
-- RETAILHUB SALES ANALYTICS MODERNIZATION
-- STEP 4: MEDALLION ARCHITECTURE
-- =========================================================
USE DATABASE RETAIL_DW;
USE WAREHOUSE RETAIL_WH;
USE SCHEMA SILVER;

CREATE OR REPLACE TABLE SALES_CLEAN (
    order_id NUMBER,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    amount NUMBER(12,2),
    order_date DATE
);

DESC TABLE SALES_CLEAN;

INSERT INTO SALES_CLEAN (
    order_id,
    customer_name,
    product,
    amount,
    order_date
)
SELECT
    order_id,
    customer_name,
    product,
    amount,
    order_date
FROM RETAIL_DW.BRONZE.SALES_RAW;

SELECT *
FROM RETAIL_DW.SILVER.SALES_CLEAN
ORDER BY order_id;

SELECT COUNT(*) AS silver_rows
FROM RETAIL_DW.SILVER.SALES_CLEAN;

SELECT
    (SELECT COUNT(*)
     FROM RETAIL_DW.BRONZE.SALES_RAW) AS bronze_count,

    (SELECT COUNT(*)
     FROM RETAIL_DW.SILVER.SALES_CLEAN) AS silver_count;

-- Create gold layer
USE SCHEMA GOLD;

CREATE OR REPLACE TABLE SALES_SUMMARY AS
SELECT
    product,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales,
    AVG(amount) AS average_order_value
FROM RETAIL_DW.SILVER.SALES_CLEAN
GROUP BY product;

SELECT *
FROM SALES_SUMMARY
ORDER BY total_sales DESC;

SELECT COUNT(*) AS product_count
FROM SALES_SUMMARY;

SELECT *
FROM GOLD.SALES_SUMMARY;

-- Validation Checklist
SELECT COUNT(*)
FROM RETAIL_DW.BRONZE.SALES_RAW;

SELECT COUNT(*)
FROM RETAIL_DW.SILVER.SALES_CLEAN;

SELECT *
FROM RETAIL_DW.GOLD.SALES_SUMMARY
ORDER BY total_sales DESC;