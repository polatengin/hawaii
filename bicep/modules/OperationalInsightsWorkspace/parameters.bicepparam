using './main.bicep'

param name = 'oiw-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
