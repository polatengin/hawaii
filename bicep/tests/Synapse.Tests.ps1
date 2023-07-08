BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $workSpaceName = "synapse-hawaii-${env:buildId}"
  $sparkPoolName = "spark"
  $sqlPoolName = "sql"

  # log
  Write-Host "Running Synapse tests for {rgName: $rgName}, {location: $location}, {workSpaceName: $workSpaceName}, {sparkPoolName: $sparkPoolName}, {sqlPoolName: $sqlPoolName}"
}

Describe "Verify Synapse Workspace" {
  It "Should contain the Synapse Workspace named $workSpaceName" {
    # arrange
    $params = @{
      ResourceType      = "SynapseWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $workSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Synapse Workspace named $workSpaceName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SynapseWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $workSpaceName
      PropertyKey       = "Name"
      PropertyValue     = $workSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Synapse Workspace named $workSpaceName" {
    Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName | Should -BeSuccessful
  }

  It "Should contain the Synapse Workspace named $workSpaceName in the location" {
    Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName
    | Should -BeInLocation $location
  }

  It "Should contain the Synapse Workspace named $workSpaceName in the resource group" {
    Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName
    | Should -BeInResourceGroup $rgName
  }
}

Describe "Verify Synapse Spark/SQL Pool" {
  It "Should contain the Synapse Spark Pool named $sparkPoolName" {
    # arrange
    $params = @{
      ResourceType      = "SynapseSparkPool"
      ResourceGroupName = $rgName
      WorkspaceName     = $workSpaceName
      ResourceName      = $sparkPoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Synapse Spark Pool named $sparkPoolName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SynapseSparkPool"
      ResourceGroupName = $rgName
      WorkspaceName     = $workSpaceName
      ResourceName      = $sparkPoolName
      PropertyKey       = "Name"
      PropertyValue     = $sparkPoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Synapse Workspace with a Spark Pool named $sparkPoolName" {
    # arrange
    $params = @{
      ResourceGroupName    = $rgName
      WorkspaceName        = $workSpaceName
      SynapseSparkPoolName = $sparkPoolName
    }

    # act and assert
    Confirm-AzBPSynapseSparkPool @params | Should -BeSuccessful
  }

  It "Should contain the Spark Pool named $sparkPoolName in the location" {
    # arrange
    $params = @{
      ResourceGroupName    = $rgName
      WorkspaceName        = $workSpaceName
      SynapseSparkPoolName = $sparkPoolName
    }

    # act and assert
    Confirm-AzBPSynapseSparkPool @params | Should -BeInLocation $location
  }

  It "Should contain the Spark Pool named $sparkPoolName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName    = $rgName
      WorkspaceName        = $workSpaceName
      SynapseSparkPoolName = $sparkPoolName
    }
    # act and assert
    Confirm-AzBPSynapseSparkPool @params | Should -BeInResourceGroup $rgName
  }

  It "Should contain the Synapse SQL Pool named $sqlPoolName" {
    # arrange
    $params = @{
      ResourceType      = "SynapseSqlPool"
      ResourceGroupName = $rgName
      WorkspaceName     = $workSpaceName
      ResourceName      = $sqlPoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Synapse SQL Pool named $sqlPoolName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SynapseSqlPool"
      ResourceGroupName = $rgName
      WorkspaceName     = $workSpaceName
      ResourceName      = $sqlPoolName
      PropertyKey       = "Name"
      PropertyValue     = $sqlPoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Synapse Workspace with a SQL Pool named $sqlPoolName" {
    # arrange
    $params = @{
      ResourceGroupName  = $rgName
      WorkspaceName      = $workSpaceName
      SynapseSqlPoolName = $sqlPoolName
    }

    # act and assert
    Confirm-AzBPSynapseSqlPool @params | Should -BeSuccessful
  }

  It "Should contain the SQL Pool named $sqlPoolName in the location" {
    # arrange
    $params = @{
      ResourceGroupName  = $rgName
      WorkspaceName      = $workSpaceName
      SynapseSqlPoolName = $sqlPoolName
    }

    # act and assert
    Confirm-AzBPSynapseSqlPool @params | Should -BeInLocation $location
  }

  It "Should contain the SQL Pool named $sqlPoolName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName  = $rgName
      WorkspaceName      = $workSpaceName
      SynapseSqlPoolName = $sqlPoolName
    }

    # act and assert
    Confirm-AzBPSynapseSqlPool @params | Should -BeInResourceGroup $rgName
  }
}
