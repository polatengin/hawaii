BeforeAll {
  Import-Module Az.InfrastructureTesting

  # arrange
  $rgName = 'rg-test'
  $appInsightsName = 'appinsightstest'
  $location = 'westus3'
  $diagnosticSettingName = 'diagnosticsettingtest'
  $resourceId = "path/for/resourceId"

  # log
  Write-Host "Running AppInsights Tests for {rgName: $rgName}, {appInsightsName: $appInsightsName}, {location: $location}, {diagnosticSettingName: $diagnosticSettingName}, {resourceId: $resourceId}"
}

Describe 'Verify Application Insights' {
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

Describe 'Verify Diagnostic Setting' {
  It "Should contain the Diagnostic Setting" {
    # act
    $result = Confirm-AzBPDiagnosticSetting -ResourceId $ResourceId -Name $diagnosticSettingName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Diagnostic Setting in the resource group" {
    # act
    $result = Confirm-AzBPDiagnosticSetting -ResourceId $ResourceId -Name $diagnosticSettingName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
