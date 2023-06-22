using './main.bicep'

param name = 'kv-test-${readEnvironmentVariable('buildId', '001')}'
param svcPrincipalObjectId = readEnvironmentVariable('AZ_SP_APP_ID', '')
param location = 'westus'
