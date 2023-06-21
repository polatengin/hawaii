using './main.bicep'

param aksName = 'aks-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
param agentPoolName = 'aptest'
