CREATE DATABASE online_retail;
use online_retail;
CREATE TABLE retail_sales(
   Invoice VARCHAR(20),
   StockCode VARCHAR(20),
   Description TEXT,
   Quantity INT,
   InvoiceDate DATETIME,
   Price DECIMAL(10,2),
   CustomerID INT,
   Country VARCHAR(100),
   Sales DECIMAL(10,2),
   year INT,
   MONTH INT,
   MonthName VARCHAR(20)
);

   
SELECT COUNT(*) FROM retail_sales;
  
  -- Total Sales
SELECT ROUND(SUM(Quantity * Price), 2) AS Total_Sales
FROM retail_sales;  

 -- Total Orders
 SELECT COUNT(DISTINCT Invoice) AS TotalOrders
 FROM retail_sales;
 
 -- Total Customer
 SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
 FROM Retail_sales;

-- Top 10 Products
SELECT Description,
	   SUM(Quantity) AS Quantity_Sold
FROM retail_sales
GROUP BY Description
Order BY Quantity_Sold Desc
LIMIT 10;  

-- Top 10 Countries
SELECT Country,
       ROUND (SUM(Quantity * Price),2) AS Total_Sales
FROM retail_sales
GROUP BY Country
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top 10 Customers
SELECT `Customer ID`,
       ROUND(SUM(Quantity * Price),2) AS Total_Spent
FROM retail_sales
GROUP BY `Customer ID`
ORDER BY Total_Spent DESC
LIMIT 10;

-- Total  sales
SELECT ROUND(SUM(Quantity * Price),2) AS Total_Sales
FROM retail_sales;      

-- Top 10 Customers
SELECT 'CustomerID',
       ROUND(SUM(Quantity *Price),2) AS Total_Spent
FROM retail_sales
GROUP BY 'CustomerID'
ORDER BY Total_Spent DESC
LIMIT 10;       


-- Customer By Country
SELECT Country,
       COUNT(DISTINCT CustomerID) AS Customers
FROM retail_sales
GROUP BY Country
ORDER BY Customers DESC;

-- Cancelled Orders
SELECT COUNT(*) AS Cancelled_Orders
FROM retail_sales
Where Invoice LIKE  'C%';

SELECT InvoiceDate
FROM retail_sales
LIMIT 5;

ALTER TABLE retail_sales
MODIFY COLUMN InvoiceDate DATETIME;

DESCRIBE retail_sales;

-- Total Revenue
SELECT ROUND(SUM(Quantity *Price),2)AS Total_Revenue
FROM retail_sales;

-- Total Order
SELECT COUNT(DISTINCT Invoice) AS Total_Orders
FROM retail_sales;

-- Monthly Revenue Trend
SELECT 
      YEAR(InvoiceDate) AS Year,
      MONTH(InvoiceDate) AS Month,
      ROUND(SUM(Quantity *Price), 2) AS Revenue
FROM retail_sales
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Year, MOnth;      

-- Top 10 Countries
SELECT
      Country,
      ROUND(SUM(Quantity *Price),2) AS Revenue
FROM retail_sales
GROUP BY Country
ORDER BY Revenue DESC   
LIMIT 10;   

-- Top 10 Products
SELECT 
     Description,
     SUM(Quantity) AS Quantity_Sold
FROM retail_sales
GROUP BY Description
ORDER By Quantity_Sold DESC 
LIMIT 10;    

-- Top 10 Customers
SELECT 
     'Customer ID',
     ROUND(SUM(Quantity *Price),2) AS Revenue
FROM Retail_sales
WHERE 'Customer ID' IS NOT NULL
GROUP BY 'CUSTOMER ID'
ORDER BY Revenue DESC
LIMIT 10;
     
-- Cancelled Orders
SELECT COUNT(*) AS Cancelled_Orders
FROM retail_sales
WHERE Invoice LIKE 'C%';

-- Customer -wise Revenue
SELECT 
     'Customer ID',
     COUNT(DISTINCT Invoice) AS Total_Orders,
     SUM(Quantity) AS Total_Items,
     ROUND (SUM(Quantity * Price),2) AS Total_Revenue
FROM retail_sales
WHERE 'Customer ID' IS NOT NULL
GROUP BY 'Customer ID'
ORDER BY Total_Revenue DESC
LIMIT 20;     

-- Best Selling Products
SELECT
    StockCode,
    Description,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Quantity * Price),2) AS Revenue
FROM retail_sales
GROUP BY StockCode, Description
ORDER BY Revenue DESC
LIMIT 20;

-- Monthly Sales Trend
SELECT
      DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
      ROUND (SUM(Quantity *Price),2) As Revenue
FROM retail_sales
GROUP BY Month
ORDER BY Month;
      
-- Top Countries
SELECT 
      Country,
      COUNT(DISTINCT Invoice) AS Orders,
      ROUND(SUM(Quantity *Price),2) AS Revenue
FROM retail_sales
GROUP BY Country
ORDER BY Revenue DESC;      

-- Create a Sales View
CREATE VIEW sales_summary AS
SELECT
     Invoice,
     'Customer ID',
     Country,
     Quantity,
     Price,
     Quantity*Price As Sales,
     InvoiceDate
FROM retail_sales;   

-- test
SELECT*FROM sales_summary
LIMIT 10;  

-- Top 10 customer rank
SELECT
      'Customer ID',
      ROUND(SUM(Quantity*Price),2) AS Revenue,
      DENSE_RANK() OVER(
            ORDER BY SUM(Quantity*Price) DESC
      ) AS Customer_Rank
FROM retail_sales
WHERE 'Customer ID' IS NOT NULL
GROUP BY 'Customer ID'
LIMIT 10;
