using './main.bicep'

param appserviceplanName = 'app-svc-plan-test-${readEnvironmentVariable('buildId', '001')}'
param webappName = 'webapp-test-${readEnvironmentVariable('buildId', '001')}'
param staticwebappName = 'staticwebapp-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus2'
