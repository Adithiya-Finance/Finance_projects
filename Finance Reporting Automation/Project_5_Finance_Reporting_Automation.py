"""
Project 5 — Finance Reporting Automation
Portfolio simulation.

Run:
    python Project_5_Finance_Reporting_Automation.py

The script demonstrates:
1. Load transaction data
2. Validate data quality
3. Clean data
4. Calculate finance KPIs
5. Generate an Excel management report

This is a learning project using synthetic data.
"""

import pandas as pd
import numpy as np
from pathlib import Path

AS_OF_DATE = pd.Timestamp("2026-12-31")

def load_data(path: str) -> pd.DataFrame:
    df = pd.read_csv(path)
    df["Date"] = pd.to_datetime(df["Date"], errors="coerce")
    return df

def validate_data(df: pd.DataFrame) -> dict:
    return {
        "records": len(df),
        "duplicate_transaction_ids": df["Transaction_ID"].duplicated().sum(),
        "missing_vendor": df["Vendor"].isna().sum(),
        "invalid_amount": (df["Amount"] <= 0).sum(),
        "missing_department": df["Department"].isna().sum(),
    }

def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["Amount"] = pd.to_numeric(df["Amount"], errors="coerce")
    df = df[df["Amount"].notna()]
    df = df[df["Amount"] > 0]
    df["Month"] = df["Date"].dt.to_period("M").astype(str)
    return df

def build_monthly_analysis(df: pd.DataFrame) -> pd.DataFrame:
    result = (
        df.groupby("Month", as_index=False)
          .agg(Actual=("Amount","sum"),
               Transaction_Count=("Transaction_ID","count"))
    )
    # In a real implementation, Budget would come from the approved budget source.
    result["Budget"] = result["Actual"] * 1.02
    result["Variance"] = result["Actual"] - result["Budget"]
    result["Variance_%"] = np.where(
        result["Budget"] != 0,
        result["Variance"] / result["Budget"],
        0
    )
    return result

def build_department_analysis(df: pd.DataFrame) -> pd.DataFrame:
    result = (
        df.groupby("Department", as_index=False)
          .agg(Actual=("Amount","sum"),
               Transaction_Count=("Transaction_ID","count"))
    )
    return result.sort_values("Actual", ascending=False)

def generate_report(df, quality, output_path):
    monthly = build_monthly_analysis(df)
    department = build_department_analysis(df)

    with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
        df.to_excel(writer, sheet_name="Clean_Data", index=False)
        pd.DataFrame([quality]).to_excel(writer, sheet_name="Data_Quality", index=False)
        monthly.to_excel(writer, sheet_name="Monthly_Analysis", index=False)
        department.to_excel(writer, sheet_name="Department_Analysis", index=False)

def main():
    # Replace with your real input path when practicing.
    input_file = "raw_transactions.csv"
    output_file = "Monthly_Finance_Report.xlsx"

    df = load_data(input_file)
    quality = validate_data(df)
    df = clean_data(df)
    generate_report(df, quality, output_file)

    print("Finance report generated:", output_file)

if __name__ == "__main__":
    main()
