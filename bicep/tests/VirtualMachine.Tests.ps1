BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $vmName = "simpleLinuxVM1"
  $noVmName = "noSimpleLinuxVM1"
  $location = "${env:location}"
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

  It "Should not contain the Virtual Machine named $noVmName" {
    # arrange
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName  = $rgName
      VirtualMachineName = $noVmName
      ErrorAction        = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPVirtualMachine @params | Should -Not -BeSuccessful
  }

  It "Should contain the Virtual Machine named $vmName in the location" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName | Should -BeInLocation $location
  }

  It "Should contain the Virtual Machine named $vmName in the resource group" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName
    | Should -BeInResourceGroup $rgName
  }
}
