using './main.bicep'

param actionGroupName = 'ag-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'global'
