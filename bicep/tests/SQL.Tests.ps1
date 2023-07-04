BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $serverName = "samplesqlserver"
  $noDatabaseName = "nosamplesqlserver"
  $databaseName = "samplesqldatabase"
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

  It "Should not contain the SQL Database named $noDatabaseName" {
    # arrange
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $noDatabaseName
      ServerName        = $serverName
      ErrorAction       = "SilentlyContinue"
    }

    # act and asssert
    Confirm-AzBPSqlDatabase @params | Should -Not -BeSuccessful
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
  BeforeAll {
    $noServerName = "nosamplesqlserver"
  }

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

  It "Should not contain the SQL Server named $noServerName" {
    # The "-ErrorAction SilentlyContinue" command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $noServerName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain the SQL Server named $serverName in the location" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInLocation $location
  }

  It "Should contain the SQL Server named $serverName in the resource group" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInResourceGroup $rgName
  }
}

