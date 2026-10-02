# Project 4 — AP & Working Capital Analytics

## Objective
Analyze Accounts Payable, invoice aging, payment performance, vendor concentration and working-capital implications.

## Tools
- Excel
- SQL
- Power BI (dashboard-ready dataset)

## Dataset
1,000 synthetic AP invoices generated for portfolio practice. The dataset is **not actual employer/client data**.

## Analytical flow
Raw AP transactions → calculated metrics → aging → vendor analysis → department analysis → working capital → dashboard → insights.

## Key KPIs
- Total AP
- Outstanding AP
- Overdue AP
- Overdue %
- Average Payment Days
- Discount Opportunity
- Illustrative DPO

## Important methodology note
The DPO calculation in the workbook is an illustrative proxy. In a real company model, use the organization's defined methodology and actual average AP plus COGS/purchases data.

## Interview positioning
> Built an AP and working-capital analytics model using Excel and SQL to analyze invoice aging, overdue balances, vendor concentration, payment timing and early-payment discount opportunities. Built a management dashboard and translated operational AP metrics into working-capital insights.

## Files
- `Project_4_AP_Working_Capital_Analytics.xlsx`
- `Project_4_AP_Working_Capital_Analytics.sql`

## Reverse engineering
Start with `Reverse_Engineering` in the workbook and trace:
Raw_Data → Calculated_Fields → Aging_Analysis → Vendor_Analysis → Working_Capital → Dashboard → Insights.
