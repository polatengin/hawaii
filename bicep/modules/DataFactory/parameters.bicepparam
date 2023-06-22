using './main.bicep'

param dataFactoryName = 'adf-hawaii-${readEnvironmentVariable('buildId', '001')}'
param storageAccountName = 'stghawaii${readEnvironmentVariable('buildId', '001')}'
param blobContainerName = 'blob-hawaii-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
