BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $accountName = "strhawaii${env:buildId}"
  $containerName = "azbenchpresscontainer"
  $location = "${env:location}"

  # log
  Write-Host "Running Storage Tests for {rgName: $rgName}, {accountName: $accountName}, {containerName: $containerName}, {location: $location}"
}

Describe "Verify Storage Account" {
  It "Should contain the Storage Account named $accountName" {
    # arrange
    $params = @{
      ResourceType      = "StorageAccount"
      ResourceGroupName = $rgName
      ResourceName      = $accountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Storage Account named $accountName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StorageAccount"
      ResourceGroupName = $rgName
      ResourceName      = $accountName
      PropertyKey       = "StorageAccountName"
      PropertyValue     = $accountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Storage Account named $accountName" {
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName | Should -BeSuccessful
  }

  It "Should contain the Storage Account named $accountName in the location" {
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName | Should -BeInLocation $location
  }

  It "Should contain the Storage Account named $accountName in the resource group" {
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName | Should -BeInResourceGroup $rgName
  }
}

Describe "Verify Storage Container" {
  It "Should contain the Storage Container named $containerName" {
    # arrange
    $params = @{
      ResourceType      = "StorageContainer"
      ResourceGroupName = $rgName
      AccountName       = $accountName
      ResourceName      = $containerName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Storage Container named $containerName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StorageContainer"
      ResourceGroupName = $rgName
      AccountName       = $accountName
      ResourceName      = $containerName
      PropertyKey       = "Name"
      PropertyValue     = $containerName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Storage Container named $containerName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $accountName
      Name              = $containerName
    }

    # act and assert
    Confirm-AzBPStorageContainer @params | Should -BeSuccessful
  }
}
