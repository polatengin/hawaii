BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $dashboardName = "dash-hawaii-${env:buildId}"

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

  It "Should contain the Dashboard in the correct Type" {
    # act
    $result = Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName

    # assert
    $result.ResourceDetails.Type | Should -Be "Microsoft.Portal/dashboards"
  }
}
