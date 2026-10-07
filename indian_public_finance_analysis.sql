-- Database Setup
CREATE DATABASE IF NOT EXISTS indian_public_finance;
USE indian_public_finance;

-- Schema Definition
DROP TABLE IF EXISTS rbi_public_finance;

CREATE TABLE rbi_public_finance (
    fiscal_year VARCHAR(20) PRIMARY KEY,
    development_expenditure_cr BIGINT,
    non_development_expenditure_cr BIGINT,
    gross_fiscal_deficit_cr BIGINT
);

-- Data Insertion
INSERT INTO rbi_public_finance 
(fiscal_year, development_expenditure_cr, non_development_expenditure_cr, gross_fiscal_deficit_cr) 
VALUES
('2007-08', 464462, 233232, 75454),
('2008-09', 567086, 254981, 134589),
('2009-10', 637731, 307547, 188818),
('2010-11', 720354, 357287, 161461),
('2011-12', 852405, 401059, 168353),
('2012-13', 972256, 446878, 195470),
('2013-14', 1076452, 504548, 247852),
('2014-15', 1325989, 566467, 327190),
('2015-16', 1584006, 629349, 420670),
('2016-17', 1831163, 710365, 534331),
('2017-18', 1877392, 825774, 410494),
('2018-19', 2100801, 944483, 462769),
('2019-20', 2163340, 1005162, 524710),
('2020-21', 2264470, 1063162, 804574),
('2021-22', 2598949, 1204170, 654678),
('2022-23', 2946921, 1330514, 721631),
('2023-24', 3269418, 1441816, 877194),
('2024-25_BE', 3931211, 1688857, 1039138),
('2024-25_RE', 3994549, 1637318, 1161160),
('2025-26_BE', 4348046, 1853519, 1175074);

-- Query 1: Spending Breakdown & Deficit Ratios
SELECT 
    fiscal_year,
    development_expenditure_cr AS dev_exp_cr,
    non_development_expenditure_cr AS non_dev_exp_cr,
    (development_expenditure_cr + non_development_expenditure_cr) AS total_expenditure_cr,
    gross_fiscal_deficit_cr AS fiscal_deficit_cr,
    ROUND((development_expenditure_cr * 100.0) / (development_expenditure_cr + non_development_expenditure_cr), 2) AS dev_spending_pct,
    ROUND((gross_fiscal_deficit_cr * 100.0) / (development_expenditure_cr + non_development_expenditure_cr), 2) AS deficit_to_total_exp_pct
FROM rbi_public_finance
ORDER BY fiscal_year ASC;

-- Query 2: YoY Growth Rate using Window Functions
SELECT 
    fiscal_year,
    development_expenditure_cr,
    LAG(development_expenditure_cr, 1) OVER (ORDER BY fiscal_year ASC) AS prev_year_dev_exp,
    development_expenditure_cr - LAG(development_expenditure_cr, 1) OVER (ORDER BY fiscal_year ASC) AS yoy_change_cr,
    ROUND(
        (development_expenditure_cr - LAG(development_expenditure_cr, 1) OVER (ORDER BY fiscal_year ASC)) * 100.0 
        / LAG(development_expenditure_cr, 1) OVER (ORDER BY fiscal_year ASC), 2
    ) AS yoy_growth_pct
FROM rbi_public_finance
ORDER BY fiscal_year ASC;

-- Query 3: Macro Summary Metrics
SELECT 
    COUNT(*) AS total_fiscal_years,
    MIN(fiscal_year) AS start_year,
    MAX(fiscal_year) AS end_year,
    MIN(development_expenditure_cr) AS min_dev_exp_cr,
    MAX(development_expenditure_cr) AS max_dev_exp_cr,
    ROUND(MAX(development_expenditure_cr) * 1.0 / MIN(development_expenditure_cr), 2) AS total_growth_multiple,
    ROUND(AVG(gross_fiscal_deficit_cr), 0) AS avg_annual_fiscal_deficit_cr
FROM rbi_public_finance;
