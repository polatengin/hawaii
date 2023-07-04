BeforeAll {
  Import-Module Az.InfrastructureTesting

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $containerAppName   = "containerAppBenchPressTest"
  $managedEnvName   = "managedenvbenchpresstest"

  # log
  Write-Host "Running Container Application Tests for {rgName: $rgName}, {location: $location}, {containerAppName: $containerAppName}, {managedEnvName: $managedEnvName}"
}

Describe "Verify Container Application" {
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
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Container Application in the resource group" {
    # act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}

Describe "Verify Container Application Managed Environment" {
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
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Container Application in the resource group" {
    # act
    $result = Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
