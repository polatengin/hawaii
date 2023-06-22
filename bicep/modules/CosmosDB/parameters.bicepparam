using './main.bicep'

param gremlinAccountName = 'gremlin-test-${readEnvironmentVariable('buildId', '001')}'
param gremlinDatabaseName = 'gremlin-db-name-${readEnvironmentVariable('buildId', '001')}'
param mongoAccountName = 'mongo-test-${readEnvironmentVariable('buildId', '001')}'
param mongoDBDatabaseName = 'mongodb-db-name-${readEnvironmentVariable('buildId', '001')}'
param sqlAccountName = 'sql-test-${readEnvironmentVariable('buildId', '001')}'
param sqlDatabaseName = 'sql-db-name-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
param primaryRegion = 'eastus'
param secondaryRegion = 'eastus2'
param dataActions = [
  'Microsoft.DocumentDB/databaseAccounts/readMetadata'
  'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
]
param svcPrincipalObjectId = readEnvironmentVariable('AZ_SP_HAWAII_ID', '')
param roleDefinitionName = 'cosmos-read-role-${readEnvironmentVariable('buildId', '001')}'
