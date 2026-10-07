# Indian Public Finance & Fiscal Analysis (2007–2026)

## Project Overview
This project provides an end-to-end SQL analysis of national-level public finance trends in India using aggregate data from the Reserve Bank of India (RBI) publication *State Finances: A Study of Budgets*. 

By structuring raw macroeconomic tables into a relational database, this analysis tracks long-term spending patterns, assesses the composition of government expenditure (Development vs. Non-Development), and measures the evolution of the Gross Fiscal Deficit across nearly two decades.

---

##  Key Objectives
- **ETL & Data Pipeline:** Clean, format, and load aggregate financial tables into MySQL.
- **Expenditure Ratios:** Quantify the proportion of state resources dedicated to social and economic development versus administrative/non-development spending.
- **Trend & Growth Analysis:** Leverage SQL window functions (`LAG()`) to calculate Year-over-Year (YoY) growth rates in development spending.
- **Deficit Dynamics:** Evaluate the share of Gross Fiscal Deficit relative to total state spending over time.

---

##  Tech Stack & Tools
- **Database Management:** MySQL
- **SQL Client:** DbGate
- **Data Preprocessing:** Google Sheets / MS Excel
- **SQL Concepts Used:** DDL (`CREATE TABLE`), DML (`INSERT`), Data Types (`BIGINT`, `VARCHAR`), Aggregate Functions (`SUM`, `AVG`, `ROUND`), Window Functions (`LAG() OVER()`).

---

##  Database Schema

```sql
CREATE TABLE rbi_public_finance (
    fiscal_year VARCHAR(20) PRIMARY KEY,
    development_expenditure_cr BIGINT,
    non_development_expenditure_cr BIGINT,
    gross_fiscal_deficit_cr BIGINT
);
