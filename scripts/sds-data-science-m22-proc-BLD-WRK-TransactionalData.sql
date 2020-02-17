-- This PROC script creates a Stored Procedure for MSSQL to be executed afterwards.
USE DSTRAINING
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- To generate a PROD, use 'CREATE'
--CREATE PROC [dbo].[BLD_WRK_OfficeSupplies_TransactionalData_20200212]
-- NOTE: To edit PROC, use 'ALTER' instead of 'CREATE'
ALTER PROC [dbo].[BLD_WRK_OfficeSupplies_TransactionalData_20200212]
-- ==========================
-- Author: Jukka Kansanaho
-- Create date: 20200214
-- Description: RAW -> WRK
-- MOD DATE:
-- ==========================

AS BEGIN

-- ==========================
-- DROP TABLE
-- ==========================
IF OBJECT_ID('WRK_OfficeSupplies_TransactionalData_20200212') IS NOT NULL
  DROP TABLE [WRK_OfficeSupplies_TransactionalData_20200212]

-- ==========================
-- CREATE TABLE
-- ==========================
CREATE TABLE [WRK_OfficeSupplies_TransactionalData_20200212]
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
)

-- ==========================
-- TRUNCATE TABLE
-- ==========================
TRUNCATE TABLE [WRK_OfficeSupplies_TransactionalData_20200212]

-- ==========================
-- INSERT INTO TABLE
-- ==========================
INSERT INTO [WRK_OfficeSupplies_TransactionalData_20200212]
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
    [OrderDate],
    [CustomerID],
    [Region],
    [Rep],
    [Item],
    [Units],
    [UnitPrice]
  FROM dbo.RAW_OfficeSupplies_TransactionalData_20200212

END
GO
