-- SDS Data Science A-Z: Bulk import flat CSV file
--
-- Create a new database called 'DSTRAINING'
-- Connect to the 'master' database to run this snippet
USE DSTRAINING
GO

-- Drop old tables if exists
DROP TABLE IF EXISTS [dbo].[RAW_FakeNames_20191126_Staging]
DROP TABLE IF EXISTS [dbo].[RAW_FakeNames_20191126_Errors]
DROP TABLE IF EXISTS [dbo].[RAW_FakeNames_20191126]
DROP TABLE IF EXISTS [dbo].[RAW_FakeNames_20191126_InsufficientData]
GO

-- Create Staging table for BULK INSERT
CREATE TABLE dbo.RAW_FakeNames_20191126_Staging
(
  Number              [VARCHAR](1000) NOT NULL,
  Gender              [VARCHAR](1000) NULL,
  NameSet             [VARCHAR](1000) NULL,
  Title               [VARCHAR](1000) NULL,
  GivenName           [VARCHAR](1000) NULL,
  MiddleInitial       [VARCHAR](1000) NULL,
  Surname             [VARCHAR](1000) NULL,
  AmountPaid          [VARCHAR](1000) NULL,
  StreetAddress       [VARCHAR](1000) NULL,
  City                [VARCHAR](1000) NULL,
  State               [VARCHAR](1000) NULL,
  StateFull           [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](1000) NULL,
  Country             [VARCHAR](1000) NULL,
  CountryFull         [VARCHAR](1000) NULL,
  Feedback            [VARCHAR](5000) NULL,
  EmailAddress        [VARCHAR](1000) NULL,
  Username            [VARCHAR](1000) NULL,
  Password            [VARCHAR](1000) NULL,
  BrowserUserAgent    [VARCHAR](1000) NULL,
  TelephoneNumber     [VARCHAR](1000) NULL,
  TelephoneCountryCode[VARCHAR](1000) NULL,
  MothersMaiden       [VARCHAR](1000) NULL,
  Birthday            [VARCHAR](1000) NULL,
  TropicalZodiac      [VARCHAR](1000) NULL,
  CCType              [VARCHAR](1000) NULL,
  CCNumber            [VARCHAR](1000) NULL,
  CVV2                [VARCHAR](1000) NULL,
  CCExpires           [VARCHAR](1000) NULL,
  NationalID          [VARCHAR](1000) NULL,
  UPS                 [VARCHAR](1000) NULL,
  WesternUnionMTCN    [VARCHAR](1000) NULL,
  MoneyGramMTCN       [VARCHAR](1000) NULL,
  Color               [VARCHAR](1000) NULL,
  Occupation          [VARCHAR](1000) NULL,
  Company             [VARCHAR](1000) NULL,
  Vehicle             [VARCHAR](1000) NULL,
  Domain              [VARCHAR](1000) NULL,
  BloodType           [VARCHAR](1000) NULL,
  Pounds              [VARCHAR](1000) NULL,
  Kilograms           [VARCHAR](1000) NULL,
  FeetInches          [VARCHAR](1000) NULL,
  Centimeters         [VARCHAR](1000) NULL,
  GUID                [VARCHAR](1000) NULL,
  Latitude            [VARCHAR](1000) NULL,
  Longitude           [VARCHAR](1000) NULL
);
GO

