-- SDS Data Science A-Z: Bulk import flat CSV file
--
-- Create a new database called 'DSTRAINING'
-- Connect to the 'master' database to run this snippet
USE DSTRAINING
GO

-- Drop old tables if exists
DROP TABLE IF EXISTS [dbo].[RAW_BankCustomersDemo_20191120_Staging]
DROP TABLE IF EXISTS [dbo].[RAW_BankCustomersDemo_20191120]
GO

-- Create Staging table for BULK INSERT
CREATE TABLE dbo.RAW_BankCustomersDemo_20191120_Staging
(
    CustomerID  [VARCHAR](1000) NOT NULL,
    Name        [VARCHAR](1000) NOT NULL,
    Surname     [VARCHAR](1000) NOT NULL,
    Gender      [VARCHAR](1000) NOT NULL,
    Age         [VARCHAR](1000) NOT NULL,
    DateJoined  [VARCHAR](1000) NOT NULL,
    Balance     [VARCHAR](1000) NOT NULL
);
GO

-- Create the table for final data
CREATE TABLE dbo.RAW_BankCustomersDemo_20191120
(
    RowNumber   [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
    CustomerID  [VARCHAR](1000) NOT NULL,
    Name        [VARCHAR](1000) NOT NULL,
    Surname     [VARCHAR](1000) NOT NULL,
    Gender      [VARCHAR](1000) NOT NULL,
    Age         [VARCHAR](1000) NOT NULL,
    DateJoined  [VARCHAR](1000) NOT NULL,
    Balance     [VARCHAR](1000) NOT NULL
);
GO

-- Insert rows into table 'RAW_BankCustomersDemo_20191120'
BULK INSERT dbo.RAW_BankCustomersDemo_20191120_Staging
   --([CustomerID],[Name],[Surname], [Gender], [Age], [DateJoined], [Balance])
FROM '/tmp/PART3-S2-Bank-Customers-Demo.csv'
WITH (
    DATAFILETYPE    = 'char',
    FIRSTROW        = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR   = '\n',   --Use to shift the control to next row
    TABLOCK
)
GO
-- ........
INSERT INTO dbo.RAW_BankCustomersDemo_20191120
    SELECT CustomerID, Name, Surname, Gender, Age, DateJoined, Balance
    FROM dbo.RAW_BankCustomersDemo_20191120_Staging

-- Query the total count of employees
SELECT COUNT(*) as 'RowCount'
FROM RAW_BankCustomersDemo_20191120;
GO

-- Query all employee information
SELECT *
FROM RAW_BankCustomersDemo_20191120
GO

