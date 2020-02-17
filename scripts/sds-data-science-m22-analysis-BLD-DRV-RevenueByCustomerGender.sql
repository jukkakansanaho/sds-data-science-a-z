-- Create an analysis table

USE DSTRAINING
GO
-- =====================
-- Drop old tables if exists
DROP TABLE IF EXISTS [dbo].[DRV_OfficeSupplies_RevenueByCustomerGender_20200217]
GO
-- =====================
-- Create table for analysis
CREATE TABLE dbo.DRV_OfficeSupplies_RevenueByCustomerGender_20200217
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  CustomerID          [VARCHAR](100) NULL,
  Gender              [VARCHAR](1) NULL,
  Revenue             [FLOAT] NULL
);
GO
-- =====================
/*
-- Test query
SELECT *
FROM [dbo].[WRK_OfficeSupplies_CustomerList_20200212] as CL
LEFT JOIN [dbo].[WRK_OfficeSupplies_TransactionalData_20200212] as TD
  ON CL.[CustomerID] = TD.[CustomerID]
GO
*/
-- =====================
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

GO

SELECT COUNT(*)
FROM [DRV_OfficeSupplies_RevenueByCustomerGender_20200217]

SELECT *
FROM [DRV_OfficeSupplies_RevenueByCustomerGender_20200217]
