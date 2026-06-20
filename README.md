# Bank Transaction Risk Analysis

## Project Overview

This project analyzes a dataset of **2,512 banking transactions** to identify transaction patterns, investigate potential fraud indicators, and provide business insights through data analysis.

The project follows a complete analytics workflow by combining **Excel**, **SQL (Google BigQuery)**, and **Tableau** to transform raw transaction data into meaningful insights and interactive visualizations.

---

## Business Problem

Financial institutions process thousands of transactions every day. Identifying suspicious behavior quickly is critical for reducing fraud and protecting customer accounts.

The objective of this project was to:

* Explore transaction behavior across multiple channels.
* Identify characteristics associated with potentially fraudulent transactions.
* Analyze customer behavior using SQL.
* Build an interactive Tableau dashboard for business users.

---

## Tools Used

* SQL (Google BigQuery)
* Tableau
* Microsoft Excel
* GitHub

---

## Dataset

The dataset contains **2,512 banking transactions** and includes information such as:

* Transaction Amount
* Transaction Type
* Transaction Date
* Account Balance
* Login Attempts
* Transaction Channel
* Customer Occupation
* Geographic Location

A custom **RiskFlag** field was created during data preparation to identify transactions meeting predefined fraud-risk conditions.

---

## SQL Analysis

Using Google BigQuery, SQL was used to investigate:

* Transaction volume and distribution
* Customer transaction behavior
* Channel performance
* Occupation analysis
* Login attempt patterns
* Account-level transaction summaries
* High-value transactions
* Fraud-related transaction characteristics

More than **20 SQL queries** were developed to answer business questions and generate actionable insights.

---

## Tableau Dashboard

An interactive Tableau dashboard was created to visualize:

* Total transactions
* Flagged transactions
* Transaction distribution
* Transaction amount distribution
* Channel comparisons
* Transaction type analysis
* Interactive dashboard filters

---

## Key Findings

* Analyzed **2,512 transactions**.
* Identified **14 flagged transactions** using rule-based risk criteria.
* Each flagged transaction belonged to a unique account.
* Flagged transactions occurred through the Online channel based on the project’s risk rule.
* ATM transactions had the highest average transaction amount.
* Students recorded the highest average transaction amount among occupations with substantial transaction volume.
* Flagged transactions averaged approximately **$200 more** than unflagged transactions.
* No meaningful relationship was observed between login attempts and transaction amount.

---

## Repository Contents

```
README.md
SQL_Queries.sql
Findings.md
Tableau_Dashboard.png
dashboard.twbx
```

---

## Skills Demonstrated

* SQL querying
* Data aggregation
* Exploratory data analysis (EDA)
* Fraud pattern analysis
* Data visualization
* Dashboard design
* Business insight generation
* Analytical problem solving

---

## Future Improvements

* Implement statistical anomaly detection.
* Develop predictive fraud classification models using Python.
* Build automated reporting workflows.
* Compare rule-based detection with machine learning techniques.
