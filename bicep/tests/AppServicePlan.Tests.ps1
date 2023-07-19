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
  It "Should contain an App Service Plan named $appServicePlanName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "Appserviceplan"
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an App Service Plan named $appServicePlanName with a Free SKU - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "Appserviceplan"
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
      PropertyKey       = "Sku.Tier"
      PropertyValue     = "Free"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

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

    # assert
    $result.ResourceDetails.ResourceGroup | Should -Be "$rgName"
  }
}
