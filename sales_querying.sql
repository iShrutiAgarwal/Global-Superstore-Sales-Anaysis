CREATE DATABASE sales_analytics;
USE sales_analytics;
show tables;

--- Creating the table
CREATE TABLE sales_data (
    Category VARCHAR(50),
    City VARCHAR(100),
    Country VARCHAR(100),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Discount DECIMAL(5,2),
    Market VARCHAR(10),
    ji_lu_shu INT,
    Order_ID VARCHAR(50),
    Order_Priority VARCHAR(10),
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(100),
    Profit DECIMAL(10,2),
    Quantity INT,
    Region VARCHAR(20),
    Row_ID INT,
    Sales INT,
    Segment VARCHAR(20),
    Ship_Mode VARCHAR(30),
    Shipping_Cost DECIMAL(10,2),
    State VARCHAR(60),
    Sub_Category VARCHAR(30),
    Year INT,
    Market2 VARCHAR(50),
    weeknum INT,
    Week_Date DATE
);

--- Importing cleaned dataset
LOAD DATA LOCAL INFILE "C:/Users/Shruti/projects/Summerix Internship projects/Sales Analytics/clean_sales_data.csv"
INTO TABLE sales_data
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Category, City, Country, Customer_ID, Customer_Name, Discount,
 Market, ji_lu_shu, Order_ID, Order_Priority, Product_ID,
 Product_Name, Profit, Quantity, Region, Row_ID, Sales, 
 Segment, Ship_Mode, Shipping_Cost, State, Sub_Category,
 Year, Market2, weeknum, @week_date_raw, @dummy)
SET Week_Date = STR_TO_DATE(@week_date_raw, '%d-%m-%Y');
SET GLOBAL local_infile = 1;
drop table sales_data;
ALTER TABLE sales_data MODIFY Product_Name VARCHAR(200);
TRUNCATE TABLE sales_data;

--- SQL Queries

--- 1. Total sales by region
SELECT 
      Region,
      SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Region;

--- 2. Top 5 profitable products
SELECT 
      Product_Name,
      SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 5;

--- 3. Monthly sales trend
SELECT
      MONTHNAME(Week_Date) AS Month,
      SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Month
ORDER BY Month;

--- 4. Highest discount impact
SELECT
      Discount,
      AVG(Profit)
FROM sales_data
GROUP BY Discount
ORDER BY Discount;