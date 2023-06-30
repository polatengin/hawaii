using './main.bicep'

param aksName = 'aks-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = readEnvironmentVariable('location', 'westus')
param agentPoolName = 'aphawaii'
