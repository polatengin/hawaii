BeforeAll {
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
  It "Should contain the Cosmos DB Account" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    Write-Host ($result | ConvertTo-Json -Depth 100)

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Cosmos DB Account in the location" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Cosmos DB Account in the resource group" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    # assert
    $result.ResourceDetails.ResourceGroup | Should -Be "$rgName"
  }
}

Describe "Comsos DB Mongo DB Database" {
  It "Should contain the Cosmos DB Account" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    Write-Host ($result | ConvertTo-Json -Depth 100)

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Cosmos DB Account in the location" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Cosmos DB Account in the resource group" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    # assert
    $result.ResourceDetails.ResourceGroup | Should -Be "$rgName"
  }
}

Describe "Comsos DB SQL Database" {
  It "Should contain the Cosmos DB Account" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    Write-Host ($result | ConvertTo-Json -Depth 100)

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Cosmos DB Account in the location" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result.ResourceDetails.Location | Should -Be "West US"
  }

  It "Should contain the Cosmos DB Account in the resource group" {
    # act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    # assert
    $result.ResourceDetails.ResourceGroup | Should -Be "$rgName"
  }
}
