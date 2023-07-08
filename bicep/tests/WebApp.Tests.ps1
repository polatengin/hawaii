BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "WestEurope"
  $webappName = "webapp-hawaii-${env:buildId}"
  $appInsightsSettingName = "APPLICATIONINSIGHTS_CONNECTION_STRING"
  $webappStaticSiteName = "staticwebapp-hawaii-${env:buildId}"

  # log
  Write-Host "Running Web App tests for {rgName: $rgName}, {location: $location}, {webappName: $webappName}, {appInsightsSettingName: $appInsightsSettingName}, {webappStaticSiteName: $webappStaticSiteName}"
}

Describe "Verify Web App Exists" {
  It "Should contain the Web App named $webappName" {
    # arrange
    $params = @{
      ResourceType      = "WebApp"
      ResourceGroupName = $rgName
      ResourceName      = $webappName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Web App named $webappName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebApp"
      ResourceGroupName = $rgName
      ResourceName      = $webappName
      PropertyKey       = "Name"
      PropertyValue     = $webappName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Web App named $webappName" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeSuccessful
  }

  It "Should contain the Web App named $webappName in the location" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeInLocation $location
  }

  It "Should contain the Web App named $webappName in the resource group" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeInResourceGroup $rgName
  }
}

Describe "Verify Web App Config"{
  It "Should contain the App Setting named $appInsightsSettingName" {
    # arrange
    $params = @{
      ResourceType      = "WebApp"
      ResourceGroupName = $rgName
      ResourceName      = $webappName
      PropertyKey       = "SiteConfig.AppSettings[1].Name"
      PropertyValue     = $appInsightsSettingName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }
}

Describe "Verify Web App Static Site Exists" {
  It "Should contain the Web App named $webappStaticSiteName" {
    # arrange
    $params = @{
      ResourceType      = "WebAppStaticSite"
      ResourceGroupName = $rgName
      ResourceName      = $webappStaticSiteName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Web App named $webappStaticSiteName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebAppStaticSite"
      ResourceGroupName = $rgName
      ResourceName      = $webappStaticSiteName
      PropertyKey       = "Name"
      PropertyValue     = $webappStaticSiteName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Web App named $webappStaticSiteName" {
    Confirm-AzBPWebAppStaticSite -ResourceGroupName $rgName -StaticWebAppName $webappStaticSiteName | Should -BeSuccessful
  }

  It "Should contain the Web App named $webappStaticSiteName in the location" {
    Confirm-AzBPWebAppStaticSite -ResourceGroupName $rgName -StaticWebAppName $webappStaticSiteName | Should -BeInLocation $location
  }

  It "Should contain the Web App named $webappStaticSiteName in the resource group" {
    Confirm-AzBPWebAppStaticSite -ResourceGroupName $rgName -StaticWebAppName $webappStaticSiteName | Should -BeInResourceGroup $rgName
  }
}
