﻿BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe "Verify Action Group" {
  $rgName = "rg-hawaii-${env:buildId}"
  $actionGroupName = "aghawaii${env:buildId}"
  $location = "global"
  $noActionGroupName = "noactiongroup"

  It "Should contain an Action Group named $actionGroupName" {
    # arrange
    $params = @{
      ResourceType      = "ActionGroup"
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Action Group named $actionGroupName" {
    # arrange
    $params = @{
      ResourceType      = "ActionGroup"
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
      PropertyKey       = "GroupShortName"
      PropertyValue     = $actionGroupName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Action Group named $actionGroupName" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName | Should -BeSuccessful
  }

  It "Should not contain an Action Group named $noActionGroupName" {
    # arrange
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ActionGroupName   = $noActionGroupName
      ErrorAction       = "SilentlyContinue"
    }
    # act and assert
    Confirm-AzBPActionGroup @params | Should -Not -BeSuccessful
  }

  It "Should contain an Action Group named $actionGroupName in $location" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName | Should -BeInLocation $location
  }

  It "Should contain an Action Group named $actionGroupName in $rgName" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName | Should -BeInResourceGroup $rgName
  }
}
