BeforeAll {
  Import-Module Az.InfrastructureTesting

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $dataFactoryName = "sampleadf"
  $location = "${env:location}"

  # log
  Write-Host "Running Data Factory Tests for {rgName: $rgName}, {dataFactoryName: $dataFactoryName}, {location: $location}"
}

Describe "Verify Data Factory" {
  It "Should contain the Data Factory" {
    # act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Data Factory in the location" {
    # act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Data Factory in the resource group" {
    # act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
