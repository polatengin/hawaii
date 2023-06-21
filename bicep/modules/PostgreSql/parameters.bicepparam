using './main.bicep'

param name = 'psql-test-${readEnvironmentVariable('buildId', '001')}'
param adminPassword = ''
param location = 'westus'
