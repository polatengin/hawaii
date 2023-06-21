using './main.bicep'

param name = 'strtest${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
