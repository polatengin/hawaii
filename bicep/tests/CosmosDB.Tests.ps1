BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $gremlinAccountName = "gremlin-account-name"
  $gremlinDatabaseName = "gremlin-db-name"
  $mongoAccountName = "mongodb-account-name"
  $mongoDatabaseName = "mongodb-db-name"
  $sqlAccountName = "sql-account-name"
  $sqlDatabaseName = "sql-db-name"
  $sqlRoleAssignmentId = "sql-role-assignment-id"
  $sqlRoleDefinitionId = "sql-role-definition-id"
}

Describe "Cosmos DB Gremlin Database" {
  It "Should contain the Cosmos DB Account named $gremlinAccountName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName
  }

  It "Should contain the Cosmos DB Account named $gremlinAccountName in the location" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName
  }

  It "Should contain the Cosmos DB Account named $gremlinAccountName in the resource group" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName
   
  }

  It "Should contain the Cosmos DB Gremlin Database named $gremlinDatabaseName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBGremlinDatabase @params
  }

  It "Should not contain the Cosmos DB Gremlin Database named $noGremlinDBName" {
    # The "ErrorAction = SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $noGremlinDBName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBGremlinDatabase @params
  }

  It "Should contain the Cosmos DB Gremlin Database named $gremlinDatabaseName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBGremlinDatabase @params
  }
}

Describe "Comsos DB Mongo DB Database" {
  BeforeAll {
    $noMongoDBAccountName = "nomdbbenchpresstest"
    $noMongoDBName = "nomdatabasebenchpresstest"
  }

  It "Should contain the Cosmos DB Account named $mongoAccountName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName
  }

  It "Should not contain the Cosmos DB Account named $noMongoDBAccountName" {
    # arrange
    # The "ErrorAction = SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noMongoDBAccountName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBAccount @params
  }

  It "Should contain the Cosmos DB Account named $mongoAccountName in the location" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName
  }

  It "Should contain the Cosmos DB Account named $mongoAccountName in the resource group" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName
  }

#######################################################################################################################

  It "Should contain the Cosmos DB Mongo DB Database named $mongoDatabaseName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBMongoDBDatabase @params
  }

  It "Should not contain the Cosmos DB Mongo DB Database named $noMongoDBName" {
    # arrange
    # The "ErrorAction = SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $noMongoDBName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBMongoDBDatabase @params
  }

  It "Should contain the Cosmos DB Mongo DB Database named $mongoDatabaseName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBMongoDBDatabase @params
  }
}

Describe "Comsos DB SQL Database" {
  BeforeAll {
    $noSqlAccountName = "nosqlbenchpresstest"
    $noSqlDatabaseName = "nosqldatabasebenchpresstest"
  }

  It "Should contain the Cosmos DB Account named $sqlAccountName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName
  }

  It "Should not contain the Cosmos DB Account named $noSqlAccountName" {
    # arrange
    # The "ErrorAction = SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noSqlAccountName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBAccount @params
  }

  It "Should contain the Cosmos DB Account named $sqlAccountName in the location" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName
  }

  It "Should contain the Cosmos DB Account named $sqlAccountName in the resource group" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName
  }

#######################################################################################################################

  It "Should contain the Cosmos DB SQL Database named $sqlDatabaseName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlDatabase @params
  }

  It "Should not contain the Cosmos DB SQL Database named $noSqlDatabaseName" {
    # arrange
    # The "ErrorAction = SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $noSqlDatabaseName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlDatabase @params
  }

  It "Should contain the Cosmos DB SQL Database named $sqlDatabaseName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlDatabase @params
  }
}

Describe "Comsos DB SQL Role Assignment" {
  BeforeAll {
    $noSqlRoleAssignmentId = "nosqlroleassignmentbptest"
  }

  It "Should contain the Cosmos DB SQL Role assignment named $sqlRoleAssignmentId" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $sqlRoleAssignmentId
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleAssignment @params
  }

  It "Should not contain the Cosmos DB SQL Role assignment named $noSqlRoleAssignmentId" {
    # arrange
    # The "ErrorAction = SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $noSqlRoleAssignmentId
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleAssignment @params
  }

  It "Should contain the Cosmos DB SQL Role assignment named $sqlRoleAssignmentId in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $sqlRoleAssignmentId
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleAssignment @params
  }
}
