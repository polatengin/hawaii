using './main.bicep'

param dashboardName = 'dash-test-${readEnvironmentVariable('buildId', '001')}'
param dashboardDisplayName = 'Sample Dashboard'
param location = 'westus'
