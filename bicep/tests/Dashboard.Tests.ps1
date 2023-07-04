BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName   = 'rg-test'
  $location = 'westus3'
  $dashboardName = 'sampleDashboard'
}

Describe 'Verify Dashboard' {
  It "Should contain the Dashboard named $dashboardName" {
    # arrange
    $params = @{
      ResourceType      = "PortalDashboard"
      ResourceName      = $dashboardName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Dashboard named $dashboardName" {
    # arrange
    $params = @{
      ResourceType      = "PortalDashboard"
      ResourceName      = $dashboardName
      ResourceGroupName = $rgName
      PropertyKey       = "Name"
      PropertyValue     = $dashboardName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Dashboard named $dashboardName" {
    Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName | Should -BeSuccessful
  }

  It "Should contain the Dashboard named $dashboardName in the location" {
    Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName | Should -BeInLocation $location
  }

  It "Should contain the Dashboard named $dashboardName in the resource group" {
    Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName | Should -BeInResourceGroup $rgName
  }
}
