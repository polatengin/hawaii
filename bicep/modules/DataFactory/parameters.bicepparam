using './main.bicep'

param dataFactoryName = 'adf-test-${readEnvironmentVariable('buildId', '001')}'
param storageAccountName = 'stg-test-${readEnvironmentVariable('buildId', '001')}'
param blobContainerName = 'blob-test-${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
