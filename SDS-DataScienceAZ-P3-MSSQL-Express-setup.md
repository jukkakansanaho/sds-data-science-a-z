_SuperDataScience: Data Science A-Z course | jukka.kansanaho@gmail.com | 2019-11-06_

# Part-3/Module-17: MS SQL Server Express setup

- Install Docker
- Install and run MS's SQL Server Express as a docker container
- See instructions: https://hub.docker.com/_/microsoft-mssql-server

## WHY (to install and run SQL Server as a Docker container)?

- In case you're not running Windows OS (e.g. MacOS)

## Install MS SQL Server Express docker image

- On console, run:\
  `docker pull mcr.microsoft.com/mssql/server`

## Run MS SQL Server Express

- On console, run:\
  `docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu`

- or: `docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<YourStrong@Passw0rd>" -p 1433:1433 --name sql1 -d mcr.microsoft.com/mssql/server:2017-latest`

- Check that the container is running OK: \
  `docker ps -a` \
  => You should see MS SQL container (with the name you gave with --name parameter) running

## Connect to MS SQL Server Express container

- To connect to SQL Server container, run:\
  `docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>` \
  => Now you can execute SQL command inside the Container

- To connect SQL Server container from outside, run: \
  `sqlcmd -S <ip_address>,1433 -U SA -P "<YourNewStrong@Passw0rd>"` \
  NOTE: This assumes you have installed sqlcmd tool on your host system

## Install sqlcmd and bcp the SQL Server command-line tools on Linux

- See: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15

## Use Visual Studio Code to execute SQL Server commands

- See instructions and a short tutorial: https://docs.microsoft.com/en-us/sql/visual-studio-code/sql-server-develop-use-vscode?view=sql-server-linux-2017

- NOTE: This is maybe the fastest and easiest way to connect to MS SQL Server running in a Docker container.

## Install Azure Data Studio

- If you want to use cross-platform UI for accessing MS SQL Servers, you can use Azure Data Studio

- See description: https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is?view=sql-server-ver15

- See installation instructions and how to get started: https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-ver15

- For Windows, you can also use MS SQL Server Management Studio: https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms?view=sql-server-ver15

## Install Visual Studio

- To be able to use MS SQL Server Data Tools (SSDT) you need to download and install MSVS + the following extensions (used for ETL in this class).

  - MS SQL Server Integration Service (SSIS),
  - MS SQL Server Analysis Service (SSAS),
  - MS SQL Server Reporting Service (SSRS)

- Download MSVS: https://visualstudio.microsoft.com/downloads/

- Install Extensions for MSVS: https://docs.microsoft.com/en-us/visualstudio/ide/finding-and-using-visual-studio-extensions?view=vs-2019

- Download SSIS extension for MSVS: https://marketplace.visualstudio.com/items?itemName=SSIS.SqlServerIntegrationServicesProjects

- Download SSAS extension for MSVS: https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects

- Download SSRS extension for MSVS: https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio

## Stop and remove sql SQL Server Express container

- To stop the cintainer, run: \
  `docker stop <container name or ID>`

- Remove the container, run: \
  `docker rm <conyainer name or ID>`

## More info

- Quickstart (2019 version): Run SQL Server container images with Docker: https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash
- Quickstart (2017 version): Run SQL Server container images with Docker: https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-2017&pivots=cs1-bash
