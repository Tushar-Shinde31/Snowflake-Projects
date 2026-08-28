# ❄️ Snowflake Projects

A collection of hands-on **Snowflake Data Engineering projects** built to practice data ingestion, transformation, analytics, security, performance optimization, and data sharing.

---

## 📂 Projects

### 1. 🛒 RetailHub Sales Analytics Modernization

An end-to-end retail analytics project built using Snowflake to modernize sales data processing and analytics.

**Key Objectives:**

- Sales reporting and analytics
- Real-time data ingestion
- Data transformation
- Cost optimization
- Secure data sharing

**Data Sources:**

- CSV sales files
- JSON mobile logs
- AWS S3 files

**Snowflake Concepts:**

- Database & Schema
- Virtual Warehouse
- Internal & External Stages
- File Formats
- COPY INTO
- Medallion Architecture
- Bronze / Silver / Gold Layers
- Streams
- Tasks
- Dynamic Tables
- Snowpipe
- JSON / VARIANT
- Clustering
- Time Travel
- Zero-Copy Cloning
- Resource Monitors
- Secure Views
- Materialized Views
- Data Sharing

---

### 2. 🏥 Healthcare Patient Analytics Platform

An end-to-end healthcare analytics platform built using Snowflake for managing patient, doctor, appointment, and API data.

**Key Objectives:**

- Patient analytics
- Doctor performance reporting
- Real-time appointment tracking
- Secure medical data access
- Cost optimization
- Historical data recovery
- Semi-structured JSON processing

**Data Sources:**

- Patient CSV files
- Doctor CSV files
- Appointment CSV files
- JSON appointment logs
- AWS S3 incoming data
- API-based reports

**Snowflake Concepts:**

- Database & Schema
- Multi-Cluster Warehouse
- Internal Stage
- File Formats
- COPY INTO
- Permanent Tables
- Temporary Tables
- Transient Tables
- Streams
- Tasks
- Dynamic Tables
- VARIANT
- JSON Processing
- LATERAL FLATTEN
- Masking Policies
- Row Access Policies
- Secure Views
- Clustering
- Search Optimization
- Materialized Views
- Query Performance
- Result Cache
- Snowpipe
- AWS S3
- Time Travel
- Zero-Copy Cloning
- Secure Data Sharing

---

### 3. 🛍️ Retail Sales Mini Project

A practical Snowflake project focused on the fundamentals of data loading, transformation, cloning, resource monitoring, and data sharing.

**Key Objectives:**

- Load retail sales data into Snowflake
- Perform data transformations
- Separate modified and unmodified records
- Clone tables
- Monitor warehouse usage
- Share data

**Data Model:**

```text
SALES
│
├── order_id
├── customer_name
├── product
├── amount
└── order_date
```

---

## 📁 Repository Structure

```text
Snowflake-Projects/
│
├── README.md
│
├── HEALTHCARE PATIENT ANALYTICS PLATFORM/
│   ├── 01_database_warehouse/
│   ├── 02_stages_file_formats/
│   ├── 03_tables/
│   ├── 04_data_loading/
│   ├── 05_streams_tasks_dynamic_tables/
│   ├── 06_json_processing/
│   ├── 07_security_governance/
│   ├── 08_performance_optimization/
│   └── 09_advanced_features/
│
├── retailhub-sales-analytics/
│   ├── 01_environment_setup/
│   ├── 02_stages_file_formats/
│   ├── 03_tables_data_loading/
│   ├── 04_medallion_architecture/
│   ├── 05_transformations/
│   ├── 06_streams_tasks_dynamic_tables/
│   ├── 07_s3_snowpipe/
│   ├── 08_json_optimization/
│   ├── 09_time_travel_cloning/
│   └── 10_security_views_sharing/
│
├── Snowflake Assignments/
│
├── ecommerce_dataset/
│
└── mini_project.sql
```

---

👨‍💻 Author

Tushar Shinde

B.Tech — Artificial Intelligence & Data Science

Interested in:

Data Engineering
Cloud Data Platforms
Snowflake
SQL
AI & Data
Analytics Engineering


⭐ Feel free to explore the individual project folders to view the SQL implementations and project workflows.
