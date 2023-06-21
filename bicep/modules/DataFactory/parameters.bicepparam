using './main.bicep'

param dataFactoryName = 'adf-test-${readEnvironmentVariable('buildId', '001')}'
param storageAccountName = 'stgtest${readEnvironmentVariable('buildId', '001')}'
param blobContainerName = 'blob-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
