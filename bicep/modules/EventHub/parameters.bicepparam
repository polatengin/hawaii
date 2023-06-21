using './main.bicep'

param name = 'evnthb-test-${readEnvironmentVariable('buildId', '001')}'
param eventHubNamespaceName = 'evnthbnmspace-test-${readEnvironmentVariable('buildId', '001')}'
param consumerGroupName = 'evntconsumer-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
