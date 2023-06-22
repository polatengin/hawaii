using './main.bicep'

param name = 'evnthb-hawaii-${readEnvironmentVariable('buildId', '001')}'
param eventHubNamespaceName = 'evnthbnmspace-hawaii-${readEnvironmentVariable('buildId', '001')}'
param consumerGroupName = 'evntconsumer-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
