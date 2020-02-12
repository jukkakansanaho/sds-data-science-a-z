-- SDS Data Science A-Z: Bulk import flat CSV file
--
-- Create a new database called 'DSTRAINING'
-- Connect to the 'master' database to run this snippet
USE DSTRAINING
GO

-- Drop old tables if exists
DROP TABLE IF EXISTS [dbo].[RAW_ListOfOrders_20200128_Staging]
DROP TABLE IF EXISTS [dbo].[RAW_ListOfOrders_20200128]
DROP TABLE IF EXISTS [dbo].[RAW_OrderBreakdown_20200128_Staging]
DROP TABLE IF EXISTS [dbo].[RAW_OrderBreakdown_20200128]
GO

-- Create Staging table for BULK INSERT
CREATE TABLE dbo.RAW_ListOfOrders_20200128_Staging
(
  OrderID             [VARCHAR](1000) NULL,
  OrderDate           [VARCHAR](1000) NULL,
  CustomerName        [VARCHAR](1000) NULL,
  Country             [VARCHAR](1000) NULL
);
GO

CREATE TABLE dbo.RAW_ListOfOrders_20200128
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  OrderID             [VARCHAR](1000) NULL,
  OrderDate           [VARCHAR](1000) NULL,
  CustomerName        [VARCHAR](1000) NULL,
  Country             [VARCHAR](1000) NULL
);
GO

-- Create Staging table for BULK INSERT
CREATE TABLE dbo.RAW_OrderBreakdown_20200128_Staging
(
  OrderID             [VARCHAR](1000) NULL,
  ProductName         [VARCHAR](1000) NULL,
  Discount            [VARCHAR](1000) NULL,
  Sales               [VARCHAR](1000) NULL,
  Quantity            [VARCHAR](1000) NULL,
  Category            [VARCHAR](1000) NULL,
);
GO

CREATE TABLE dbo.RAW_OrderBreakdown_20200128
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  OrderID             [VARCHAR](1000) NULL,
  ProductName         [VARCHAR](1000) NULL,
  Discount            [VARCHAR](1000) NULL,
  Sales               [VARCHAR](1000) NULL,
  Quantity            [VARCHAR](1000) NULL,
  Category            [VARCHAR](1000) NULL,
);
GO

-- Insert rows into table 'RAW_ListOfOrders_20200128_Staging'
BULK INSERT dbo.RAW_ListOfOrders_20200128_Staging
FROM '/tmp/PART3-S5-ListOfOrders.csv'
WITH (
    DATAFILETYPE    = 'char',
    FIRSTROW        = 2,
    FIELDQUOTE      = '"',  --CSV
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR   = '0x0A', --Use to shift the control to next row
    --ROWTERMINATOR   = '\n', --Use to shift the control to next row

    TABLOCK
)
GO

INSERT INTO dbo.RAW_ListOfOrders_20200128
    SELECT  OrderID,
            OrderDate,
            CustomerName,
            Country
    FROM dbo.RAW_ListOfOrders_20200128_Staging

-- Query the total count of rows
SELECT COUNT(*) as 'RowCount'
FROM RAW_ListOfOrders_20200128;
GO

-- Query all info + limit first 50
SELECT *
FROM RAW_ListOfOrders_20200128
WHERE RowNumber BETWEEN 1 AND 50;
GO

-- Insert rows into table 'RAW_OrderBreakdown_20200128_Staging'
BULK INSERT dbo.RAW_OrderBreakdown_20200128_Staging
FROM '/tmp/PART3-S5-OrderBreakdown-re.csv'
WITH (
    DATAFILETYPE    = 'char',
    FIRSTROW        = 2,
    FIELDQUOTE      = '"',  --CSV
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR   = '0x0A', --Use to shift the control to next row
    --ROWTERMINATOR   = '\n', --Use to shift the control to next row

    TABLOCK
);
GO

INSERT INTO dbo.RAW_OrderBreakdown_20200128
    SELECT  OrderID,
            ProductName,
            Discount,
            Sales,
            Quantity,
            Category
    FROM dbo.RAW_OrderBreakdown_20200128_Staging

-- Query the total count of rows
SELECT COUNT(*) as 'RowCount'
FROM dbo.RAW_OrderBreakdown_20200128;
GO

-- Query all info + limit first 50
SELECT *
FROM dbo.RAW_OrderBreakdown_20200128
WHERE RowNumber BETWEEN 1 AND 50;
GO
