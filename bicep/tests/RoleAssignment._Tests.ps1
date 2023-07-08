BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $principalId = "sampleappid"
  $scope = "/subscriptions/id"
  $roleName = "Reader"
  $noRoleName = "Contributor"

  # log
  Write-Host "Running Role Assignment Tests for {principalId: $principalId}, {scope: $scope}, {roleName: $roleName}, {noRoleName: $noRoleName}"
}

Describe "Verify Role Assignment Exists" {
  It "Should contain the Service Principal with $roleName Role" {
    # arrange
    $params = @{
      ResourceType         = "RoleAssignment"
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Service Principal with $roleName Role" {
    # arrange
    $params = @{
      ResourceType         = "RoleAssignment"
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
      PropertyKey          = "RoleDefinitionName"
      PropertyValue        = $roleName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should not contain the Service Principal with $noRoleName Role" {
    # arrange
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $noRoleName
      Scope                = $scope
    }

    # act and assert
    Confirm-AzBPRoleAssignment @params | Should -Not -BeSuccessful
  }

}
