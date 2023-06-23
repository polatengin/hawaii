using './main.bicep'

param appserviceplanName = 'app-svc-plan-hawaii-${readEnvironmentVariable('buildId', '001')}'
param webappName = 'webapp-hawaii-${readEnvironmentVariable('buildId', '001')}'
param staticwebappName = 'staticwebapp-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westeurope'
