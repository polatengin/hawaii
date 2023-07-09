# hawaii

Sample `Azure DevOps Pipeline` that deploys infrastructure to `Azure` using `Bicep`, and test the deployment using `BenchPress`

## Components

- `Azure DevOps Pipeline` - Orchestrator to deploy infrastructure to Azure
- `Bicep` - Infrastructure as Code tool and language to deploy infrastructure to Azure
- `BenchPress` - Test framework to test infrastructure deployments

### Azure DevOps Pipeline

The pipeline is defined in `pipeline.yml` and is executed in `Azure DevOps` using the hosted `Azure DevOps Agent`.

The pipeline has four variables and one variable group `BenchPress` that contains the following variables:

- serviceConnectionName
- location
- buildId
- resourceGroupName
- BenchPress
  - AZ_APPLICATION_ID
  - AZ_ENCRYPTED_PASSWORD
  - AZ_TENANT_ID
  - AZ_SUBSCRIPTION_ID
  - AZ_SP_HAWAII_APP_ID

The pipeline consists of 3 steps:

- Setup

```powershell
az bicep install
az bicep upgrade

Install-Module -Name Az -Force
Install-Module -Name Az.App -Force
Install-Module -Name Az.Portal -Force
Install-Module -Name Pester -Force
Install-Module -Name BenchPress.Azure -Force
```

- Deploy Resource Group

```powershell
Write-Host "Creating resource group: $(resourceGroupName)"
az group create --name "$(resourceGroupName)" --location "$(location)" --output "none"
Write-Host "Resource group created: $(resourceGroupName)"

foreach ($module in Get-ChildItem -Path "./bicep/modules" -Directory | Where-Object { $_.Name -notlike "_*" }) {
  $modulePath = $module.FullName

  Write-Host "Processing module: ${modulePath}"
  az deployment group create --resource-group "$(resourceGroupName)" --template-file "$modulePath/main.bicep" --parameters "$modulePath/parameters.bicepparam" --output "none"
  Write-Host "Module deployed: ${modulePath}"
}
```

- Run e2e tests

```powershell
Invoke-Pester -OutputFile test.xml -OutputFormat NUnitXML
```

- Publish test results

```yml
- task: PublishTestResults@2
  displayName: "Publish test results"
  inputs:
    testResultsFormat: "NUnit"
    testResultsFiles: "*.xml"
    searchFolder: "$(System.DefaultWorkingDirectory)/bicep/tests"
    failTaskOnFailedTests: true
    testRunTitle: "Test Results"
    publishRunAttachments: true
    mergeTestResults: true
```
