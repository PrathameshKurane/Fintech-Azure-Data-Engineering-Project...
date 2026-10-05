# Fintech Data Migration Project
# Azure Data Engineering Pipeline

An end-to-end Azure Data Engineering project that demonstrates how transactional fintech data can be ingested, transformed, validated, and prepared for analytics using **Azure Data Factory, Azure Data Lake Storage Gen2, Azure Databricks, PySpark, Delta Lake, Unity Catalog, Azure Key Vault, and Logic Apps**.

The project follows a **Medallion Architecture** with separate Bronze, Silver, and Gold layers to provide a structured and scalable approach to data processing.

---

## 📌 Project Overview

This project simulates a financial data platform where data from an **Azure SQL Database** is extracted through Azure Data Factory and stored in Azure Data Lake Storage Gen2.

The raw data is then processed using Azure Databricks and PySpark:

* **Bronze** → Raw source data
* **Silver** → Cleansed and validated data
* **Gold** → Business-ready analytical datasets

The pipeline also incorporates data-quality checks, Delta Lake processing, secure credential management, and automated email notifications.

---

## 🏗️ Architecture

```text
                    ┌──────────────────────┐
                    │   Azure SQL Database │
                    │      Source Data     │
                    └──────────┬───────────┘
                               │
                               │
                     Azure Data Factory
                               │
                    Lookup + ForEach + Copy
                               │
                               ▼
              ┌────────────────────────────────┐
              │       ADLS Gen2 - Bronze       │
              │          Raw Data              │
              └───────────────┬────────────────┘
                              │
                              │
                       Azure Databricks
                         PySpark / Delta
                              │
                              ▼
              ┌────────────────────────────────┐
              │       ADLS Gen2 - Silver       │
              │ Cleansed + Validated + Enriched│
              └───────────────┬────────────────┘
                              │
                              │
                       Databricks
                    Business Transformations
                              │
                              ▼
              ┌────────────────────────────────┐
              │        ADLS Gen2 - Gold        │
              │    Analytics-ready datasets   │
              └───────────────┬────────────────┘
                              │
                              ▼
                    Reporting / Analytics

              ┌────────────────────────────────┐
              │ Azure Logic Apps               │
              │ Pipeline Notifications         │
              └────────────────────────────────┘
```



---

## 🛠️ Technology Stack

| Component         | Technology                   |
| ----------------- | ---------------------------- |
| Source            | Azure SQL Database           |
| Orchestration     | Azure Data Factory           |
| Storage           | Azure Data Lake Storage Gen2 |
| Processing        | Azure Databricks             |
| Programming       | PySpark / Python / SQL       |
| Storage Format    | Delta Lake                   |
| Governance        | Unity Catalog                |
| Secret Management | Azure Key Vault              |
| Notifications     | Azure Logic Apps             |
| Version Control   | Git / GitHub                 |


🔄 Data Pipeline stages

![image alt](https://github.com/PrathameshKurane/Fintech-Data-Project/blob/fa104186f49f7b3e15be363482b03abba47869fe/pipeline_stages.PNG)

---
1. Bronze — Raw Ingestion
An ADF pipeline dynamically discovers all tables in the source database (via INFORMATION_SCHEMA.TABLES) and copies each one into ADLS Gen2 as-is, using a parameterized ForEach loop — no hardcoded table list, so new source tables are picked up automatically.

2. Silver — Validation, Cleansing & Enrichment
A Databricks notebook:

Validates row counts between the source SQL tables and the Bronze layer, failing the pipeline on mismatch to prevent incomplete data from propagating downstream
Scores data quality per table (null-rate based) and flags tables falling below a 95% threshold
Cleanses and standardizes each table — e.g., normalizing account types, capping invalid interest rates, trimming/casing text fields, correcting negative balances
Enriches each table with derived business fields — customer segment/tier, account status/tier, loan risk category, transaction category/size, payment method grouping
Writes using Delta MERGE (upsert) rather than overwrite, keyed on each table's primary key — making writes idempotent and safe to re-run without duplicating data


3. Gold — Star Schema
A second Databricks notebook builds an analytics-ready dimensional model:

Dimensions: dim_customers, dim_accounts, dim_loans, dim_time
Facts: fact_transactions, fact_payments, fact_customer_accounts
Aggregates: agg_customer_summary, agg_account_summary, agg_loan_summary — pre-computed rollups for reporting (transaction volume, deposit/withdrawal totals, late payment rates, etc.)

# 🔔 Pipeline Monitoring & Notifications

Azure Data Factory can trigger an Azure Logic App after pipeline execution.


ADF Pipeline
     │
     ├── Success ──► Logic App ──► Success Email
     │
     └── Failure ──► Logic App ──► Failure Email


This provides an automated notification mechanism without requiring continuous manual monitoring.

---

# 📁 Repository Structure

azure-fintech-data-pipeline/
├── adf-pipelines/
│   └── PL_FintechMigration.json      # ADF pipeline definition
├── databricks-notebooks/
│   ├── 01_bronze_to_silver.ipynb     # Validation, cleansing, enrichment, upsert
│   └── 02_silver_to_gold.ipynb       # Star schema build
├── sql_database_tables/
│   ├── Customers.sql
│   ├── Accounts.sql
│   ├── Loans.sql
│   ├── Transactions.sql
│   └── Payments.sql
└── README.md

# 🚀 Key Features

* Metadata-driven ingestion using Azure Data Factory
* Parameterized pipelines
* Dynamic table processing with ForEach
* ADLS Gen2 data lake storage
* Medallion Architecture
* PySpark transformations
* Delta Lake processing
* Data-quality validation
* Fact and dimension modeling
* Unity Catalog governance
* Azure Key Vault integration
* Automated pipeline notifications
* Git/GitHub version control

---

# 🔮 Future Enhancements

The pipeline can be extended with:

* Incremental loading using watermark columns
* Change Data Capture (CDC)
* Slowly Changing Dimensions (SCD Type 2)
* Pipeline audit tables
* Failed-record quarantine
* Automated data-quality reports
* Databricks Workflows
* CI/CD using Azure DevOps
* Power BI reporting layer
* Performance optimization using partitioning and file compaction

---

# 🎯 Learning Objectives

This project demonstrates practical experience with:

1. Azure Data Factory orchestration
2. Azure Data Lake Storage Gen2
3. Azure Databricks
4. PySpark
5. Delta Lake
6. Medallion Architecture
7. Data-quality engineering
8. Dimensional modeling
9. Azure security concepts
10. End-to-end cloud data pipeline development

---

## 👨‍💻 Author

Prathamesh Kurane

Data Engineering | Azure | Databricks | PySpark | SQL | ADF
