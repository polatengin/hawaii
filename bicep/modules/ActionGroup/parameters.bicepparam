using './main.bicep'

param actionGroupName = 'ag-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'global'
