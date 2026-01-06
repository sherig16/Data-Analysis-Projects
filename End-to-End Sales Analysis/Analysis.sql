-- Combine country-level datasets into a unified table
CREATE TABLE public."Sales_Data" AS
SELECT * FROM public."Sales_Canada"
UNION ALL SELECT * FROM public."Sales_China"
UNION ALL SELECT * FROM public."Sales_India"
UNION ALL SELECT * FROM public."Sales_Nigeria"
UNION ALL SELECT * FROM public."Sales_UK"
UNION ALL SELECT * FROM public."Sales_US";

-- Data Quality Checks: Identify critical null values
SELECT *
FROM public."Sales_Data"
WHERE "Country" IS NULL
   OR "Price_Per_Unit" IS NULL
   OR "Quantity_purchased" IS NULL
   OR "Cost_price" IS NULL
   OR "Discount_applied" IS NULL;

-- Handle Null values (documented assumptions):
-- Quantity: one known missing value set to 3 for a specific Transaction_ID (single-record correction)
-- Price: one missing value filled using the overall average Price_Per_Unit (simple imputation)

UPDATE public."Sales_Data"
SET "Quantity_purchased" = 3 
WHERE "Transaction_ID" = '00a30472-89a0-4688-9d33-67ea8ccf7aea';

UPDATE public."Sales_Data"
SET "Price_Per_Unit" = (
    SELECT AVG("Price_Per_Unit")
    FROM public."Sales_Data"
    WHERE "Price_Per_Unit" IS NOT NULL
)
WHERE "Transaction_ID" = '001898f7-b696-4356-91dc-8f2b73d09c63';

-- Duplicate check on transaction IDs
SELECT "Transaction_ID", COUNT(*)
FROM public."Sales_Data"
GROUP BY "Transaction_ID"
HAVING COUNT(*) > 1;

-- Create Key Performance Indicator Metrics:

-- Create total_amount_spent column
ALTER TABLE public."Sales_Data"
ADD COLUMN "Total_amount_spent" NUMERIC(10,2);

UPDATE public."Sales_Data"
SET "Total_amount_spent" =
    ("Price_Per_Unit" * "Quantity_purchased") - "Discount_applied";

-- Create Profit column
ALTER TABLE public."Sales_Data"
ADD COLUMN "Profit" NUMERIC(10,2);

UPDATE public."Sales_Data"
SET "Profit" =
    "Total_amount_spent" - ("Cost_price" * "Quantity_purchased");


-- Business Analysis Queries (December 1–25, 2025):

-- Revenue and profit by country
SELECT "Country",
       SUM("Total_amount_spent") AS "Revenue",
       SUM("Profit") AS "Profit"
FROM public."Sales_Data"
WHERE "Date" BETWEEN '2025-12-01' AND '2025-12-25'
GROUP BY "Country"
ORDER BY "Revenue" DESC;

-- Top 5 products by units sold
SELECT "Product_name",
       SUM("Quantity_purchased") AS "Total_sold"
FROM public."Sales_Data"
WHERE "Date" BETWEEN '2025-12-01' AND '2025-12-25'
GROUP BY "Product_name"
ORDER BY "Total_sold" DESC
LIMIT 5;

-- Top 5 sales representatives by revenue
SELECT "Sales_rep",
       SUM("Total_amount_spent") AS "Total_sales"
FROM public."Sales_Data"
WHERE "Date" BETWEEN '2025-12-01' AND '2025-12-25'
GROUP BY "Sales_rep"
ORDER BY "Total_sales" DESC
LIMIT 5;

-- Top store locations by revenue and profit
SELECT "Store_location",
       SUM("Total_amount_spent") AS "Revenue",
       SUM("Profit") AS "Total_Profit"
FROM public."Sales_Data"
WHERE "Date" BETWEEN '2025-12-01' AND '2025-12-25'
GROUP BY "Store_location"
ORDER BY "Revenue" DESC
LIMIT 5;

-- Summary statistics for revenue and profit (Dec 1–25)
SELECT
    MIN("Total_amount_spent") AS "Min_revenue",
    MAX("Total_amount_spent") AS "Max_revenue",
    AVG("Total_amount_spent") AS "Average_revenue",
    SUM("Total_amount_spent") AS "Total_revenue",
    MIN("Profit") AS "Min_profit",
    MAX("Profit") AS "Max_profit",
    AVG("Profit") AS "Average_profit",
    SUM("Profit") AS "Total_profit"
FROM public."Sales_Data"
WHERE "Date" BETWEEN '2025-12-01' AND '2025-12-25';
