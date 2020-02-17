-- SDS Data Science A-Z: Bulk import flat CSV file
--
-- Create a new database called 'DSTRAINING'
-- Connect to the 'master' database to run this snippet
USE DSTRAINING
GO

-- Drop old tables if exists
DROP TABLE IF EXISTS [dbo].[RAW_OfficeSupplies_CustomerList_20200212_Staging]
DROP TABLE IF EXISTS [dbo].[RAW_OfficeSupplies_CustomerList_20200212]
DROP TABLE IF EXISTS [dbo].[WRK_OfficeSupplies_CustomerList_20200212]

DROP TABLE IF EXISTS [dbo].[RAW_OfficeSupplies_TransactionalData_20200212_Staging]
DROP TABLE IF EXISTS [dbo].[RAW_OfficeSupplies_TransactionalData_20200212]
DROP TABLE IF EXISTS [dbo].[WRK_OfficeSupplies_TransactionalData_20200212]
GO

-- Create Staging table for BULK INSERT
CREATE TABLE dbo.RAW_OfficeSupplies_CustomerList_20200212_Staging
(
  CustomerID          [VARCHAR](1000) NULL,
  City                [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](1000) NULL,
  Gender              [VARCHAR](1000) NULL,
  --Age                 [VARCHAR](1000) NULL
  Age                 [FLOAT] NULL
);
GO

CREATE TABLE dbo.RAW_OfficeSupplies_CustomerList_20200212
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  CustomerID          [VARCHAR](1000) NULL,
  City                [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](1000) NULL,
  Gender              [VARCHAR](1000) NULL,
  Age                 [FLOAT] NULL
);
GO

CREATE TABLE dbo.WRK_OfficeSupplies_CustomerList_20200212
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  CustomerID          [VARCHAR](100) NULL,
  City                [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](5) NULL,
  Gender              [VARCHAR](1) NULL,
  Age                 [FLOAT] NULL
);
GO

-- Create Staging table for BULK INSERT
CREATE TABLE dbo.RAW_OfficeSupplies_TransactionalData_20200212_Staging
(
  OrderID             [VARCHAR](1000) NULL,
  OrderDate           [VARCHAR](1000) NULL,
  CustomerID          [VARCHAR](1000) NULL,
  Region              [VARCHAR](1000) NULL,
  Rep                 [VARCHAR](1000) NULL,
  Item                [VARCHAR](1000) NULL,
  Units               [VARCHAR](1000) NULL,
  UnitPrice           [FLOAT] NULL
);
GO

CREATE TABLE dbo.RAW_OfficeSupplies_TransactionalData_20200212
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  OrderID             [VARCHAR](1000) NULL,
  OrderDate           [VARCHAR](1000) NULL,
  CustomerID          [VARCHAR](1000) NULL,
  Region              [VARCHAR](1000) NULL,
  Rep                 [VARCHAR](1000) NULL,
  Item                [VARCHAR](1000) NULL,
  Units               [VARCHAR](1000) NULL,
  UnitPrice           [FLOAT] NULL
);
GO

CREATE TABLE dbo.WRK_OfficeSupplies_TransactionalData_20200212
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  OrderID             [VARCHAR](100) NULL,
  OrderDate           [DATE] NULL,
  CustomerID          [VARCHAR](100) NULL,
  Region              [VARCHAR](1) NULL,
  Rep                 [VARCHAR](100) NULL,
  Item                [VARCHAR](1000) NULL,
  Units               [INTEGER] NULL,
  UnitPrice           [FLOAT] NULL
);
GO

-- Insert rows into table 'RAW_CustomerList_20200212_Staging'
BULK INSERT dbo.RAW_OfficeSupplies_CustomerList_20200212_Staging
FROM '/tmp/PART3-S6-CustomerList-re.csv'
WITH (
    DATAFILETYPE    = 'char',
    FIRSTROW        = 2,
    FIELDQUOTE      = '"',  --CSV
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR   = '0x0A', --Use to shift the control to next row

    TABLOCK
)
GO

