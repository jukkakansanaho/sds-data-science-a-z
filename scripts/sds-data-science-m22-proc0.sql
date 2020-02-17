-- This PROC script creates a Stored Procedure for MSSQL to be executed afterwards.
USE DSTRAINING
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- To generate a PROD, use 'CREATE'
-- CREATE PROC [dbo].[BLD_WRK_OfficeSupplies_CustomerList]
-- NOTE: To edit PROC, use 'ALTER' instead of 'CREATE'
ALTER PROC [dbo].[BLD_WRK_OfficeSupplies_CustomerList]
-- ==========================
-- Author: Jukka Kansanaho
-- Create date: 20200213
-- Description: RAW -> WRK
-- MOD DATE:
-- ==========================

AS BEGIN

  SELECT *
  FROM [RAW_OfficeSupplies_CustomerList_20200212]

END
GO
