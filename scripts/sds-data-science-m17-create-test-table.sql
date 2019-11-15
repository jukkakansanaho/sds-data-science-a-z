-- SDS Data Science A-Z: Test MS SQL Server DB connection
--
-- Create a new database called 'DSTRAINING'
-- Connect to the 'master' database to run this snippet
USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'DSTRAINING'
)
CREATE DATABASE [DSTRAINING]
GO
-- Create a new table called 'TestTable' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.TestTable', 'U') IS NOT NULL
DROP TABLE dbo.TestTable
GO
-- Create the table in the specified schema
CREATE TABLE dbo.TestTable
(
    TestTableId INT NOT NULL PRIMARY KEY, -- primary key column
    Name [NVARCHAR](100) NOT NULL,
    Age [INT] NOT NULL
    -- specify more columns here
);
GO

-- Insert rows into table 'Employees'
INSERT INTO TestTable
   ([TestTableId],[Name],[Age])
VALUES
   ( 1, N'Matt', 35),
   ( 2, N'James', 45),
   ( 3, N'Helen', 26)
GO
-- Query the total count of employees
SELECT COUNT(*) as PersonCount FROM dbo.TestTable;
-- Query all employee information
SELECT e.TestTableId, e.Name, e.Age
FROM dbo.TestTable as e
GO