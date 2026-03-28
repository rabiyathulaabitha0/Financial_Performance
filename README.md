#  Axis Bank — Financial Performance Intelligence Dashboard

> **An end-to-end BFSI analytics project analyzing revenue, NPA, risk, and profitability across 7 business units and 19 countries using Excel, SQL, Python, and Power BI.**

---

##  Overview

This project analyzes the financial performance of **Axis Bank** for **FY 2020–2024** using a dataset of **10,000+ transactions** across **7 business units** and **19 countries**. It covers the complete data analytics pipeline — from raw data in Excel to an interactive Power BI dashboard — simulating a real-world MNC analyst workflow in the **BFSI (Banking, Financial Services & Insurance)** domain.

---

##  Problem Statement?

Banks generate massive volumes of financial data across business units, regions, and products. Without structured analysis, it becomes difficult to:

- Identify underperforming business units and budget gaps
- Monitor NPA (Non-Performing Asset) exposure and write-off risks
- Track profitability trends across customer segments
- Make data-driven decisions at the executive level

This project builds a **Financial Performance Intelligence System** that answers these questions through SQL queries, Python EDA, and an interactive Power BI dashboard.

---

## 🗂️ Dataset

| Field | Details |
|-------|---------|
| File | Financial_Performance.csv |
| Rows | 10,000 transactions |
| Columns | 35 fields |
| Domain | Banking & Financial Services (BFSI) |
| Period | FY 2020 – 2024 |
| Business Units | 7 (Asset Management, Corporate Banking, Insurance, Investment Banking, Retail Banking, Trade Finance, Treasury) |
| Countries | 19 |
| Key Columns | Revenue, Budget_Revenue, Net_Profit, EBITDA, NPA_Flag, Loan_Amount, Write_Off_Amount, Risk_Score, Credit_Rating, Net_Margin_% |

---

## 🛠️ Tools and Technologies

| Tool | Purpose |
|------|---------|
| **Microsoft Excel** | Data exploration, cleaning, pivot tables, formulas |
| **SQL Server (SSMS)** | Structured querying across 5 business problem areas |
| **Python (Jupyter Notebook)** | EDA, visualizations — Pandas, Matplotlib, Seaborn, Pyodbc |
| **Power BI** | 3-page interactive dashboard with DAX measures and slicers |
| **DAX** | 12 custom measures for KPIs, NPA, variance, and profitability |

---

##  Methods

### Phase 1 — Excel
- Data exploration across 35 columns using AutoFilter and Conditional Formatting
- Removed duplicates, standardized NPA_Flag (Yes/No), formatted financial columns
- Created 5 pivot tables: Revenue by BU, Budget Variance, NPA by Region, Profitability, Year-wise KPI Trend
- Key formulas: `SUMIF`, `COUNTIF`, `AVERAGEIF`, Budget Variance %

### Phase 2 — SQL Server
- Created database `FinancialDashboard` on local server `RABIYA\SQLEXPRESS`
- Wrote 20+ queries across 5 problem statements:
  - **Problem 1:** Revenue & Budget Analysis
  - **Problem 2:** NPA & Bad Loan Analysis (Window Functions)
  - **Problem 3:** Risk Analysis by Credit Rating
  - **Problem 4:** Profitability by Product & Segment
  - **Problem 5:** Executive KPI Summary

### Phase 3 — Python EDA
- Connected to SQL Server via `pyodbc` with Trusted Connection
- Cleaned data: converted numeric columns, handled nulls with `fillna()`
- Created 6 visualizations: Revenue Bar, Trend Line, NPA Pie, Margin Bar, Grouped Revenue vs Profit, Risk Score Histogram

### Phase 4 — Power BI Dashboard
- Built 3-page dashboard using Axis Bank brand colors (`#97144D`, `#F8D7E3`)
- Created 12 DAX measures including NPA Rate %, Budget Variance %, Net Margin %
- Added slicers: Year, Region, Business Unit, Credit Rating, NPA Flag
- Enabled Map visual, cross-filtering, and page navigation buttons

