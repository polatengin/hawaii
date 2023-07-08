BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $vmName = "vm-hawaii-${env:buildId}"
  $location = "${env:location}"

  # log
  Write-Host "Running Virtual Machine tests for {rgName: $rgName}, {location: $location}, {vmName: $vmName}"
}

Describe "Verify Virtual Machine" {
  It "Should contain the Virtual Machine named $vmName" {
    # arrange
    $params = @{
      ResourceType      = "VirtualMachine"
      ResourceGroupName = $rgName
      ResourceName      = $vmName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Virtual Machine named $vmName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "VirtualMachine"
      ResourceGroupName = $rgName
      ResourceName      = $vmName
      PropertyKey       = "Name"
      PropertyValue     = $vmName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Virtual Machine named $vmName" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName | Should -BeSuccessful
  }

  It "Should contain the Virtual Machine named $vmName in the location" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName | Should -BeInLocation $location
  }

  It "Should contain the Virtual Machine named $vmName in the resource group" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName | Should -BeInResourceGroup $rgName
  }
}
