-- Project 5 — Finance Reporting Automation
-- MySQL 8+ style SQL
-- Table: finance_transactions
-- Columns:
-- transaction_id, date, department, vendor, category,
-- cost_center, amount, payment_status, month, budget

-- 1. Overall expense
SELECT
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_expense,
    AVG(amount) AS average_transaction
FROM finance_transactions
WHERE amount > 0;

-- 2. Monthly expense
SELECT
    month,
    SUM(amount) AS actual_expense,
    SUM(budget) AS budget_reference,
    SUM(amount) - SUM(budget) AS variance
FROM finance_transactions
GROUP BY month
ORDER BY month;

-- 3. Department analysis
SELECT
    department,
    SUM(amount) AS actual_expense,
    COUNT(*) AS transaction_count,
    AVG(amount) AS average_transaction
FROM finance_transactions
WHERE amount > 0
GROUP BY department
ORDER BY actual_expense DESC;

-- 4. Category analysis
SELECT
    category,
    SUM(amount) AS actual_expense,
    COUNT(*) AS transaction_count
FROM finance_transactions
WHERE amount > 0
GROUP BY category
ORDER BY actual_expense DESC;

-- 5. Payment status
SELECT
    payment_status,
    COUNT(*) AS transaction_count,
    SUM(amount) AS transaction_value
FROM finance_transactions
GROUP BY payment_status;

-- 6. Department + category driver analysis
SELECT
    department,
    category,
    SUM(amount) AS expense
FROM finance_transactions
WHERE amount > 0
GROUP BY department, category
ORDER BY expense DESC;

-- 7. Data-quality checks
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS distinct_transaction_ids,
    SUM(CASE WHEN vendor IS NULL OR vendor = '' THEN 1 ELSE 0 END) AS missing_vendor,
    SUM(CASE WHEN department IS NULL OR department = '' THEN 1 ELSE 0 END) AS missing_department,
    SUM(CASE WHEN amount <= 0 OR amount IS NULL THEN 1 ELSE 0 END) AS invalid_amounts
FROM finance_transactions;
