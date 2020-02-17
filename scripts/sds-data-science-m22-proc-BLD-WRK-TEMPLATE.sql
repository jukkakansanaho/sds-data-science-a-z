-- This PROC script creates a Stored Procedure for MSSQL to be executed afterwards.
USE DSTRAINING
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- To generate a PROD, use 'CREATE'
CREATE PROC [dbo].[__tmpl__BLD_WRK_TableName_YYYYMMDD]
-- NOTE: To edit PROC, use 'ALTER' instead of 'CREATE'
-- ALTER PROC [dbo].[__tmpl__BLD_WRK_TableName_YYYYMMDD]
-- ==========================
-- Author:
-- Create date: YYYYMMDD
-- Description: RAW -> WRK
-- MOD DATE:
-- ==========================

AS BEGIN

-- ==========================
-- DROP TABLE
-- ==========================
IF OBJECT_ID('WRK_TableName_YYYYMMDD') IS NOT NULL
  DROP TABLE [WRK_TableName_YYYYMMDD]

-- ==========================
-- CREATE TABLE
-- ==========================
CREATE TABLE [WRK_TableName_YYYYMMDD]
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  [AAA]               [VARCHAR](100) NULL,
  [BBB]               [VARCHAR](1000) NULL,
  [DDD]               [DATE] NULL,
  [EEE]               [INTEGER] NULL,
  [FFF]               [FLOAT] NULL
)

-- ==========================
-- TRUNCATE TABLE
-- ==========================
TRUNCATE TABLE [WRK_TableName_YYYYMMDD]

-- ==========================
-- INSERT INTO TABLE
-- ==========================
INSERT INTO [WRK_TableName_YYYYMMDD]
  (
    [AAA],
    [BBB],
    [DDD],
    [EEE],
    [FFF]
  )
  SELECT
    RIGHT('0000000' + [xAAA], 7), -- Add leading zeros + cut CustomerID down to 7 chars.
    [xBBB],
    CONVERT(DATE, [xDDD], 23),
    [xEEE],
    CAST([xFFF] AS FLOAT)
  FROM dbo.RAW_TableName_YYYYMMDD

END
GO
