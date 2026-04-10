# 🛒 E-Commerce Analytics Pipeline (Use Case 3)

## 📌 Project Overview

This project demonstrates an end-to-end **ELT pipeline** built using **MySQL, StreamSets, Snowflake, and dbt**.
The objective is to transform raw **relational** and **semi-structured** e-commerce data into actionable business insights.

The pipeline focuses on:

* Customer behavior and loyalty segmentation
* Product performance analysis
* Sales trends and time-series insights

---

## 🏗️ Architecture

### 🔹 Extraction & Loading

* **Relational Data (MySQL → Snowflake)**
  Ingested core transactional tables:

  * `customers`
  * `orders`
  * `products`
  * `order_items` *(bridge table for product-level transactions)*

* **Semi-Structured Data (JSON → Snowflake)**

  * Multiple JSON files containing product reviews were uploaded to a Snowflake **stage**
  * Loaded into a table using a `VARIANT` column via `COPY INTO`

---

## 🔄 Transformation (dbt)

### 🥈 Staging Layer

* Cleaned and standardized raw data
* Renamed columns and handled null values
* Flattened JSON review data into structured columns

---

### 🥉 Intermediate Layer

* Joined multiple sources:

  * Customers ↔ Orders
  * Orders ↔ Order Items
  * Products ↔ Reviews
* Implemented **anomaly detection logic**:

  * Flagged mismatches between order totals and item-level calculations

---

### 🥇 Marts Layer

* Created business-ready datasets:

  * Customer segmentation (CLV-based)
  * Product performance metrics
  * Sales trends over time

---

## 📊 Key Features & Deliverables

### 1️⃣ Complex Data Modeling

* Built a **comprehensive sales dataset** combining:

  * Customers
  * Orders
  * Order items
  * Products

* Integrated **JSON-based product reviews** with structured product data

---

### 2️⃣ Business Logic & Metrics

* **Customer Lifetime Value (CLV)** calculation

* **Loyalty Segmentation**:

  * Gold
  * Silver
  * Bronze

* **Product Analytics**:

  * Average rating
  * Total revenue per product/category

* **Time-Series Analysis**:

  * Monthly sales trends
  * Review activity over time

---

### 3️⃣ Data Quality & Anomaly Detection

* Implemented **custom validation logic**:

  * Detect discrepancies between order totals and order item sums

* Integrated **automated testing** using `dbt-utils`:

  * Schema tests
  * Data integrity checks

---

## 🗂️ Project Structure

```
akrion_ecommerce/
├── models/
│   ├── staging/       # Data cleaning & JSON flattening
│   ├── intermediate/  # Joins & anomaly detection logic
│   └── marts/         # Final analytics tables
├── tests/             # Custom data quality tests
├── seeds/             # Static reference data
└── dbt_project.yml    # Project configuration
```

---

## ⚙️ Setup Instructions

1. Clone the repository:

   ```bash
   git clone <your-repo-url>
   cd akrion_ecommerce
   ```

2. Configure your `profiles.yml` for Snowflake

3. Install dependencies:

   ```bash
   dbt deps
   ```

4. Run the pipeline:

   ```bash
   dbt run
   ```

5. Execute tests:

   ```bash
   dbt test
   ```

---

## 🚀 Key Learnings

* Designing scalable data models using **fact and dimension tables**
* Handling **semi-structured JSON data** in Snowflake
* Building modular transformations with **dbt**
* Implementing **data quality checks and anomaly detection**
* Structuring projects for **collaboration and version control (GitHub)**

---

## 📌 Conclusion

This project showcases how modern data tools can be combined to build a **robust analytics pipeline**, enabling deeper insights into customer behavior, product performance, and business growth.

---

## 📤 Deployment

Push your project to GitHub:

```bash
git add README.md
git commit -m "docs: add comprehensive project documentation"
git push origin main
```

---
