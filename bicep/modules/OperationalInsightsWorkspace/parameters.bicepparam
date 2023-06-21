using './main.bicep'

param name = 'oiw-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
