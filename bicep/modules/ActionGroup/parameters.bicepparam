using './main.bicep'

param actionGroupName = 'aghawaii${readEnvironmentVariable('buildId', '001')}'
param location = 'global'
