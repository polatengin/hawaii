BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $serverName = "sqlsvr-hawaii-${env:buildId}"
  $databaseName = "sqldb-hawaii-${env:buildId}"

  # log
  Write-Host "Running SQL Tests for {rgName: $rgName}, {location: $location}, {serverName: $serverName}, {databaseName: $databaseName}"
}

Describe "Verify SQL Database" {
  It "Should contain the SQL Database named $databaseName" {
    # arrange
    $params = @{
      ResourceType      = "SqlDatabase"
      ResourceName      = $databaseName
      ResourceGroupName = $rgName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain the SQL Database named $databaseName" {
    # arrange
    $params = @{
      ResourceType      = "SqlDatabase"
      ResourceName      = $databaseName
      ResourceGroupName = $rgName
      ServerName        = $serverName
      PropertyKey       = "DatabaseName"
      PropertyValue     = $databaseName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the SQL Database named $databaseName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $databaseName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPSqlDatabase @params | Should -BeSuccessful
  }

  It "Should contain the SQL Database named $databaseName in the location" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $databaseName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPSqlDatabase @params | Should -BeInLocation $location
  }

  It "Should contain the SQL Database named $databaseName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $databaseName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPSqlDatabase @params | Should -BeInResourceGroup $rgName
  }
}

Describe "Verify SQL Server" {
  It "Should contain the SQL Server named $serverName" {
    # arrange
    $params = @{
      ResourceType      = "SqlServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain the SQL Server named $serverName" {
    # arrange
    $params = @{
      ResourceType      = "SqlServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
      PropertyKey       = "ServerName"
      PropertyValue     = $serverName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the SQL Server named $serverName" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeSuccessful
  }

  It "Should contain the SQL Server named $serverName in the location" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInLocation $location
  }

  It "Should contain the SQL Server named $serverName in the resource group" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInResourceGroup $rgName
  }
}