-- Create the table for final data
CREATE TABLE dbo.RAW_FakeNames_20191126
(
  RowNumber           [INTEGER] IDENTITY(1,1) NOT NULL, -- primary key column
  Number              [VARCHAR](1000) NOT NULL,
  Gender              [VARCHAR](1000) NULL,
  NameSet             [VARCHAR](1000) NULL,
  Title               [VARCHAR](1000) NULL,
  GivenName           [VARCHAR](1000) NULL,
  MiddleInitial       [VARCHAR](1000) NULL,
  Surname             [VARCHAR](1000) NULL,
  AmountPaid          [VARCHAR](1000) NULL,
  StreetAddress       [VARCHAR](1000) NULL,
  City                [VARCHAR](1000) NULL,
  State               [VARCHAR](1000) NULL,
  StateFull           [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](1000) NULL,
  Country             [VARCHAR](1000) NULL,
  CountryFull         [VARCHAR](1000) NULL,
  Feedback            [VARCHAR](5000) NULL,
  EmailAddress        [VARCHAR](1000) NULL,
  Username            [VARCHAR](1000) NULL,
  Password            [VARCHAR](1000) NULL,
  BrowserUserAgent    [VARCHAR](1000) NULL,
  TelephoneNumber     [VARCHAR](1000) NULL,
  TelephoneCountryCode[VARCHAR](1000) NULL,
  MothersMaiden       [VARCHAR](1000) NULL,
  Birthday            [VARCHAR](1000) NULL,
  TropicalZodiac      [VARCHAR](1000) NULL,
  CCType              [VARCHAR](1000) NULL,
  CCNumber            [VARCHAR](1000) NULL,
  CVV2                [VARCHAR](1000) NULL,
  CCExpires           [VARCHAR](1000) NULL,
  NationalID          [VARCHAR](1000) NULL,
  UPS                 [VARCHAR](1000) NULL,
  WesternUnionMTCN    [VARCHAR](1000) NULL,
  MoneyGramMTCN       [VARCHAR](1000) NULL,
  Color               [VARCHAR](1000) NULL,
  Occupation          [VARCHAR](1000) NULL,
  Company             [VARCHAR](1000) NULL,
  Vehicle             [VARCHAR](1000) NULL,
  Domain              [VARCHAR](1000) NULL,
  BloodType           [VARCHAR](1000) NULL,
  Pounds              [VARCHAR](1000) NULL,
  Kilograms           [VARCHAR](1000) NULL,
  FeetInches          [VARCHAR](1000) NULL,
  Centimeters         [VARCHAR](1000) NULL,
  GUID                [VARCHAR](1000) NULL,
  Latitude            [VARCHAR](1000) NULL,
  Longitude           [VARCHAR](1000) NULL
);
GO

-- Create the table for error data
CREATE TABLE dbo.RAW_FakeNames_20191126_Errors
(
  RowNumber           [INTEGER] NOT NULL, -- primary key column
  Number              [VARCHAR](1000) NOT NULL,
  Gender              [VARCHAR](1000) NULL,
  NameSet             [VARCHAR](1000) NULL,
  Title               [VARCHAR](1000) NULL,
  GivenName           [VARCHAR](1000) NULL,
  MiddleInitial       [VARCHAR](1000) NULL,
  Surname             [VARCHAR](1000) NULL,
  AmountPaid          [VARCHAR](1000) NULL,
  StreetAddress       [VARCHAR](1000) NULL,
  City                [VARCHAR](1000) NULL,
  State               [VARCHAR](1000) NULL,
  StateFull           [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](1000) NULL,
  Country             [VARCHAR](1000) NULL,
  CountryFull         [VARCHAR](1000) NULL,
  Feedback            [VARCHAR](5000) NULL,
  EmailAddress        [VARCHAR](1000) NULL,
  Username            [VARCHAR](1000) NULL,
  Password            [VARCHAR](1000) NULL,
  BrowserUserAgent    [VARCHAR](1000) NULL,
  TelephoneNumber     [VARCHAR](1000) NULL,
  TelephoneCountryCode[VARCHAR](1000) NULL,
  MothersMaiden       [VARCHAR](1000) NULL,
  Birthday            [VARCHAR](1000) NULL,
  TropicalZodiac      [VARCHAR](1000) NULL,
  CCType              [VARCHAR](1000) NULL,
  CCNumber            [VARCHAR](1000) NULL,
  CVV2                [VARCHAR](1000) NULL,
  CCExpires           [VARCHAR](1000) NULL,
  NationalID          [VARCHAR](1000) NULL,
  UPS                 [VARCHAR](1000) NULL,
  WesternUnionMTCN    [VARCHAR](1000) NULL,
  MoneyGramMTCN       [VARCHAR](1000) NULL,
  Color               [VARCHAR](1000) NULL,
  Occupation          [VARCHAR](1000) NULL,
  Company             [VARCHAR](1000) NULL,
  Vehicle             [VARCHAR](1000) NULL,
  Domain              [VARCHAR](1000) NULL,
  BloodType           [VARCHAR](1000) NULL,
  Pounds              [VARCHAR](1000) NULL,
  Kilograms           [VARCHAR](1000) NULL,
  FeetInches          [VARCHAR](1000) NULL,
  Centimeters         [VARCHAR](1000) NULL,
  GUID                [VARCHAR](1000) NULL,
  Latitude            [VARCHAR](1000) NULL,
  Longitude           [VARCHAR](1000) NULL
);
GO

