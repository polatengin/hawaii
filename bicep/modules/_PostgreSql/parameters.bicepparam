using './main.bicep'

param name = 'psql-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
