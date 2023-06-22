using './main.bicep'

param name = 'acrhawaii${readEnvironmentVariable('buildId', '001')}'
param location = 'westus'
