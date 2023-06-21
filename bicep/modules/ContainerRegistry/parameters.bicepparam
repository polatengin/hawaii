using './main.bicep'

param name = 'acrtest${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
