using './main.bicep'

param svcPrincipalObjectId = readEnvironmentVariable('AZ_SP_HAWAII_ID', '')
