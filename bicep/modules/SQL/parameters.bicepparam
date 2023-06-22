using './main.bicep'

param serverName = 'sqlsvr-hawaii-${readEnvironmentVariable('buildId', '001')}'
param databaseName = 'sqldb-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
