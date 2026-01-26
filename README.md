**PROJECT OVERVIEW**

This project implements an AWS-based pipeline for ingesting, staging, and structuring financial text data from Alpha Vantage and Financial Modeling Prep.

The system automates the collection of earnings transcripts and news articles and loads them into Apache Iceberg tables for analytical use. It is designed to support scheduled execution, structured data processing, and reliable analytical querying.

---

**SYSTEM ARCHITECTURE**

The pipeline is organized into scheduling, orchestration, ingestion, staging, and analytical storage layers.

**Scheduling (EventBridge)**

EventBridge schedules trigger the pipeline at fixed intervals.

- Earnings transcripts are scheduled quarterly  
- News articles are scheduled daily at 7:00 AM  

Each schedule triggers a Step Functions workflow.

**Orchestration (Step Functions)**

Step Functions workflows coordinate all pipeline activities.

- An input parameter provides a list of stock tickers  
- Workflows iterate over tickers and reporting periods  
- Each iteration manages ingestion, staging, and merging  

This layer controls execution order and workflow coordination.

**Ingestion – Bronze Layer**

The Bronze layer handles raw data ingestion.

AWS Lambda functions fetch earnings transcripts and news articles from external APIs and store the results as JSON files in S3.

**Staging and Analytical Storage – Silver Layer**

The Silver layer handles transformation, merging, and analytical storage.

Athena external tables are created over raw JSON files. Staged data is transformed and upserted into Apache Iceberg tables stored in S3. These Iceberg tables serve as the analytical storage layer and support incremental updates and querying.

---

**REPOSITORY STRUCTURE AND COMPONENTS**

The repository is organized into four main folders based on pipeline responsibilities.

**raw_processing**

Contains AWS Lambda functions for data ingestion.

- Earnings transcript ingestion from Alpha Vantage  
- News article ingestion from Financial Modeling Prep  

These functions fetch external data and write raw JSON files to S3.

**staging_processing**

Contains Athena queries for staging and merging data.

- Create external tables on raw JSON files  
- Upsert staged data into Iceberg tables  

This layer handles transformation and analytical preparation.

**orchestration**

Contains Step Functions workflows.

- Quarterly earnings transcript workflow  
- Daily news article workflow  

These workflows coordinate ingestion, staging, and merge operations.

**environment_setup**

Contains Athena queries for environment initialization.

- Create Apache Iceberg tables  
- Define table schemas and properties  

This layer prepares the analytical storage environment.
