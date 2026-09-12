# Personal Expense Analyzer

## Project Overview

Built a Python-based Personal Expense Analyzer to analyze personal spending and generate useful financial insights from expense records.

The project calculates total and average expenses, identifies the highest and lowest expenses, and generates category-wise spending summaries.

## Objectives

- Calculate total expenses
- Calculate average expenses
- Identify the highest expense
- Identify the lowest expense
- Generate category-wise expense summaries
- Structure expense data using Python data structures
- Use reusable functions for financial calculations

## Dataset

The project analyzes:

- **4 expense records**
- **3 expense categories**
- Expense fields:
  - Date
  - Category
  - Amount

## Key Results

| Metric | Result |
|---|---:|
| Total Expenses | 25,000 |
| Average Expense | 6,250 |
| Highest Expense | Rent – 15,000 |
| Lowest Expense | Food – 2,000 |

### Category Summary

| Category | Total |
|---|---:|
| Food | 7,000 |
| Travel | 3,000 |
| Rent | 15,000 |

## Python Concepts Used

- Variables
- Data Types
- Lists
- Tuples
- Sets
- Dictionaries
- `for` loops
- `if/elif/else`
- Functions
- Parameters and Arguments
- `return`
- Input Validation
- `try/except`
- Exception Handling

## Functions Developed

### `calculate_total()`
Calculates the total amount across all expense records.

### `calculate_average()`
Calculates the average expense.

### `find_highest()`
Identifies the expense with the highest amount.

### `find_lowest()`
Identifies the expense with the lowest amount.

### `category_summary()`
Groups expenses by category and calculates category-wise totals.

## Example Output

```text
Total expenses: 25000
Average expense: 6250.0
Highest expense: {'date': '2026-01-15', 'category': 'Rent', 'amount': 15000}
Lowest expense: {'date': '2026-01-20', 'category': 'Food', 'amount': 2000}

Category Summary:
Food : 7000
Travel : 3000
Rent : 15000
