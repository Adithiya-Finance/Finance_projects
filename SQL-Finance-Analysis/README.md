# SQL Finance Analysis – Accounts Payable

## Project Overview

Built a SQL-based Accounts Payable (AP) Finance Analysis project using SQLite to analyze invoice transactions, vendor spending, payment status, overdue exposure, monthly invoice trends, and payment performance.

The project demonstrates practical SQL techniques used in finance operations and accounts payable analytics.

## Business Objectives

- Analyze total invoice value and invoice volumes
- Monitor paid, pending, and overdue invoices
- Analyze vendor-wise invoice spending
- Identify high-value invoices
- Analyze monthly invoice trends
- Measure overdue exposure by vendor
- Calculate payment performance metrics
- Rank invoices within vendors
- Analyze vendor contribution to total invoice value
- Generate finance management reporting metrics

## Dataset

The project contains:

- 10 invoice records
- 4 vendors
- 4 departments
- Invoice dates from January to April 2026
- Paid, Pending, and Overdue invoice statuses

### Main Fields

| Field | Description |
|---|---|
| Invoice ID | Unique invoice identifier |
| Invoice Date | Date the invoice was created |
| Vendor | Vendor name |
| Department | Business department |
| Amount | Invoice amount |
| Status | Paid, Pending, or Overdue |
| Due Date | Invoice payment due date |
| Payment Date | Actual payment date |

## Key Financial Results

| Metric | Result |
|---|---:|
| Total Invoices | 10 |
| Total Invoice Value | ₹197,500 |
| Average Invoice Value | ₹19,750 |
| Highest Invoice | ₹42,000 |
| Lowest Invoice | ₹7,500 |
| Paid Amount | ₹94,000 |
| Pending Amount | ₹46,500 |
| Overdue Amount | ₹57,000 |
| Paid Percentage | 47.59% |
| Unpaid Percentage | 52.41% |

## Vendor Analysis

| Vendor | Total Invoice Value |
|---|---:|
| ABC Ltd | ₹69,500 |
| XYZ Ltd | ₹58,000 |
| LMN Ltd | ₹43,000 |
| PQR Ltd | ₹27,000 |

## Vendor Contribution

| Vendor | Contribution |
|---|---:|
| ABC Ltd | 35.19% |
| XYZ Ltd | 29.37% |
| LMN Ltd | 21.77% |
| PQR Ltd | 13.67% |

## Invoice Status Analysis

| Status | Invoice Count | Amount | % of Total |
|---|---:|---:|---:|
| Paid | 5 | ₹94,000 | 47.59% |
| Overdue | 2 | ₹57,000 | 28.86% |
| Pending | 3 | ₹46,500 | 23.54% |

## Monthly Invoice Analysis

| Month | Invoice Count | Total Invoice Value |
|---|---:|---:|
| January 2026 | 3 | ₹49,000 |
| February 2026 | 3 | ₹54,500 |
| March 2026 | 2 | ₹60,500 |
| April 2026 | 2 | ₹33,500 |

## Overdue Analysis

ABC Ltd has:

- 2 overdue invoices
- ₹57,000 overdue amount
- ₹69,500 total invoice value
- 82.01% overdue exposure relative to its total invoice value

## SQL Concepts Used

- SELECT
- WHERE
- ORDER BY
- LIMIT
- DISTINCT
- Aggregate Functions
  - SUM()
  - COUNT()
  - AVG()
  - MAX()
  - MIN()
- GROUP BY
- HAVING
- CASE WHEN
- Subqueries
- Common Table Expressions (CTEs)
- INNER JOIN
- LEFT JOIN
- COALESCE()
- Window Functions
  - RANK()
  - ROW_NUMBER()
- PARTITION BY
- SQLite date functions
  - strftime()
  - julianday()

## Finance Analysis Performed

### 1. Invoice Summary

Calculated:

- Total invoice value
- Average invoice value
- Highest invoice
- Lowest invoice
- Invoice count

### 2. Vendor Analysis

Analyzed:

- Vendor invoice totals
- Vendor invoice counts
- Average invoice value
- Vendor contribution percentage

### 3. Payment Status Analysis

Analyzed:

- Paid invoices
- Pending invoices
- Overdue invoices
- Paid percentage
- Unpaid percentage

### 4. Overdue Analysis

Calculated:

- Overdue invoice count
- Overdue amount
- Vendor-level overdue exposure
- Overdue percentage

### 5. Monthly Analysis

Analyzed invoice volume and invoice value by month.

### 6. Payment Performance

Calculated:

- Payment duration
- Average payment days
- Payment delay compared with due date

### 7. Advanced SQL Analysis

Used CTEs and window functions to:

- Rank vendors
- Rank invoices
- Find the highest-value invoice for each vendor
- Find the top 2 invoices for each vendor

## Example Business Questions Answered

- What is the total AP invoice value?
- How much has been paid?
- How much remains unpaid?
- Which vendors have the highest invoice value?
- Which invoices are high-value?
- Which vendors have overdue exposure?
- What percentage of invoice value is overdue?
- How does invoice value change by month?
- What is the highest-value invoice for each vendor?
- What are the top 2 invoices for each vendor?

## Project Structure

```text
SQL-Finance-Analysis/
│
├── ap_invoice_analysis.sql
└── README.md