-- Create the table for Insufficient Data
CREATE TABLE dbo.RAW_FakeNames_20191126_InsufficientData
(
  RowNumber           [INTEGER] NOT NULL, -- primary key column
  Number              [VARCHAR](1000) NOT NULL,
  Gender              [VARCHAR](1000) NULL,
  NameSet             [VARCHAR](1000) NULL,
  Title               [VARCHAR](1000) NULL,
  GivenName           [VARCHAR](1000) NULL,
  MiddleInitial       [VARCHAR](1000) NULL,
  Surname             [VARCHAR](1000) NULL,
  AmountPaid          [VARCHAR](1000) NULL,
  StreetAddress       [VARCHAR](1000) NULL,
  City                [VARCHAR](1000) NULL,
  State               [VARCHAR](1000) NULL,
  StateFull           [VARCHAR](1000) NULL,
  ZipCode             [VARCHAR](1000) NULL,
  Country             [VARCHAR](1000) NULL,
  CountryFull         [VARCHAR](1000) NULL,
  Feedback            [VARCHAR](5000) NULL,
  EmailAddress        [VARCHAR](1000) NULL,
  Username            [VARCHAR](1000) NULL,
  Password            [VARCHAR](1000) NULL,
  BrowserUserAgent    [VARCHAR](1000) NULL,
  TelephoneNumber     [VARCHAR](1000) NULL,
  TelephoneCountryCode[VARCHAR](1000) NULL,
  MothersMaiden       [VARCHAR](1000) NULL,
  Birthday            [VARCHAR](1000) NULL,
  TropicalZodiac      [VARCHAR](1000) NULL,
  CCType              [VARCHAR](1000) NULL,
  CCNumber            [VARCHAR](1000) NULL,
  CVV2                [VARCHAR](1000) NULL,
  CCExpires           [VARCHAR](1000) NULL,
  NationalID          [VARCHAR](1000) NULL,
  UPS                 [VARCHAR](1000) NULL,
  WesternUnionMTCN    [VARCHAR](1000) NULL,
  MoneyGramMTCN       [VARCHAR](1000) NULL,
  Color               [VARCHAR](1000) NULL,
  Occupation          [VARCHAR](1000) NULL,
  Company             [VARCHAR](1000) NULL,
  Vehicle             [VARCHAR](1000) NULL,
  Domain              [VARCHAR](1000) NULL,
  BloodType           [VARCHAR](1000) NULL,
  Pounds              [VARCHAR](1000) NULL,
  Kilograms           [VARCHAR](1000) NULL,
  FeetInches          [VARCHAR](1000) NULL,
  Centimeters         [VARCHAR](1000) NULL,
  GUID                [VARCHAR](1000) NULL,
  Latitude            [VARCHAR](1000) NULL,
  Longitude           [VARCHAR](1000) NULL
);
GO
-- Insert rows into table 'RAW_FakeNames_20191120_Staging'
BULK INSERT dbo.RAW_FakeNames_20191126_Staging
FROM '/tmp/FakeNames-ed_re_v2.csv'
WITH (
    DATAFILETYPE    = 'char',
    FIRSTROW        = 2,
    FIELDQUOTE      = '"',  --CSV
    FIELDTERMINATOR = ';',  --CSV field delimiter
    ROWTERMINATOR   = '0x0a', --Use to shift the control to next row

    TABLOCK
)
GO
-- ........
INSERT INTO dbo.RAW_FakeNames_20191126
    SELECT  Number,
            Gender,
            NameSet,
            Title,
            GivenName,
            MiddleInitial,
            Surname,
            AmountPaid,
            StreetAddress,
            City,
            State,
            StateFull,
            ZipCode,
            Country,
            CountryFull,
            Feedback,
            EmailAddress,
            Username,
            Password,
            BrowserUserAgent,
            TelephoneNumber,
            TelephoneCountryCode,
            MothersMaiden,
            Birthday,
            TropicalZodiac,
            CCType,
            CCNumber,
            CVV2,
            CCExpires,
            NationalID,
            UPS,
            WesternUnionMTCN,
            MoneyGramMTCN,
            Color,
            Occupation,
            Company,
            Vehicle,
            Domain,
            BloodType,
            Pounds,
            Kilograms,
            FeetInches,
            Centimeters,
            GUID,
            Latitude,
            Longitude
    FROM dbo.RAW_FakeNames_20191126_Staging

-- Query the total count of rows
SELECT COUNT(*) as 'RowCount'
FROM RAW_FakeNames_20191126;
GO

-- Query all info + limit first 50
SELECT *
FROM RAW_FakeNames_20191126
WHERE RowNumber BETWEEN 1 AND 50;
GO
