using './main.bicep'

param aksName = 'aks-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
param agentPoolName = 'aphawaii'
