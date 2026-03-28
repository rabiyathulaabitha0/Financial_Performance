CREATE DATABASE FinancialDashboard;
USE FinancialDashboard;
-- Check total rows
SELECT COUNT(*) AS Total_Rows 
FROM Financial_Performance;
-- Preview first 5 rows
SELECT TOP 5 * 
FROM Financial_Performance;
-- Problem 1 — Revenue & Budget Analysis
-- Total Revenue by Business Unit
SELECT 
    Business_Unit,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Budget_Revenue), 2) AS Total_Budget,
    ROUND(SUM(Budget_Variance), 2) AS Total_Variance,
    ROUND((SUM(Revenue) - SUM(Budget_Revenue)) / 
           SUM(Budget_Revenue) * 100, 2) AS Variance_Pct
FROM Financial_Performance
GROUP BY Business_Unit
ORDER BY Total_Revenue DESC;

-- Revenue by Region & Year
SELECT 
    Region,
    Year,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Total_Net_Profit
FROM Financial_Performance
GROUP BY Region, Year
ORDER BY Year, Total_Revenue DESC;

-- Top 5 Performing Countries
SELECT TOP 5
    Country,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Net_Profit
FROM Financial_Performance
GROUP BY Country
ORDER BY Total_Revenue DESC;

-- Quarterly Revenue Trend
SELECT 
    Year,
    Quarter,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Budget_Revenue), 2) AS Budget,
    ROUND(SUM(Revenue) - SUM(Budget_Revenue), 2) AS Variance
FROM Financial_Performance
GROUP BY Year, Quarter
ORDER BY Year, Quarter;

-- Problem 2 — NPA & Bad Loan Analysis
-- Overall NPA Rate
SELECT 
    NPA_Flag,
    COUNT(*) AS Total_Count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS NPA_Rate_Pct,
    ROUND(SUM(Loan_Amount), 2) AS Total_Loan_Amount,
    ROUND(SUM(Write_Off_Amount), 2) AS Total_Write_Off
FROM Financial_Performance
GROUP BY NPA_Flag;

-- NPA by Product Category
SELECT 
    Product_Category,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN NPA_Flag = 1 THEN 1 ELSE 0 END) AS NPA_Count,
    ROUND(SUM(CASE WHEN NPA_Flag = 1 THEN 1 ELSE 0 END) 
          * 100.0 / COUNT(*), 2) AS NPA_Rate_Pct,
    ROUND(SUM(Write_Off_Amount), 2) AS Total_Write_Off
FROM Financial_Performance
GROUP BY Product_Category
ORDER BY NPA_Rate_Pct DESC;

-- NPA by Region
SELECT 
    Region,
    Country,
    SUM(CASE WHEN NPA_Flag = 1 THEN 1 ELSE 0 END) AS NPA_Count,
    ROUND(SUM(Write_Off_Amount), 2) AS Total_Write_Off,
    ROUND(AVG(TRY_CAST(Interest_Rate AS FLOAT)), 2) AS Avg_Interest_Rate
FROM Financial_Performance
GROUP BY Region, Country
ORDER BY Total_Write_Off DESC;

-- Top 10 Highest Write Off Transactions
SELECT TOP 10
    Transaction_ID,
    Business_Unit,
    Product_Name,
    Loan_Amount,
    Interest_Rate,
    Write_Off_Amount,
    Credit_Rating,
    Risk_Score
FROM Financial_Performance
WHERE NPA_Flag = 1
ORDER BY Write_Off_Amount DESC;


--Problem 3 — Risk Analysis

-- Risk by Credit Rating
SELECT 
    Credit_Rating,
    COUNT(*) AS Total_Transactions,
    ROUND(AVG(Risk_Score), 2) AS Avg_Risk_Score,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Write_Off_Amount), 2) AS Total_Write_Off
FROM Financial_Performance
GROUP BY Credit_Rating
ORDER BY Avg_Risk_Score DESC;

-- High Risk Transactions (Risk Score > 7)
SELECT 
    Business_Unit,
    Product_Category,
    COUNT(*) AS High_Risk_Count,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Risk_Score), 2) AS Avg_Risk_Score
FROM Financial_Performance
WHERE Risk_Score > 7
GROUP BY Business_Unit, Product_Category
ORDER BY High_Risk_Count DESC;

-- Risk by Department
SELECT 
    Department,
    COUNT(*) AS Total_Transactions,
    ROUND(AVG(Risk_Score), 2) AS Avg_Risk_Score,
    SUM(CASE WHEN NPA_Flag = 1 THEN 1 ELSE 0 END) AS NPA_Count,
    ROUND(SUM(Write_Off_Amount), 2) AS Total_Write_Off
FROM Financial_Performance
GROUP BY Department
ORDER BY Avg_Risk_Score DESC;

--Problem 4 — Profitability Analysis

-- Profitability by Product Category
SELECT 
    Product_Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(SUM(Net_Profit), 2) AS Net_Profit,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS Gross_Margin_Pct,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Margin_Pct
FROM Financial_Performance
GROUP BY Product_Category
ORDER BY Net_Profit DESC;


-- Profitability by Customer Segment
SELECT 
    Customer_Segment,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Total_Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Margin_Pct
FROM Financial_Performance
GROUP BY Customer_Segment
ORDER BY Total_Net_Profit DESC;

-- Best Performing Sales Channel
SELECT 
    Sales_Channel,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Net_Profit,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Margin_Pct,
    COUNT(*) AS Total_Transactions
FROM Financial_Performance
GROUP BY Sales_Channel
ORDER BY Net_Profit DESC;


-- Year over Year Revenue & Profit
SELECT 
    Year,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Net_Profit,
    ROUND(SUM(EBITDA), 2) AS Total_EBITDA,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS Gross_Margin_Pct
FROM Financial_Performance
GROUP BY Year
ORDER BY Year;

--Problem 5 — Executive KPI Summary

-- Master KPI Summary
SELECT
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Total_Net_Profit,
    ROUND(SUM(EBITDA), 2) AS Total_EBITDA,
    ROUND(SUM(Gross_Profit), 2) AS Total_Gross_Profit,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS Gross_Margin_Pct,
    ROUND(SUM(Net_Profit) / SUM(Revenue) * 100, 2) AS Net_Margin_Pct,
    ROUND(SUM(Write_Off_Amount), 2) AS Total_Write_Off,
    SUM(CASE WHEN NPA_Flag = 1 THEN 1 ELSE 0 END) AS Total_NPA_Count
FROM Financial_Performance

-- Currency wise Revenue
SELECT 
    Currency,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Net_Profit), 2) AS Net_Profit
FROM Financial_Performance
GROUP BY Currency
ORDER BY Total_Revenue DESC;

-- Multi Year KPI Trend
SELECT 
    Year,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Net_Profit), 2) AS Net_Profit,
    ROUND(SUM(Write_Off_Amount), 2) AS Write_Offs,
    SUM(CASE WHEN NPA_Flag = 1 THEN 1 ELSE 0 END) AS NPA_Count,
    ROUND(AVG(Risk_Score), 2) AS Avg_Risk_Score
FROM Financial_Performance
GROUP BY Year
ORDER BY Year;

