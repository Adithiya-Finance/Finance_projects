-- ============================================================
-- Project 3: AP Invoice Finance Analysis
-- Database: SQLite
-- Purpose: Analyze Accounts Payable invoice data
-- ============================================================


-- ============================================================
-- SECTION 1: CREATE INVOICES TABLE
-- ============================================================

CREATE TABLE invoices (
    invoice_id TEXT,
    invoice_date DATE,
    vendor TEXT,
    department TEXT,
    amount DECIMAL(10,2),
    status TEXT,
    due_date DATE,
    payment_date DATE
);


-- ============================================================
-- SECTION 2: INSERT INVOICE DATA
-- ============================================================

INSERT INTO invoices VALUES
('INV001', '2026-01-05', 'ABC Ltd', 'Finance', 12500, 'Paid', '2026-02-04', '2026-01-28'),
('INV002', '2026-01-12', 'XYZ Ltd', 'IT', 28000, 'Pending', '2026-02-11', NULL),
('INV003', '2026-01-20', 'PQR Ltd', 'Operations', 8500, 'Paid', '2026-02-19', '2026-02-15'),
('INV004', '2026-02-03', 'ABC Ltd', 'HR', 15000, 'Overdue', '2026-03-05', NULL),
('INV005', '2026-02-15', 'LMN Ltd', 'Finance', 32000, 'Paid', '2026-03-17', '2026-03-10'),
('INV006', '2026-02-25', 'XYZ Ltd', 'IT', 7500, 'Pending', '2026-03-27', NULL),
('INV007', '2026-03-10', 'PQR Ltd', 'Operations', 18500, 'Paid', '2026-04-09', '2026-04-05'),
('INV008', '2026-03-18', 'ABC Ltd', 'Finance', 42000, 'Overdue', '2026-04-17', NULL),
('INV009', '2026-04-02', 'LMN Ltd', 'HR', 11000, 'Pending', '2026-05-02', NULL),
('INV010', '2026-04-15', 'XYZ Ltd', 'IT', 22500, 'Paid', '2026-05-15', '2026-05-08');


-- ============================================================
-- SECTION 3: CREATE VENDORS TABLE
-- ============================================================

CREATE TABLE vendors (
    vendor_id INTEGER,
    vendor_name TEXT,
    vendor_category TEXT
);


-- ============================================================
-- SECTION 4: INSERT VENDOR DATA
-- ============================================================

INSERT INTO vendors VALUES
(101, 'ABC Ltd', 'Technology'),
(102, 'XYZ Ltd', 'Technology'),
(103, 'PQR Ltd', 'Operations'),
(104, 'LMN Ltd', 'Professional Services');


-- ============================================================
-- SECTION 5: BASIC INVOICE ANALYSIS
-- ============================================================

-- Total invoice value
SELECT
    SUM(amount) AS total_invoice_value
FROM invoices;


-- Average invoice value
SELECT
    AVG(amount) AS average_invoice_value
FROM invoices;


-- Highest invoice
SELECT
    invoice_id,
    vendor,
    amount
FROM invoices
ORDER BY amount DESC
LIMIT 1;


-- Lowest invoice
SELECT
    invoice_id,
    vendor,
    amount
FROM invoices
ORDER BY amount ASC
LIMIT 1;


-- Invoice count
SELECT
    COUNT(*) AS invoice_count
FROM invoices;


-- ============================================================
-- SECTION 6: STATUS ANALYSIS
-- ============================================================

SELECT
    status,
    COUNT(*) AS invoice_count,
    SUM(amount) AS total_amount
FROM invoices
GROUP BY status
ORDER BY total_amount DESC;


-- Status percentage of total invoice value
SELECT
    status,
    COUNT(*) AS invoice_count,
    SUM(amount) AS total_amount,
    ROUND(
        SUM(amount) * 100.0 /
        (SELECT SUM(amount) FROM invoices),
        2
    ) AS percentage_of_total
FROM invoices
GROUP BY status
ORDER BY total_amount DESC;


-- ============================================================
-- SECTION 7: PAID VS UNPAID ANALYSIS
-- ============================================================

-- Paid invoice percentage
SELECT
    SUM(
        CASE
            WHEN status = 'Paid' THEN amount
            ELSE 0
        END
    ) AS paid_amount,

    SUM(amount) AS total_invoice_value,

    ROUND(
        SUM(
            CASE
                WHEN status = 'Paid' THEN amount
                ELSE 0
            END
        ) * 100.0 / SUM(amount),
        2
    ) AS paid_percentage
FROM invoices;


-- Unpaid invoice percentage
SELECT
    SUM(
        CASE
            WHEN status != 'Paid' THEN amount
            ELSE 0
        END
    ) AS unpaid_amount,

    SUM(amount) AS total_invoice_value,

    ROUND(
        SUM(
            CASE
                WHEN status != 'Paid' THEN amount
                ELSE 0
            END
        ) * 100.0 / SUM(amount),
        2
    ) AS unpaid_percentage
