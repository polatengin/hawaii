BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $appServicePlanName = "appserviceplantest"
  $location = "${env:location}"

  # log
  Write-Host "Running App Service Plan Tests for {rgName: $rgName}, {appServicePlanName: $appServicePlanName}, {location: $location}"
}

Describe "Verify App Service Plan" {
  It "Should contain the App Service Plan" {
    # act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the App Service Plan named $appServicePlanName in the location" {
    # act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the App Service Plan named $appServicePlanName in the resource group" {
    # act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
