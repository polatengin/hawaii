BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $kvName = "kv-hawaii-${env:buildId}"
  $kvKeyName = "samplekey"
  $kvSecretName = "samplesecret"
  $kvAccessPolicyObjectId = "${env:AZ_SP_HAWAII_ID}"
  $location = "${env:location}"

  # log
  Write-Host "Running Key Vault Tests for {rgName: $rgName}, {location: $location}, {kvName: $kvName}, {kvKeyName: $kvKeyName}, {kvSecretName: $kvSecretName}, {kvAccessPolicyObjectId: $kvAccessPolicyObjectId}"
}

Describe "Verify Key Vault" {
  It "Should contain the Key Vault named $kvName" {
    # arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain the Key Vault with an Access Policy for $kvAccessPolicyObjectId" {
    #arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
      PropertyKey       = "AccessPolicies[0].ObjectId"
      PropertyValue     = $kvAccessPolicyObjectId
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Key Vault named $kvName" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeSuccessful
  }

  It "Should contain the Key named $kvKeyName in the Key Vault named $kvName" {
    Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName | Should -BeSuccessful
  }

  It "Should contain the Secret named $kvSecretName in the Key Vault named $kvName" {
    Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName | Should -BeSuccessful
  }

  It "Should contain the Key Vault named $kvName in the location" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeInLocation $location
  }

  It "Should contain the Key Vault named $kvName in the resource group" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeInResourceGroup $rgName
  }
}
