BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $oiwName = "oiwName"
  $noOiwName = "noOiwName"
  $location = "${env:location}"
}

Describe "Verify Operational Insights Workspace Exists" {
  It "Should contain the Operational Insights Workspace named $oiwName" {
    # arrange
    $params = @{
      ResourceType      = "OperationalInsightsWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $oiwName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain the Operational Insights Workspace named $oiwName" {
    # arrange
    $params = @{
      ResourceType      = "OperationalInsightsWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $oiwName
      PropertyKey       = "Name"
      PropertyValue     = $oiwName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Operational Insights Workspace named $oiwName" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName | Should -BeSuccessful
  }

  It "Should not contain the Operational Insights Workspace named $noOiwName" {
    # arrange
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noOiwName
      ErrorAction       = "SilentlyContinue"
    }

    # act and asssert
    Confirm-AzBPOperationalInsightsWorkspace @params | Should -Not -BeSuccessful
  }

  It "Should contain the Operational Insights Workspace named $oiwName in the location" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName | Should -BeInLocation $location
  }

  It "Should contain the Operational Insights Workspace named $oiwName in the resource group" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName
    | Should -BeInResourceGroup $rgName
  }
}
