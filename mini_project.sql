-- Step 1: Create Database, Schema, Warehouse
CREATE OR REPLACE WAREHOUSE RETAIL_WH
WITH
WAREHOUSE_SIZE = 'SMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;

USE WAREHOUSE RETAIL_WH;

CREATE OR REPLACE DATABASE RETAILS;

USE DATABASE RETAILS;

CREATE OR REPLACE SCHEMA SALES;

USE SCHEMA SALES;


-- STEP 2: Create Stage & Upload the File 
CREATE OR REPLACE STAGE retail_stage;

LIST @retail_stage;

-- STEP 3: Create file format
CREATE OR REPLACE FILE FORMAT retail_csv_ff
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1;

-- STEP 4: Create Target Table
CREATE OR REPLACE TABLE sales (
    order_id NUMBER,
    customer_name VARCHAR,
    product VARCHAR,
    amount NUMBER(10,2),
    order_date DATE
);

-- STEP 5:Load Data from Stage to Table
COPY INTO sales
FROM @retail_stage
FILE_FORMAT = (FORMAT_NAME = retail_csv_ff);

SELECT * FROM sales;

SELECT COUNT(*) FROM sales;

-- STEP 6: Perform Transformations
UPDATE sales
SET amount = amount * 1.10
WHERE product = 'Laptop';

ALTER TABLE sales
ADD COLUMN status STRING;

UPDATE sales
SET status = 'HIGH'
WHERE amount > 50000;

UPDATE sales
SET status = 'LOW'
WHERE amount <= 50000;

SELECT
product,
amount,
status
FROM sales
ORDER BY amount DESC;

-- Step 7: Clone Modified Table
CREATE OR REPLACE TABLE sales_clone
CLONE sales;

CREATE OR REPLACE TABLE sales_high AS
SELECT *
FROM sales_clone
WHERE status = 'HIGH';

CREATE OR REPLACE TABLE sales_low AS
SELECT *
FROM sales_clone
WHERE status = 'LOW';

SELECT * FROM sales_high;

SELECT * FROM sales_low;

-- Step 8: Create Resource Monitor
CREATE OR REPLACE RESOURCE MONITOR retail_rm
WITH CREDIT_QUOTA = 50
TRIGGERS
ON 50 PERCENT DO NOTIFY
ON 80 PERCENT DO NOTIFY
ON 100 PERCENT DO SUSPEND;

SHOW RESOURCE MONITORS;

-- Step 9: Assign Resource Monitor to Warehouse
ALTER WAREHOUSE RETAIL_WH
SET RESOURCE_MONITOR = retail_rm;

SHOW WAREHOUSES;

-- Step 10: Share Data
CREATE OR REPLACE SHARE retail_share;

GRANT USAGE
ON DATABASE RETAILS
TO SHARE retail_share;

GRANT USAGE
ON SCHEMA RETAILS.SALES
TO SHARE retail_share;

GRANT SELECT
ON TABLE RETAILS.SALES.sales_high
TO SHARE retail_share;

GRANT SELECT
ON TABLE RETAILS.SALES.sales_low
TO SHARE retail_share;

SHOW SHARES;

SHOW SHARES;

SHOW GRANTS TO SHARE retail_share;


