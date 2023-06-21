using './main.bicep'

param name = 'kv-test-${readEnvironmentVariable('buildId', '001')}'
param svcPrincipalObjectId = ''
param location = 'westus'
