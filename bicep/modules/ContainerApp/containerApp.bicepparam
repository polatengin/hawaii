using './containerApp.bicep'

param containerAppName = 'acr-test'
param location = 'westus'
param targetPort = 80
param containerImage = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'

