using './main.bicep'

param dashboardName = 'dash-hawaii-${readEnvironmentVariable('buildId', '001')}'
param dashboardDisplayName = 'Sample Dashboard'
param location = 'westus'
