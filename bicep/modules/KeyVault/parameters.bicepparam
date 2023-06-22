using './main.bicep'

param name = 'kv-hawaii-${readEnvironmentVariable('buildId', '001')}'
param svcPrincipalObjectId = readEnvironmentVariable('AZ_SP_HAWAII_ID', '')
param location = 'westus'
