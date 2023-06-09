﻿BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location     = "${env:location}"
  $serverName   = "psql-hawaii-${env:buildId}"

  # log
  Write-Host "Running PostgreSQL Flexible Server tests for {rgName: $rgName}, {location: $location}, {serverName: $serverName}"
}

Describe "Verify PostgreSql Flexible Server" {
  It "Should contain the PostgreSQL Flexible Server named $serverName" {
    # arrange
    $params = @{
      ResourceType      = "PostgreSqlFlexibleServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the PostgreSQL Flexible Server with Name property of $serverName" {
    # arrange
    $params = @{
      ResourceType      = "PostgreSqlFlexibleServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
      PropertyKey       = "Name"
      PropertyValue     = $serverName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the PostgreSQL Flexible Server named $serverName" {
    Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName $rgName -Name $serverName | Should -BeSuccessful
  }

  It "Should contain the PostgreSQL Flexible Server named $serverName in the location" {
    Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName $rgName -Name $serverName | Should -BeInLocation $location
  }

  It "Should contain the PostgreSQL Flexible Server named $serverName in a resource group named $rgName" {
    Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName $rgName -Name $serverName | Should -BeInResourceGroup $rgName
  }
}
