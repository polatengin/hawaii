﻿BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $acrName = "acrhawaii${env:buildId}"

  # log
  Write-Host "Running Container Registry Tests for {rgName: $rgName}, {acrName: $acrName}, {location: $location}"
}

Describe "Verify Container Registry" {
  It "Should contain the Container Registry" {
    # act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Container Registry in the location" {
    # act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Container Registry in the resource group" {
    # act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
