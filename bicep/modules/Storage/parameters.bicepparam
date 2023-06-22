using './main.bicep'

param name = 'strhawaii${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
