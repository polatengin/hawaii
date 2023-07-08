BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $appInsightsName = "appinsights-hawaii-${env:buildId}"
  $location = "${env:location}"
  $diagnosticSettingName = "default"

  # log
  Write-Host "Running AppInsights Tests for {rgName: $rgName}, {appInsightsName: $appInsightsName}, {location: $location}, {diagnosticSettingName: $diagnosticSettingName}"
}

Describe "Verify Application Insights" {
  It "Should contain the Application Insights" {
    # act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Application Insights in the location" {
    # act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Application Insights in the resource group" {
    # act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
