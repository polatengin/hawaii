BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"

  # log
  Write-Host "Running Resource Group tests for {rgName: $rgName}, {location: $location}"
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

  It "Should contain the Resource Group named $rgName in the location" {
    Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeInLocation $location
  }
}
