﻿BeforeAll {
  Import-Module Az.InfrastructureTesting

  $principalId = 'sampleappid'
  $scope = '/subscriptions/id'
  $roleName = 'Reader'
  $noRoleName = 'Owner'
}

Describe 'Verify Role Assignment Exists' {
  It "Should contain the Service Principal with $roleName Role" {
    # arrange
    $params = @{
      ResourceType         = 'RoleAssignment'
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
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
      PropertyKey          = 'RoleDefinitionName'
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