---

##  Key Insights

### Revenue & Budget
- Total Revenue **$50.21bn** vs Budget **$50.26bn** — only **-0.09% variance**, near-perfect budget adherence
- **Asset Management** is the top business unit with **$7.48bn** revenue
- **UAE leads** country-wise with $3.5bn, followed by Mexico and USA at $3.4bn each
- **Q3 is the strongest quarter** with $13.18bn revenue across all years

### NPA & Risk
- NPA Rate is **7.73%** — 773 out of 10,000 transactions are non-performing
- Total Write-Off is **$140M** — entirely from the Loans product category
- **Asia Pacific and Europe** have the highest NPA counts (158–159 each)
- **BB-rated** transactions carry the highest average risk score

### Profitability
- Net Margin averages **31.5%** consistently across all business units
- Total Net Profit **$15.87bn** and EBITDA **$21.15bn** over FY 2020–2024
- **Revenue growth of 399.40%** recorded across the 5-year period

---

##  Dashboard / Output

### Power BI Dashboard Pages

| Page | Key Visuals |
|------|-------------|
| **1. Overview** | KPI Cards, Revenue by BU, Net Profit by Segment, Revenue Trend Line |
| **2. Revenue Analysis** | Revenue vs Budget Bar, Quarterly Trend, Matrix Year × BU |
| **3. NPA & Risk Analysis** | NPA Pie, Write-Off Bar, NPA by Region, Top 10 Risk Table |

### DAX Measures Used
```dax
Total Revenue     = SUM('Transaction_Data'[Revenue])
NPA Rate %        = DIVIDE([NPA Count], COUNTROWS('Transaction_Data'), 0)
Budget Variance % = DIVIDE([Total Revenue] - [Budget Revenue], [Budget Revenue], 0)
Avg Risk Score    = AVERAGE('Transaction_Data'[Risk_Score])
Net Margin %      = AVERAGE('Transaction_Data'[Net_Margin_%])
```

---

##  How to Run This Project

### Excel
1. Open `Financial_Performance.csv` in Microsoft Excel
2. Apply filters and explore pivot tables in `Excel_Analysis.xlsx`

### SQL
1. Open **SQL Server Management Studio (SSMS)**
2. Connect to server: `RABIYA\SQLEXPRESS`
3. Create database: `FinancialDashboard`
4. Import CSV using **Import Data Wizard**
5. Run queries from `Financial_Queries.sql`

### Python
1. Install libraries: `pip install pandas matplotlib seaborn pyodbc`
2. Open `Financial_EDA.ipynb` in Jupyter Notebook
3. Update server name in connection string if needed
4. Run all cells

### Power BI
1. Open `Financial_Performance.pbix` in Power BI Desktop
2. Refresh data source if prompted
3. Navigate through pages using the buttons on Page 1

---

##  Results & Conclusion

This project successfully demonstrates:
- Near-perfect budget adherence with only **-0.09% revenue variance**
- Clear identification of NPA risk zones — **7.73% NPA rate**, concentrated in Asia Pacific and Europe
- Strong profitability with consistent **31.5% net margin** across all business units
- A **399.40% revenue growth** over 5 years, indicating strong business expansion

The Power BI dashboard enables executives to slice data by year, region, and business unit — delivering actionable insights at a glance.

---

##  Future Work

- Integrate **real-time data** using Power BI Service + scheduled refresh
- Add **forecasting visuals** using Power BI's built-in analytics pane
- Build a **customer churn prediction model** using Python ML (Logistic Regression / Random Forest)
- Expand to include **FX/currency impact analysis** across 19 countries
- Publish the dashboard to **Power BI Service** for web access

---

## Author

**Rabiya**
Aspiring Data Analyst | BFSI Domain Specialist
📧 [Your Email] | 🔗 [Your LinkedIn] | 💻 [Your GitHub]

---

*Financial Performance Dashboard | Axis Bank BFSI | Excel • SQL • Python • Power BI | FY 2020–2024*
