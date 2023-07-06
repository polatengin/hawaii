BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $oiwName = "oiw-hawaii-${env:buildId}"
  $location = "${env:location}"

  # log
  Write-Host "Running Operational Insights Workspace tests for {rgName: $rgName}, {location: $location}, {oiwName: $oiwName}"
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

  It "Should contain the Operational Insights Workspace named $oiwName in the location" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName | Should -BeInLocation $location
  }

  It "Should contain the Operational Insights Workspace named $oiwName in the resource group" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName | Should -BeInResourceGroup $rgName
  }
}
