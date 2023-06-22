using './main.bicep'

param synapseName = 'synapse-hawaii-${readEnvironmentVariable('buildId', '001')}'
param adlsName = 'adlshawaii${readEnvironmentVariable('buildId', '001')}'
param adlsFsName = 'fs-hawaii-${readEnvironmentVariable('buildId', '001')}'
param synapse_sqlpool_admin_username = 'sqlAdmin'
param location = 'westus'
