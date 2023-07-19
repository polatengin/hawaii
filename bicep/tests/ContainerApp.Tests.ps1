BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $containerAppName   = "acr-hawaii-${env:buildId}"
  $managedEnvName   = "envacr-hawaii-${env:buildId}"

  # log
  Write-Host "Running Container Application Tests for {rgName: $rgName}, {location: $location}, {containerAppName: $containerAppName}, {managedEnvName: $managedEnvName}"
}

Describe "Verify Container Application" {
  It "Should contain a Container Application named $containerAppName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $containerAppName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application with an Ingress Port of 80 - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $containerAppName
      ResourceGroupName = $rgName
      PropertyKey       = "IngressTargetPort"
      PropertyValue     = 80
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Container Application" {
    # act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Container Application in the location" {
    # act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Container Application in the resource group" {
    # act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}

Describe "Verify Container Application Managed Environment" {
  It "Should contain a Container Application Managed Environment named $managedEnvName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerAppManagedEnv"
      ResourceName      = $managedEnvName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application Managed Environment named $managedEnvName -
    Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerAppManagedEnv"
      ResourceName      = $managedEnvName
      ResourceGroupName = $rgName
      PropertyKey       = "Name"
      PropertyValue     = $managedEnvName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Container Application" {
    # act
    $result = Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Container Application in the location" {
    # act
    $result = Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Container Application in the resource group" {
    # act
    $result = Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