INSERT INTO dbo.RAW_OfficeSupplies_CustomerList_20200212
  (
    CustomerID,
    City,
    ZipCode,
    Gender,
    Age
  )
  SELECT
    CustomerID,
    City,
    ZipCode,
    Gender,
    Age
  FROM dbo.RAW_OfficeSupplies_CustomerList_20200212_Staging

INSERT INTO dbo.WRK_OfficeSupplies_CustomerList_20200212
  (
    [CustomerID],
    [City],
    [ZipCode],
    [Gender],
    [Age]
  )
  SELECT
    RIGHT('0000000' + [CustomerID], 7), -- Add leading zeros + cut CustomerID down to 7 chars.
    [City],
    [ZipCode],
    [Gender],
    [Age]
  FROM dbo.RAW_OfficeSupplies_CustomerList_20200212
-- NOTE: See MSSQL Data converions (CONVERT + CAST):
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15

-- Query the total count of rows
SELECT COUNT(*) as 'RowCount'
FROM RAW_OfficeSupplies_CustomerList_20200212;
GO

-- Query all info + limit first 50
SELECT *
FROM RAW_OfficeSupplies_CustomerList_20200212
WHERE RowNumber BETWEEN 1 AND 50;
GO
---
-- Query the total count of rows
SELECT COUNT(*) as 'RowCount'
FROM WRK_OfficeSupplies_CustomerList_20200212;
GO

-- Query all info + limit first 50
SELECT *
FROM WRK_OfficeSupplies_CustomerList_20200212
WHERE RowNumber BETWEEN 1 AND 50;
GO

-- Insert rows into table 'RAW_TransactionalData_20200212_Staging'
BULK INSERT dbo.RAW_OfficeSupplies_TransactionalData_20200212_Staging
FROM '/tmp/PART3-S6-TransactionalData.csv'
WITH (
    DATAFILETYPE    = 'char',
    FIRSTROW        = 2,
    FIELDQUOTE      = '"',  --CSV
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR   = '0x0A', --Use to shift the control to next row

    TABLOCK
)
GO

INSERT INTO dbo.RAW_OfficeSupplies_TransactionalData_20200212
  (
    OrderID,
    OrderDate,
    CustomerID,
    Region,
    Rep,
    Item,
    Units,
    UnitPrice
  )
  SELECT
    OrderID,
    OrderDate,
    CustomerID,
    Region,
    Rep,
    Item,
    Units,
    UnitPrice
  FROM dbo.RAW_OfficeSupplies_TransactionalData_20200212_Staging

INSERT INTO dbo.WRK_OfficeSupplies_TransactionalData_20200212
  (
    [OrderID],
    [OrderDate],
    [CustomerID],
    [Region],
    [Rep],
    [Item],
    [Units],
    [UnitPrice]
  )
  SELECT
    RIGHT('0000000' + [CustomerID], 7), -- Add leading zeros + cut CustomerID down to 7 chars.
    CONVERT(DATE, [OrderDate], 23),
    [CustomerID],
    [Region],
    [Rep],
    [Item],
    [Units],
    [UnitPrice]
  FROM dbo.RAW_OfficeSupplies_TransactionalData_20200212

-- Query the total count of rows
SELECT COUNT(*) as 'RowCount'
FROM RAW_OfficeSupplies_TransactionalData_20200212;
GO

-- Query all info + limit first 50
SELECT *
FROM RAW_OfficeSupplies_TransactionalData_20200212
WHERE RowNumber BETWEEN 1 AND 50;
GO

SELECT COUNT(*) as 'RowCount'
FROM WRK_OfficeSupplies_TransactionalData_20200212;
GO

-- Query all info + limit first 50
SELECT *
FROM WRK_OfficeSupplies_TransactionalData_20200212
WHERE RowNumber BETWEEN 1 AND 50;
GO
