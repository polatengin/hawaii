BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $appServicePlanName = "asp-hawaii-${env:buildId}"
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

  It "Should contain the App Service Plan in the location" {
    # act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the App Service Plan in the resource group" {
    # act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    Write-Host ($result | ConvertTo-Json -Depth 100)

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
