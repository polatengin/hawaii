BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $gremlinAccountName = "gremlin-account-name"
  $gremlinDatabaseName = "gremlin-db-name"
  $mongoAccountName = "mongodb-account-name"
  $mongoDatabaseName = "mongodb-db-name"
  $sqlAccountName = "sql-account-name"
  $sqlDatabaseName = "sql-db-name"

  # log
  Write-Host "Running Cosmos DB Tests for {rgName: $rgName}, {location: $location}, {gremlinAccountName: $gremlinAccountName}, {gremlinDatabaseName: $gremlinDatabaseName}, {mongoAccountName: $mongoAccountName}, {mongoDatabaseName: $mongoDatabaseName}, {sqlAccountName: $sqlAccountName}, {sqlDatabaseName: $sqlDatabaseName}"
}

Describe "Cosmos DB Gremlin Database" {
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
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Cosmos DB Account in the resource group" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
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
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Cosmos DB Account in the resource group" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
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
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Cosmos DB Account in the resource group" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
