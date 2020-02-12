-- Use DSTRAINING DB
USE DSTRAINING
GO

-- Query-1
SELECT COUNT(*) as 'RowCount'
FROM [RAW_ListOfOrders_20200128];
GO

SELECT  OrderID,
        OrderDate,
        CustomerName,
        Country
FROM [RAW_ListOfOrders_20200128]
WHERE [RowNumber] BETWEEN 1 AND 50;
GO

-- Query-2
SELECT COUNT(*) as 'RowCount'
FROM [RAW_OrderBreakdown_20200128];
GO

SELECT *
FROM [RAW_OrderBreakdown_20200128]
WHERE [RowNumber] BETWEEN 1 AND 50;
GO

-- Query-3
SELECT *
FROM [dbo].[RAW_OrderBreakdown_20200128]
WHERE [Category] = 'Furniture';


SELECT *
FROM [dbo].[RAW_OrderBreakdown_20200128]
WHERE
  (
    [Category] = 'Furniture' AND
    Convert(FLOAT, [Sales]) > 100
  )
  OR
  [Category] = 'Technology'


-- Query-4
SELECT *
FROM [dbo].[RAW_ListOfOrders_20200128]
--WHERE [Country] = 'Sweden'
WHERE [CustomerName] = 'Eugene Moren'

-- Query-5: Using wildcard % and _
-- OrderID starts with 'ES'
SELECT *
FROM [dbo].[RAW_ListOfOrders_20200128]
WHERE [OrderID] LIKE 'ES%'

-- Country has letter 'E'
SELECT *
FROM [dbo].[RAW_ListOfOrders_20200128]
WHERE [Country] LIKE '%E%'

-- 2nd letter in name == 'e'
SELECT *
FROM [dbo].[RAW_ListOfOrders_20200128]
WHERE [CustomerName] LIKE '_e%'

-- Query-6: Commenting in SQL
/*
This is
a multiline comment
*/

-- This is a single-line comment

-- Query-7: Ordering
SELECT *
FROM [dbo].[RAW_OrderBreakdown_20200128]
ORDER BY [ProductName]
--WHERE [RowNumber] BETWEEN 1 AND 20;

SELECT *
FROM [dbo].[RAW_OrderBreakdown_20200128]
ORDER BY CAST([Sales] as FLOAT) DESC
--WHERE [RowNumber] BETWEEN 1 AND 20;

-- Query-8: Using Cast() and Convert()
SELECT  [OrderID],
        [ProductName],
        [Discount],
        [Sales],
        [Quantity],
        [Category]
FROM [dbo].[RAW_OrderBreakdown_20200128]
ORDER BY CAST([Sales] as FLOAT) -- Use when working with other than DATEs.
--ORDER BY CONVERT(FLOAT, [Sales]) -- Use when working with DATEs.

-- Query-8: Handling NULLs
-- Preparing data to have some NULLs to work with (984 rows)
/*UPDATE [dbo].[RAW_OrderBreakdown_20200128]
SET [Discount] = NULL
WHERE [Discount] = 0.5
*/
SELECT  [OrderID],
        [ProductName],
        [Discount],
        [Sales],
        [Quantity],
        [Category]
FROM [dbo].[RAW_OrderBreakdown_20200128]
WHERE [Discount] IS NULL -- NOTE: With NULL, you need to use 'IS' or 'IS NOT' instead of '='
ORDER BY CAST([Sales] as FLOAT)

-- Query-9: Joins
SELECT *
FROM [RAW_ListOfOrders_20200128] as LoO
LEFT JOIN [RAW_OrderBreakdown_20200128] as OB
  ON LoO.[OrderID] = OB.[OrderID]
