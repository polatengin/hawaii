# hawaii

Sample `Azure DevOps Pipeline` that deploys infrastructure to `Azure` using `Bicep`, and test the deployment using `BenchPress`

## Components

- `Azure DevOps Pipeline` - Orchestrator to deploy infrastructure to Azure
- `Bicep` - Infrastructure as Code tool and language to deploy infrastructure to Azure
- `BenchPress` - Test framework to test infrastructure deployments

### Azure DevOps Pipeline

The pipeline is defined in `pipeline.yml` and is executed in `Azure DevOps` using the hosted `Azure DevOps Agent`.

The pipeline has four variables and one variable group `BenchPress` that contains the following variables:

- _serviceConnectionName_: Name of the `Azure Service Connection` to use to connect to Azure.
- _location_: Location to deploy the infrastructure to.
- _buildId_: Build id of the pipeline.
- _resourceGroupName_: Name of the resource group to create and deploy the infrastructure to.
- _BenchPress_: Variable group that contains the following variables
  - _AZ_APPLICATION_ID_: Application id of the service principal to use to connect to Azure.
  - _AZ_ENCRYPTED_PASSWORD_: Encrypted password of the service principal to use to connect to Azure.
  - _AZ_TENANT_ID_: Tenant id of the service principal to use to connect to Azure.
  - _AZ_SUBSCRIPTION_ID_: Subscription id of the service principal to use to connect to Azure.

The pipeline consists of 3 steps:

- _Setup_

In this step, following script ensures that `Az`, `Az.App`, `Az.Portal`, `Pester` and `BenchPress.Azure` modules are installed from _Powershell Gallery_, and ensures `bicep` tool is installed and upgraded to the latest version.

```powershell
az bicep install
az bicep upgrade

Install-Module -Name Az -Force
Install-Module -Name Az.App -Force
Install-Module -Name Az.Portal -Force
Install-Module -Name Pester -Force
Install-Module -Name BenchPress.Azure -Force
```

- _Deploy Resource Group_

In this step, _Resource Group_ is created and all the modules (_except the folder name starts with underscore_) are deployed to the resource group.

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

- _Run e2e tests_

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
