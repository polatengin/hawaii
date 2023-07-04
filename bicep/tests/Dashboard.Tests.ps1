BeforeAll {
  Import-Module Az.InfrastructureTesting

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $dashboardName = "sampleDashboard"

  # log
  Write-Host "Running Dashboard Tests for {rgName: $rgName}, {dashboardName: $dashboardName}, {location: $location}"
}

Describe "Verify Dashboard" {
  It "Should contain the Dashboard" {
    # act
    $result = Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Dashboard in the location" {
    # act
    $result = Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Dashboard in the resource group" {
    # act
    $result = Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
