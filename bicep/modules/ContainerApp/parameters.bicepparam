using './main.bicep'

param containerAppName = 'acr-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
param targetPort = 80
param containerImage = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
