﻿BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $gremlinAccountName = "gremlin-hawaii-${env:buildId}"
  $gremlinDatabaseName = "gremlin-db-name-${env:buildId}"
  $mongoAccountName = "mongo-hawaii-${env:buildId}"
  $mongoDatabaseName = "mongodb-db-name-${env:buildId}"
  $sqlAccountName = "sql-hawaii-${env:buildId}"
  $sqlDatabaseName = "sql-db-name-${env:buildId}"

  # log
  Write-Host "Running Cosmos DB Tests for {rgName: $rgName}, {location: $location}, {gremlinAccountName: $gremlinAccountName}, {gremlinDatabaseName: $gremlinDatabaseName}, {mongoAccountName: $mongoAccountName}, {mongoDatabaseName: $mongoDatabaseName}, {sqlAccountName: $sqlAccountName}, {sqlDatabaseName: $sqlDatabaseName}"
}

Describe "Cosmos DB Gremlin Database" {
  It "Should contain a Gremlin Cosmos DB Account named $gremlinAccountName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB Account named $gremlinAccountName that is a Global Document DB -
  Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Cosmos DB Account" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Cosmos DB Account in the location" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Cosmos DB Account in the correct Kind" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result.ResourceDetails.Kind | Should -Be "GlobalDocumentDB"
  }

  It "Should contain the Cosmos DB Account PublicNetworkAccess enabled" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result.ResourceDetails.PublicNetworkAccess | Should -Be "Enabled"
  }

  It "Should contain a Gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      PropertyKey       = "Name"
      PropertyValue     = $gremlinDatabaseName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }
}

Describe "Comsos DB Mongo DB Database" {
  It "Should contain the Cosmos DB Account" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Cosmos DB Account in the location" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Cosmos DB Account in the correct Kind" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result.ResourceDetails.Kind | Should -Be "MongoDB"
  }

  It "Should contain the Cosmos DB Account PublicNetworkAccess enabled" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result.ResourceDetails.PublicNetworkAccess | Should -Be "Enabled"
  }
}

Describe "Comsos DB SQL Database" {
  It "Should contain the Cosmos DB Account" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Cosmos DB Account in the location" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Cosmos DB Account in the correct Kind" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result.ResourceDetails.Kind | Should -Be "GlobalDocumentDB"
  }

  It "Should contain the Cosmos DB Account PublicNetworkAccess enabled" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result.ResourceDetails.PublicNetworkAccess | Should -Be "Enabled"
  }
}
