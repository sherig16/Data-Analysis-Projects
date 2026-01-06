# End-to-End Sales Analysis with SQL and POWER BI

## 🎯 Project Objective
Build an end-to-end sales analytics workflow that integrates multi-country sales data, performs data cleaning and KPI engineering in SQL, and delivers interactive business insights through Power BI.

## 📊 Business Questions Answered
Using SQL aggregation queries, the project answers key business questions, including:
- Revenue and profit by country (December 1–25)
- Top 5 products by units sold
- Top-performing sales representatives
- Store locations generating the highest revenue and profit
- Summary sales and profit statistics for the selected period

## 🔍 Analysis Approach

Key data preparation steps performed in PostgreSQL:
- Combining country-level datasets into a unified table
- Identifying and handling null values in critical fields
- Imputing missing quantities using a documented assumption and filling missing unit prices using the dataset average
- Creating derived transaction-level metrics for revenue and profit

An interactive Power BI dashboard was built to visualize key sales and profit insights, featuring:
- Executive KPI cards (Sales, Profit, Orders, Discounts, AOV)
- Monthly sales trends
- Geographic performance by country and city
- Category and payment method breakdowns
- Discount vs profit analysis
  
## 🛠️ Tools Used
- Excel (loading and investigating the data initially)
- PostgreSQL (data loading, cleaning, transformation, aggregation, ETL logic, business queries)
- Power BI (dashboarding and visualization)

<img width="582" height="319" alt="Screenshot 2026-01-06 000707" src="https://github.com/user-attachments/assets/32e4c218-05bf-4a79-ab66-77de4e87d2da" />


## 💡 Key Insights
- Monthly sales show clear seasonality, with a noticeable increase toward year-end, suggesting higher demand during the holiday period and supporting time-based planning and inventory decisions.
- Monthly sales show clear seasonality, with a noticeable increase toward year-end, suggesting higher demand during the holiday period and supporting time-based planning and inventory decisions.
- Discounting does not uniformly increase profitability — higher discount levels are associated with mixed profit outcomes across countries, indicating the need for more targeted discount strategies.
