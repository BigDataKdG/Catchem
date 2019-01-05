# Pentaho DI local setup

### Environment variables
In Spoon, go to Edit - Edit the kettle.properties file and add following variables:
- ${DB_NAME_DWH} (Name of the datawarehouse database)
- ${DB_NAME} (Name of the operational database)
- ${INSTANCE_NAME} (MS SQL Server instance name)
- ${DB_USERNAME} (Username to connect to SQL Server)
- ${DB_PASSWORD} (Password to connect to SQL Server)
- ${LOCAL_FILE_STRUCTURE} (Directory where Catchem is located (add trailing backslash!))
- ${SQL_FILE_LOCATION} (Directory where the generated sql file is located (add trailing backslash!))
