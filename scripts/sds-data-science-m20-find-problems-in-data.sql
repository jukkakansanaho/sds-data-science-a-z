USE DSTRAINING
GO

TRUNCATE TABLE [DSTRAINING].[dbo].[RAW_FakeNames_20191126_Errors]

SELECT COUNT(*) as 'TotalRowCount'
FROM RAW_FakeNames_20191126;
GO
-----
SELECT *
FROM dbo.RAW_FakeNames_20191126
WHERE Longitude NOT LIKE '%.%'
    --OR [Column 46] NOT LIKE '';
GO

SELECT COUNT(*) as 'DataErrorRowCount'
FROM RAW_FakeNames_20191126
WHERE Longitude NOT LIKE '%.%';
GO

-- Move Error data to a separate table
INSERT INTO RAW_FakeNames_20191126_Errors
  SELECT *
  FROM dbo.RAW_FakeNames_20191126
  WHERE Longitude NOT LIKE '%.%'
      --OR [Column 46] NOT LIKE '';
GO

SELECT *
FROM dbo.RAW_FakeNames_20191126_Errors
WHERE Longitude NOT LIKE '%.%'
    --OR [Column 46] NOT LIKE '';
GO

SELECT COUNT(*) as 'MovedDataErrorRowCount'
FROM RAW_FakeNames_20191126_Errors
WHERE Longitude NOT LIKE '%.%';
GO

DELETE
FROM dbo.RAW_FakeNames_20191126
WHERE Longitude NOT LIKE '%.%'
    --OR [Column 46] NOT LIKE '';
GO

SELECT COUNT(*) as 'DataErrorRowCount'
FROM RAW_FakeNames_20191126
WHERE Longitude NOT LIKE '%.%';
GO

SELECT COUNT(*) as 'CleanDataRowCount'
FROM RAW_FakeNames_20191126
GO
---
-- Move Insufficient Data to a separate table
INSERT INTO RAW_FakeNames_20191126_InsufficientData
  SELECT *
  FROM dbo.RAW_FakeNames_20191126
  WHERE AmountPaid IS NULL OR ZipCode IS NULL
GO

DELETE
FROM dbo.RAW_FakeNames_20191126
  WHERE AmountPaid IS NULL OR ZipCode IS NULL
GO
---

SELECT COUNT(*) AS 'InsufficientData'
FROM dbo.RAW_FakeNames_20191126_InsufficientData
GO

SELECT * 
FROM dbo.RAW_FakeNames_20191126_InsufficientData
GO

SELECT COUNT(*) AS 'CleanDataRowCount'
FROM RAW_FakeNames_20191126
GO
