using './main.bicep'

param serverName = 'sqlsvr-test-${readEnvironmentVariable('buildId', '001')}'
param databaseName = 'sqldb-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
