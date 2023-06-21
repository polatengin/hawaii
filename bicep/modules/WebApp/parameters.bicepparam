using './main.bicep'

param appserviceplanName = 'asp-test-${readEnvironmentVariable('buildId', '001')}'
param webappName = 'webapp-test-${readEnvironmentVariable('buildId', '001')}'
param staticwebappName = 'staticwebapp-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
