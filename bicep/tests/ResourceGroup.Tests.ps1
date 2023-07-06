BeforeAll {
  Import-Module BenchPress.Azure

  $rgName = "rg-hawaii-${env:buildId}"
  $noRgName = "notestrg"
  $location = "${env:location}"
}

Describe "Verify Resource Group Exists" {
  It "Should contain the Resource Group named $rgName" {
    # arrange
    $params = @{
      ResourceType      = "ResourceGroup"
      ResourceName      = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain the Resource Group named $rgName" {
    # arrange
    $params = @{
      ResourceType      = "ResourceGroup"
      ResourceName      = $rgName
      PropertyKey       = "ResourceGroupName"
      PropertyValue     = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Resource Group named $rgName" {
    Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeSuccessful
  }

  It "Should not contain the Resource Group named $noRgName" {
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPResourceGroup -ResourceGroupName $noRgName -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain the Resource Group named $rgName in the location" {
    Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeInLocation $location
  }
}
