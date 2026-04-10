E-Commerce Analytics (Use Case 3)
Project Overview:


This project demonstrates an end-to-end ELT pipeline using MySQL, StreamSets, Snowflake, and dbt. The goal was to transform raw relational and semi-structured e-commerce data into actionable business insights, focusing on customer loyalty, product performance, and sales trends.

Architecture
Extraction & Loading:

Relational Data: Ingested 4 tables (customers, orders, products, order_items) from a MySQL database into Snowflake via StreamSets.

Semi-Structured Data: Uploaded multiple JSON files (product reviews) to a Snowflake Stage and loaded them into a VARIANT column using the COPY INTO command.

Transformation (dbt):

Staging Layer: Cleaned raw data and flattened JSON objects into structured columns.

Intermediate Layer: Joined multiple sources and implemented advanced anomaly detection to flag discrepancies between order totals and line-item sums.

Marts Layer: Aggregated data to calculate Customer Lifetime Value (CLV), product ratings, and time-series sales trends.

Key Features & Deliverables
1. Complex Data Modeling

Comprehensive Sales Dataset: A unified view joining customers, orders, and products to provide a 360-degree view of transactions.

JSON Integration: Successfully parsed and joined product reviews from JSON sources to the relational product catalog.

2. Business Logic & Metrics

Loyalty Segmentation: Customers are automatically categorized into Gold, Silver, or Bronze tiers based on their calculated CLV.

Performance Analytics: Calculated average product ratings and total revenue per category.

Time-Series Analysis: Monthly sales trends to monitor business growth over time.

3. Data Quality & Anomaly Detection

Implemented a custom logic check to identify "Header vs. Detail" amount mismatches (e.g., catching errors like Order #1005).

Utilized dbt-utils for automated schema testing and data validation.

Project Structure
Plaintext
akrion_ecommerce/
├── models/
│   ├── staging/      # Raw data cleaning & JSON flattening
│   ├── intermediate/ # Complex joins & anomaly detection logic
│   └── marts/        # Final business-facing tables (Loyalty, Sales, Reviews)
├── tests/            # Custom data quality tests
├── seeds/            # Static reference data
└── dbt_project.yml   # Project configuration & schema management
Setup Instructions
Clone the repository.

Ensure your profiles.yml is configured for Snowflake.

Install dependencies: dbt deps.

Run the pipeline: dbt run.

Test the data: dbt test.

🚀 Final Step

Create a file named README.md in your main folder.

Paste the content above.

Run the final push to GitHub:

Bash
git add README.md
git commit -m "docs: add comprehensive project documentation"
git push origin main
