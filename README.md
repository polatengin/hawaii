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

In this step, Pester tests are executed to test the deployment of the infrastructure, output of the tests are saved to `output.xml` file in `NUnit` format.

```powershell
Invoke-Pester -OutputFile output.xml -OutputFormat NUnitXML
```

- _Publish test results_

In this step, test results are published to `Azure DevOps` using `PublishTestResults@2` task.

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

### Bicep Modules

The infrastructure is defined in `bicep/modules` folder, and consists of following modules;

- ActionGroup
- AKSCluster
- AppInsights
- AppServicePlan
- ContainerApp
- ContainerRegistry
- CosmosDB
- Dashboard
- DataFactory
- EventHub
- KeyVault
- OperationalInsightsWorkspace
- PostgreSql
- SQL
- Storage
- StreamAnalytics
- Synapse
- VirtualMachine
- WebApp

Each module has a bicep file `main.bicep` and a parameters file `parameters.bicepparam` that contains the parameters for the module.

### BenchPress Tests

The tests are defined in `bicep/tests` folder, and consists of following tests;

- ActionGroup.Tests.ps1
- AKSCluster.Tests.ps1
- AppInsights.Tests.ps1
- AppServicePlan.Tests.ps1
- ContainerApp.Tests.ps1
- ContainerRegistry.Tests.ps1
- CosmosDB.Tests.ps1
- Dashboard.Tests.ps1
- DataFactory.Tests.ps1
- EventHub.Tests.ps1
- KeyVault.Tests.ps1
- OperationalInsightsWorkspace.Tests.ps1
- PostgreSql.Tests.ps1
- ResourceGroup.Tests.ps1
- SQL.Tests.ps1
- Storage.Tests.ps1
- StreamAnalytics.Tests.ps1
- Synapse.Tests.ps1
- VirtualMachine.Tests.ps1
- WebApp.Tests.ps1

Each test file has a `BeforeAll` block that contains the setup code.

```powershell
Import-Module BenchPress.Azure

# arrange
$rgName = "rg-hawaii-${env:buildId}"
$location = "${env:location}"

# log
Write-Host "Running Tests for {rgName: $rgName}, {location: $location}"
```

Each test file contains one or more tests, and each test is defined as a `Describe` block.

```powershell
Describe "Test description" {
  It "Test name" {
    # Test code, such as;
    Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeSuccessful
  }
}
```

## Pipeline Execution

The pipeline can be run by clicking the `Run pipeline` button on the top right corner of the pipeline page.

![image](https://github.com/polatengin/hawaii/assets/118744/f061ffe7-22b1-4473-8592-6810ddf74057)

`Deploy and Test Bicep Modules` job will be executed, and the output of the tests will be published to `Azure DevOps`. Steps of the pipeline can be viewed by clicking the name of the job on the pipeline page.

![image](https://github.com/polatengin/hawaii/assets/118744/c92a1c1e-aab0-48ea-b1ed-55015e246650)

Output logs of the `Run e2e tests` step can be viewed by clicking the step on the pipeline page.

![image](https://github.com/polatengin/hawaii/assets/118744/2f461f46-0d19-4762-9c06-538a42ca847f)

All the logs and the output of the tests can be viewed on the page.

![image](https://github.com/polatengin/hawaii/assets/118744/0cf518b4-73bc-4982-8329-6b2962419734)

The output of the tests can be viewed by clicking the `Tests` tab on the pipeline page.

![image](https://github.com/polatengin/hawaii/assets/118744/524432f5-cc18-422c-8191-3ed4cdb8ea03)
