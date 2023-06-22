using './main.bicep'

param synapseName = 'synapse-test-${readEnvironmentVariable('buildId', '001')}'
param adlsName = 'adls-test-${readEnvironmentVariable('buildId', '001')}'
param adlsFsName = 'fs-test-${readEnvironmentVariable('buildId', '001')}'
param synapse_sqlpool_admin_username = 'sqlAdmin'
param location = 'westus'