FROM invoices;


-- ============================================================
-- SECTION 8: VENDOR ANALYSIS
-- ============================================================

-- Total invoice value by vendor
SELECT
    vendor,
    SUM(amount) AS total_invoice_value
FROM invoices
GROUP BY vendor
ORDER BY total_invoice_value DESC;


-- Vendor invoice count and average
SELECT
    vendor,
    COUNT(*) AS invoice_count,
    SUM(amount) AS total_invoice_value,
    ROUND(AVG(amount), 2) AS average_invoice_value
FROM invoices
GROUP BY vendor
ORDER BY average_invoice_value DESC;


-- ============================================================
-- SECTION 9: VENDOR CONTRIBUTION %
-- ============================================================

WITH vendor_totals AS (
    SELECT
        vendor,
        SUM(amount) AS total_invoice_value
    FROM invoices
    GROUP BY vendor
)
SELECT
    vendor,
    total_invoice_value,
    ROUND(
        total_invoice_value * 100.0 /
        (SELECT SUM(amount) FROM invoices),
        2
    ) AS percentage_of_total
FROM vendor_totals
ORDER BY total_invoice_value DESC;


-- Vendors with invoice value above ₹40,000
WITH vendor_totals AS (
    SELECT
        vendor,
        SUM(amount) AS total_invoice_value
    FROM invoices
    GROUP BY vendor
)
SELECT
    vendor,
    total_invoice_value
FROM vendor_totals
WHERE total_invoice_value > 40000
ORDER BY total_invoice_value DESC;


-- ============================================================
-- SECTION 10: CASE WHEN - INVOICE VALUE CLASSIFICATION
-- ============================================================

SELECT
    invoice_id,
    vendor,
    amount,
    CASE
        WHEN amount > 20000 THEN 'High Value'
        ELSE 'Normal Value'
    END AS invoice_value_category
FROM invoices
ORDER BY amount DESC;


-- ============================================================
-- SECTION 11: HIGH-VALUE INVOICES
-- ============================================================

SELECT
    invoice_id,
    vendor,
    amount,
    status
FROM invoices
WHERE amount > (
    SELECT AVG(amount)
    FROM invoices
)
ORDER BY amount DESC;


-- ============================================================
-- SECTION 12: MONTHLY INVOICE ANALYSIS
-- ============================================================

SELECT
    strftime('%Y-%m', invoice_date) AS invoice_month,
    COUNT(*) AS invoice_count,
    SUM(amount) AS total_invoice_value
FROM invoices
GROUP BY invoice_month
ORDER BY invoice_month;


-- ============================================================
-- SECTION 13: PAYMENT DURATION ANALYSIS
-- ============================================================

-- Number of days between invoice date and payment date
SELECT
    invoice_id,
    vendor,
    amount,
    julianday(payment_date) -
    julianday(invoice_date) AS payment_days
FROM invoices
WHERE payment_date IS NOT NULL
ORDER BY payment_days;


-- Average payment duration
SELECT
    ROUND(
        AVG(
            julianday(payment_date) -
            julianday(invoice_date)
        ),
        2
    ) AS average_payment_days
FROM invoices
WHERE payment_date IS NOT NULL;


-- ============================================================
-- SECTION 14: PAYMENT DELAY VS DUE DATE
-- ============================================================

SELECT
    invoice_id,
    vendor,
    amount,
    julianday(payment_date) -
    julianday(due_date) AS payment_delay_days
FROM invoices
WHERE payment_date IS NOT NULL
ORDER BY payment_delay_days;


-- ============================================================
-- SECTION 15: JOIN - INVOICE + VENDOR INFORMATION
-- ============================================================

SELECT
    invoices.invoice_id,
    invoices.vendor,
    vendors.vendor_category,
    invoices.amount
FROM invoices
JOIN vendors
    ON invoices.vendor = vendors.vendor_name;


-- ============================================================
-- SECTION 16: INVOICE VALUE BY VENDOR CATEGORY
-- ============================================================

SELECT
    vendors.vendor_category,
    SUM(invoices.amount) AS total_invoice_value
FROM invoices
JOIN vendors
    ON invoices.vendor = vendors.vendor_name
GROUP BY vendors.vendor_category
ORDER BY total_invoice_value DESC;


-- ============================================================
-- SECTION 17: LEFT JOIN - ALL VENDORS
-- ============================================================

SELECT
    vendors.vendor_name,
    invoices.invoice_id,
    invoices.amount
FROM vendors
LEFT JOIN invoices
    ON vendors.vendor_name = invoices.vendor;


-- ============================================================
-- SECTION 18: VENDOR TOTAL USING LEFT JOIN + COALESCE
-- ============================================================

SELECT
    vendors.vendor_name,
    COALESCE(
        SUM(invoices.amount),
        0
    ) AS total_invoice_value
