using './main.bicep'

param svcPrincipalObjectId = readEnvironmentVariable('AZ_SP_APP_ID', '')
