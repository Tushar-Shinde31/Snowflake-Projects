USE DATABASE RETAIL_DW;
USE WAREHOUSE RETAIL_WH;
USE SCHEMA SILVER;

SELECT *
FROM SALES_CLEAN
ORDER BY order_id;

CREATE OR REPLACE TABLE SALES_TRANSFORMED AS
SELECT  
    order_id,
    customer_name,
    product,

     CASE
        WHEN product = 'Laptop' THEN amount * 1.10
        WHEN product = 'Mobile' THEN amount * 1.05
        WHEN product = 'Monitor' THEN amount * 1.08
        WHEN product = 'Tablet' THEN amount * 1.07
        WHEN product = 'Headphones' THEN amount * 1.05
        WHEN product = 'Smartwatch' THEN amount * 1.06
        WHEN product = 'Keyboard' THEN amount * 1.04
        WHEN product = 'Mouse' THEN amount * 1.03
        ELSE amount
    END AS amount,

    order_date

FROM SALES_CLEAN;

SELECT *
FROM SALES_TRANSFORMED
ORDER BY order_id;

CREATE OR REPLACE TABLE SALES_TRANSFORMED_V2 AS
SELECT
    order_id,
    customer_name,
    product,
    amount,
    order_date,

    CASE
        WHEN amount >= 50000 THEN 'HIGH_VALUE'
        WHEN amount >= 20000 THEN 'NORMAL'
        ELSE 'LOW_VALUE'
    END AS status

FROM SALES_TRANSFORMED;

SELECT *
FROM SALES_TRANSFORMED_V2
ORDER BY order_id;

CREATE OR REPLACE TABLE SALES_FINAL AS
SELECT *
FROM SALES_TRANSFORMED_V2;

SELECT *
FROM SALES_FINAL;

SELECT
    order_id,
    COALESCE(customer_name, 'Unknown') AS customer_name,
    COALESCE(product, 'Unknown') AS product,
    COALESCE(amount, 0) AS amount,
    order_date,
    status
FROM SALES_FINAL;

SELECT
    COUNT_IF(order_id IS NULL) AS null_order_id,
    COUNT_IF(customer_name IS NULL) AS null_customer_name,
    COUNT_IF(product IS NULL) AS null_product,
    COUNT_IF(amount IS NULL) AS null_amount,
    COUNT_IF(order_date IS NULL) AS null_order_date,
    COUNT_IF(status IS NULL) AS null_status
FROM SALES_FINAL;

USE SCHEMA GOLD;

CREATE OR REPLACE TABLE SALES_SUMMARY_V2 AS
SELECT
    product,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales,
    AVG(amount) AS average_order_value,
    MIN(amount) AS minimum_order_value,
    MAX(amount) AS maximum_order_value
FROM RETAIL_DW.SILVER.SALES_FINAL
GROUP BY product;

SELECT *
FROM SALES_SUMMARY_V2
ORDER BY total_sales DESC;

SELECT
    status,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales,
    AVG(amount) AS average_order_value
FROM RETAIL_DW.SILVER.SALES_FINAL
GROUP BY status
ORDER BY total_sales DESC;

SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales
FROM RETAIL_DW.SILVER.SALES_FINAL
GROUP BY order_date
ORDER BY order_date;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    SUM(amount) AS total_sales,
    AVG(amount) AS avg_order_value
FROM RETAIL_DW.SILVER.SALES_FINAL;

SELECT
    (SELECT COUNT(*)
     FROM RETAIL_DW.BRONZE.SALES_RAW) AS bronze_rows,

    (SELECT COUNT(*)
     FROM RETAIL_DW.SILVER.SALES_FINAL) AS silver_rows;


    