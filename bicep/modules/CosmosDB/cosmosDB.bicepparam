using './cosmosDB.bicep'

param gremlinAccountName = 'gremlin-test'
param gremlinDatabaseName = 'gremlin-db-name'
param mongoAccountName = 'mongo-test'
param mongoDBDatabaseName = 'mongodb-db-name'
param sqlAccountName = 'sql-test'
param sqlDatabaseName = 'sql-db-name'
param location = 'westus'
param primaryRegion = 'eastus'
param secondaryRegion = 'eastus2'
param dataActions = [
  'Microsoft.DocumentDB/databaseAccounts/readMetadata'
  'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
]
param svcPrincipalObjectId = ''
param roleDefinitionName = 'My Read Write Role'

