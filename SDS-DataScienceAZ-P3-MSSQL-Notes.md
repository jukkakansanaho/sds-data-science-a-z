_SuperDataScience: Data Science A-Z course | jukka.kansanaho@gmail.com | 2019-11-20_

This file contains Notes and tips for Data Science A-Z course's ETL sections.

# Part-3/Module-19: ETL Phase-2

- When running MS SQL Server in a Docker container + you cannot use MSVS+SSDT tools, you need to use alternative options.

  - Azure Data Studio + SQL queries
  - command line queries

- NOTE: When running MS SQL Server in a Docker container volume mount paths don't work as in Linux/Mac

## Azure Data Studio + SQL scripts

- There's a known bug in MSSS `BULK INSERT` (https://github.com/microsoft/mssql-docker/issues/432)

  - Some discussion about the topic: https://stackoverflow.com/questions/41393887/sql-server-on-linux-bulk-import-error/41865509#41865509

  - To make `BULK INSERT` work, you need to copy CSV file from mounted volume dir (e.g. /data) to e.g. /tmp inside the container

  - `docker exec -it <Container name / ID> cp <MOUNTED-VOLUME-DIR/FILE_NAME> /tmp`

- To have RowNumber auto-increment work, you need to

  1. Do `BULK INSERT` from raw CSV into a Staging table (without RowNumber column)
  2. `INSERT INTO from staging table to target table _with_ RowNumber auto-increment column.

- For SQL query example, see: [sds-datra-science-m19-create-table-and-import-csv](./scripts/sds-data-science-m19-create-table-and-import-csv.sql)

## Azure Data Studio + Flat-File-Import wizard + SQL scripts

- To activate Flat File Import wizard in Azure Data Studio, press: `CTRL + I` and follow Instructions

  - With this wizard, you can do the CSV import to staging table (without auto-incremented RowCount column)

- To add that extra column, you need to execute the later part (`INSERT INTO ...`) of the SQL query
