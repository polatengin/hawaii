﻿BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $workSpaceName = "samplesynws"
  $location = "${env:location}"
}

Describe "Verify Synapse Workspace" {
  BeforeAll {
    $noWorkspaceName = "nosamplesynws"
  }

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

  It "Should not contain the Synapse Workspace named $noWorkspaceName" {
    # arrange
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      WorkspaceName     = $noWorkspaceName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPSynapseWorkspace @params | Should -Not -BeSuccessful
  }
}

Describe "Verify Synapse Spark/SQL Pool" {
  BeforeAll {
    $sparkPoolName = "samplespark"
    $sqlPoolName = "samplesql"
  }

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

#######################################################################################################################

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
