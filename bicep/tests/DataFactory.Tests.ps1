BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = 'rg-test'
  $dataFactoryName = 'sampleadf'
  $location = 'westus3'
}

Describe 'Verify Data Factory' {
  BeforeAll {
    $noDataFactoryName = 'nosampleadf'
  }

  It "Should contain the Data Factory named $dataFactoryName" {
    # arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Data Factory named $dataFactoryName" {
    # arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
      PropertyKey       = 'DataFactoryName'
      PropertyValue     = $dataFactoryName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Data Factory named $dataFactoryName" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeSuccessful
  }

  It "Should not contain the Data Factory named $noDataFactoryName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $noDataFactoryName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain the Data Factory named $dataFactoryName in the location" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeInLocation $location
  }

  It "Should contain the Data Factory named $dataFactoryName in the resource group" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Data Factory Linked Service' {
  BeforeAll {
    $linkedServiceName = 'BenchpressStorageLinkedService'
  }

  It "Should contain the Data Factory with a Linked Service named $linkedServiceName" {
    # arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Data Factory with a Linked Service named $linkedServiceName" {
    # arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
      PropertyKey       = 'Name'
      PropertyValue     = $linkedServiceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Data Factory with a Linked Service named $linkedServiceName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      Name              = $linkedServiceName
    }

    # act and assert
    Confirm-AzBPDataFactoryLinkedService @params | Should -BeSuccessful
  }
}
