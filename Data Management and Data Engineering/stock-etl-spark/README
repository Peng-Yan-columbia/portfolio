## 🎥 Demo
[▶ Watch Demo Video](https://drive.google.com/file/d/1j8B3nDIbdbNRt1UHYi7dn9y52gf0sqRE/view?usp=sharing)
---

# 🧠 Project Overview: Stock ETL and Spark Analytics

This project demonstrates an end-to-end data pipeline integrating **SQL**, **NoSQL**, and **Apache Spark** for large-scale stock analysis and interactive visualization.

---

## 💾 Data Architecture

- **PostgreSQL (SQL):**  
  All **stock price information** is stored in a relational database, since the data is **highly structured and time-series based** (e.g., date, open, high, low, close, volume).  
  - Enables efficient **indexing**, **joins**, and **window functions** for daily or rolling calculations.  
  - Ensures **data integrity** and schema consistency across millions of records.

- **MongoDB (NoSQL):**  
  All **company metadata** (sector, industry, description, website, etc.) is stored in a document-based database because it’s **semi-structured and flexible**.  
  - Different companies may have unique fields, making JSON documents ideal.  
  - Each document is linked to its SQL records using a shared **`ticker`** key.

---

## ⚙️ ETL and Analytics Workflow

- **Extraction:** Raw CSV and JSON data are loaded into PostgreSQL and MongoDB.  
- **Transformation:**  
  Spark is used to parallelize key computations such as:
  - **Daily Return**, **Adjusted Return**, **Log Return**, **High-Low Range**, and **Price Change**  
  - **Multi-ticker and multi-date selection** for analytics via Spark DataFrame operations  
  - Optimized joins between SQL and NoSQL layers for hybrid querying.
- **Loading:** The transformed datasets are pushed to the website layer for **interactive display** and **user selection**.

---

## 🌐 Website Functionality

- Users can dynamically **select multiple tickers and date ranges** to visualize computed financial metrics in real time.  
- The web interface calls backend Spark jobs for computation and renders updated tables and charts without reloading.

---

## 📈 Tech Stack

| Layer | Technology | Purpose |
|-------|-------------|----------|
| Storage | PostgreSQL | Structured stock data |
| Storage | MongoDB | Unstructured company info |
| Processing | Apache Spark | Distributed computation & integration |
| Backend | Flask | API and web interface |
| Frontend | HTML / JS | Interactive display |
| Version Control | Git + Git LFS | Handles code & large demo video files |
