using './main.bicep'

param appInsightsName = 'appinsights-test-${readEnvironmentVariable('buildId', '001')}'
param workspaceName = 'logworkspace-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
