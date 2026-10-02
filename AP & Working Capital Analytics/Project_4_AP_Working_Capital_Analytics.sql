-- Project 4: AP & Working Capital Analytics
-- Dialect: MySQL 8+ compatible
-- Table assumed: ap_invoices
-- Columns:
-- invoice_id, invoice_date, vendor, department, category, invoice_amount,
-- payment_terms_days, due_date, payment_date, payment_status,
-- discount_available, discount_pct, grn_status, approval_status

-- 1. Total AP activity
SELECT
    COUNT(*) AS invoice_count,
    SUM(invoice_amount) AS total_invoice_value
FROM ap_invoices;

-- 2. Outstanding AP
SELECT
    SUM(CASE WHEN payment_status <> 'Paid' THEN invoice_amount ELSE 0 END) AS outstanding_ap
FROM ap_invoices;

-- 3. Overdue AP as of 2026-12-31
SELECT
    SUM(
        CASE
            WHEN payment_status <> 'Paid'
             AND due_date < '2026-12-31'
            THEN invoice_amount ELSE 0
        END
    ) AS overdue_ap
FROM ap_invoices;

-- 4. Vendor-level outstanding AP
SELECT
    vendor,
    COUNT(*) AS invoice_count,
    SUM(invoice_amount) AS total_invoice_value,
    SUM(CASE WHEN payment_status <> 'Paid' THEN invoice_amount ELSE 0 END) AS outstanding_ap
FROM ap_invoices
GROUP BY vendor
ORDER BY outstanding_ap DESC;

-- 5. Vendor-level overdue AP
SELECT
    vendor,
    COUNT(*) AS overdue_invoices,
    SUM(invoice_amount) AS overdue_amount
FROM ap_invoices
WHERE payment_status <> 'Paid'
  AND due_date < '2026-12-31'
GROUP BY vendor
ORDER BY overdue_amount DESC;

-- 6. Department analysis
SELECT
    department,
    COUNT(*) AS invoice_count,
    SUM(invoice_amount) AS total_invoice_value,
    SUM(CASE WHEN payment_status <> 'Paid' THEN invoice_amount ELSE 0 END) AS outstanding_ap,
    SUM(
        CASE
            WHEN payment_status <> 'Paid'
             AND due_date < '2026-12-31'
            THEN invoice_amount ELSE 0
        END
    ) AS overdue_ap
FROM ap_invoices
GROUP BY department
ORDER BY overdue_ap DESC;

-- 7. Aging analysis
SELECT
    CASE
        WHEN payment_status = 'Paid' THEN
            CASE
                WHEN payment_date <= due_date THEN 'Current'
                WHEN DATEDIFF(payment_date,due_date) <= 30 THEN '1-30 Days'
                WHEN DATEDIFF(payment_date,due_date) <= 60 THEN '31-60 Days'
                WHEN DATEDIFF(payment_date,due_date) <= 90 THEN '61-90 Days'
                ELSE '90+ Days'
            END
        ELSE
            CASE
                WHEN due_date >= '2026-12-31' THEN 'Current'
                WHEN DATEDIFF('2026-12-31',due_date) <= 30 THEN '1-30 Days'
                WHEN DATEDIFF('2026-12-31',due_date) <= 60 THEN '31-60 Days'
                WHEN DATEDIFF('2026-12-31',due_date) <= 90 THEN '61-90 Days'
                ELSE '90+ Days'
            END
    END AS aging_bucket,
    COUNT(*) AS invoice_count,
    SUM(CASE WHEN payment_status <> 'Paid' THEN invoice_amount ELSE 0 END) AS outstanding_ap
FROM ap_invoices
GROUP BY aging_bucket
ORDER BY FIELD(aging_bucket,'Current','1-30 Days','31-60 Days','61-90 Days','90+ Days');

-- 8. Average payment days for paid invoices
SELECT
    AVG(DATEDIFF(payment_date,invoice_date)) AS average_payment_days
FROM ap_invoices
WHERE payment_status = 'Paid';

-- 9. Early-payment discount opportunity
SELECT
    SUM(
        CASE
            WHEN discount_available = 'Yes'
            THEN invoice_amount * discount_pct
            ELSE 0
        END
    ) AS discount_opportunity
FROM ap_invoices;

-- 10. Approval / GRN bottlenecks
SELECT
    approval_status,
    grn_status,
    COUNT(*) AS invoice_count,
    SUM(invoice_amount) AS invoice_value
FROM ap_invoices
GROUP BY approval_status, grn_status
ORDER BY invoice_value DESC;

-- 11. High-value overdue invoices
SELECT
    invoice_id,
    vendor,
    department,
    invoice_amount,
    due_date,
    DATEDIFF('2026-12-31',due_date) AS days_past_due
FROM ap_invoices
WHERE payment_status <> 'Paid'
  AND due_date < '2026-12-31'
ORDER BY invoice_amount DESC
LIMIT 20;
