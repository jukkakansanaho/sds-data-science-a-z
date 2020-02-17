-- This PROC script creates a Stored Procedure for MSSQL to be executed afterwards.
USE DSTRAINING
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- To generate a PROD, use 'CREATE'
CREATE PROC [dbo].[BLD_DRV_OfficeSupplies_RevenueByCustomerGender_20200217]
-- NOTE: To edit PROC, use 'ALTER' instead of 'CREATE'
-- CREATE PROC [dbo].[BLD_DRV_OfficeSupplies_RevenueByCustomerGender_20200212]
-- ==========================
-- Author:
-- Create date: 20200217
-- Description: WRK -> DRV
--              COMBINING TABLES: [WRK_OfficeSupplies_CustomerList_20200212]
--                                [WRK_OfficeSupplies_TransactionalData_20200212]
--              TO UNDERSTAND REVENUE SPLIT BY GENDER
-- MOD DATE:
-- ==========================

AS BEGIN

-- ==========================
-- DROP TABLE
-- ==========================
IF OBJECT_ID('DRV_OfficeSupplies_RevenueByCustomerGender_20200217') IS NOT NULL
  DROP TABLE [DRV_OfficeSupplies_RevenueByCustomerGender_20200217]

-- ==========================
-- CREATE TABLE
-- ==========================
CREATE TABLE [DRV_OfficeSupplies_RevenueByCustomerGender_20200217]
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  CustomerID          [VARCHAR](100) NULL,
  Gender              [VARCHAR](1) NULL,
  Revenue             [FLOAT] NULL
)

-- ==========================
-- TRUNCATE TABLE
-- ==========================
TRUNCATE TABLE [DRV_OfficeSupplies_RevenueByCustomerGender_20200217]

-- ==========================
-- INSERT INTO TABLE
-- ==========================
INSERT INTO [DRV_OfficeSupplies_RevenueByCustomerGender_20200217]
  (
    CustomerID,
    Gender,
    Revenue
  )
  SELECT
    CL.[CustomerID],
    CL.[Gender],
    TD.[Units] * TD.[UnitPrice] AS Revenue
  FROM [dbo].[WRK_OfficeSupplies_CustomerList_20200212] as CL
    LEFT JOIN [dbo].[WRK_OfficeSupplies_TransactionalData_20200212] as TD
    ON CL.[CustomerID] = TD.[CustomerID]

END
GO