FROM vendors
LEFT JOIN invoices
    ON vendors.vendor_name = invoices.vendor
GROUP BY vendors.vendor_name
ORDER BY total_invoice_value DESC;


-- ============================================================
-- SECTION 19: CTE - VENDOR TOTALS
-- ============================================================

WITH vendor_totals AS (
    SELECT
        vendor,
        SUM(amount) AS total_invoice_value
    FROM invoices
    GROUP BY vendor
)
SELECT *
FROM vendor_totals
ORDER BY total_invoice_value DESC;


-- ============================================================
-- SECTION 20: WINDOW FUNCTION - VENDOR RANKING
-- ============================================================

SELECT
    vendor,
    SUM(amount) AS total_invoice_value,
    RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS vendor_rank
FROM invoices
GROUP BY vendor
ORDER BY vendor_rank;


-- ============================================================
-- SECTION 21: RANK INDIVIDUAL INVOICES
-- ============================================================

SELECT
    invoice_id,
    vendor,
    amount,
    RANK() OVER (
        ORDER BY amount DESC
    ) AS invoice_rank
FROM invoices
ORDER BY invoice_rank;


-- ============================================================
-- SECTION 22: RANK INVOICES WITHIN EACH VENDOR
-- ============================================================

SELECT
    invoice_id,
    vendor,
    amount,
    RANK() OVER (
        PARTITION BY vendor
        ORDER BY amount DESC
    ) AS vendor_invoice_rank
FROM invoices
ORDER BY vendor, vendor_invoice_rank;


-- ============================================================
-- SECTION 23: HIGHEST-VALUE INVOICE FOR EACH VENDOR
-- ============================================================

WITH ranked_invoices AS (
    SELECT
        invoice_id,
        vendor,
        amount,
        RANK() OVER (
            PARTITION BY vendor
            ORDER BY amount DESC
        ) AS vendor_invoice_rank
    FROM invoices
)
SELECT
    invoice_id,
    vendor,
    amount
FROM ranked_invoices
WHERE vendor_invoice_rank = 1
ORDER BY amount DESC;


-- ============================================================
-- SECTION 24: ROW_NUMBER()
-- ============================================================

SELECT
    invoice_id,
    vendor,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY vendor
        ORDER BY amount DESC
    ) AS invoice_number
FROM invoices
ORDER BY vendor, invoice_number;


-- ============================================================
-- SECTION 25: TOP 2 INVOICES FOR EACH VENDOR
-- ============================================================

WITH ranked_invoices AS (
    SELECT
        invoice_id,
        vendor,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY vendor
            ORDER BY amount DESC
        ) AS invoice_number
    FROM invoices
)
SELECT
    invoice_id,
    vendor,
    amount
FROM ranked_invoices
WHERE invoice_number <= 2
ORDER BY vendor, invoice_number;


-- ============================================================
-- SECTION 26: OVERDUE EXPOSURE BY VENDOR
-- ============================================================

SELECT
    vendor,
    COUNT(*) AS overdue_invoices,
    SUM(amount) AS overdue_amount
FROM invoices
WHERE status = 'Overdue'
GROUP BY vendor
ORDER BY overdue_amount DESC;


-- ============================================================
-- SECTION 27: OVERDUE PERCENTAGE BY VENDOR
-- ============================================================

WITH vendor_summary AS (
    SELECT
        vendor,
        SUM(amount) AS total_invoice_value,
        SUM(
            CASE
                WHEN status = 'Overdue' THEN amount
                ELSE 0
            END
        ) AS overdue_amount
    FROM invoices
    GROUP BY vendor
)
SELECT
    vendor,
    total_invoice_value,
    overdue_amount,
    ROUND(
        overdue_amount * 100.0 /
        total_invoice_value,
        2
    ) AS overdue_percentage
FROM vendor_summary
ORDER BY overdue_percentage DESC;


-- ============================================================
-- SECTION 28: VENDOR + PAYMENT STATUS ANALYSIS
-- ============================================================

SELECT
    vendor,

    SUM(
        CASE
            WHEN status = 'Paid' THEN amount
            ELSE 0
        END
    ) AS paid_amount,

    SUM(
        CASE
            WHEN status = 'Pending' THEN amount
            ELSE 0
        END
    ) AS pending_amount,

    SUM(
        CASE
            WHEN status = 'Overdue' THEN amount
            ELSE 0
        END
    ) AS overdue_amount

FROM invoices
GROUP BY vendor
ORDER BY vendor;


-- ============================================================
-- SECTION 29: FINAL PROJECT KPI SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_invoices,
    SUM(amount) AS total_invoice_value,
    ROUND(AVG(amount), 2) AS average_invoice_value,
    MAX(amount) AS highest_invoice,
    MIN(amount) AS lowest_invoice
FROM invoices;


-- ============================================================
-- END OF PROJECT
-- ============================================================
