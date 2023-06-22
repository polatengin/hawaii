using './main.bicep'

param name = 'asp-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
