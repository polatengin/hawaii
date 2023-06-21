using './main.bicep'

param name = 'asp-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
