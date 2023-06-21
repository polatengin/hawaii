using './main.bicep'

param name = 'str-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
