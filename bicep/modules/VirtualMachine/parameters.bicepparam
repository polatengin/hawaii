using './main.bicep'

param vmName = 'vm-test'
param adminUsername = 'adminUserName'
param authenticationType = 'password'
param adminPasswordOrKey = ''
param dnsLabelPrefix = 'dnsLabelPrefix'
param ubuntuOSVersion = '18.04-LTS'
param location = 'westus'
param vmSize = 'Standard_B2s'
param virtualNetworkName = 'vNet'
param subnetName = 'Subnet'
param networkSecurityGroupName = 'SecGroupNet'