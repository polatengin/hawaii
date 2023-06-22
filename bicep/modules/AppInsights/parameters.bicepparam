using './main.bicep'

param appInsightsName = 'appinsights-hawaii-${readEnvironmentVariable('buildId', '001')}'
param workspaceName = 'logworkspace-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
