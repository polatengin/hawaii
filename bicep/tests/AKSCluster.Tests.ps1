BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $aksName = "aks-hawaii-${env:buildId}"
  $location = "${env:location}"
  $nodePoolName = "aphawaii"

  # log
  Write-Host "Running AKS Cluster Tests for {buildId: $env:buildId}, {rgName: $rgName}, {aksName: $aksName}, {nodePoolName: $nodePoolName}, {location: $location}"
}

Describe "Verify AKS Cluster" {
  It "Should contain an AKS Cluster named $aksName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName with an Agent Pool Profile named agentpool - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].Name"
      PropertyValue     = "agentpool"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName with an Agent Pool Profile named agentpool - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].OSSku"
      PropertyValue     = "Ubuntu"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName with an Agent Pool Profile named agentpool - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].PowerState.Code"
      PropertyValue     = "Running"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName with an Agent Pool Profile named agentpool - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].VMSize"
      PropertyValue     = "Standard_B4ms"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName with an Agent Pool Profile named agentpool - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "EnableRbac"
      PropertyValue     = $true
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the AKS Cluster" {
    # act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the AKS Cluster in the location" {
    # act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the AKS Cluster in the resource group" {
    # act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}

Describe "Verify AKS Node Pool" {
  It "Should contain an AKS Node Pool named $nodePoolName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksNodePool"
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      ResourceName      = $nodePoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS NodePool named $nodePoolName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksNodePool"
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      ResourceName      = $nodePoolName
      PropertyKey       = "Name"
      PropertyValue     = $nodePoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the AKS Node Pool" {
    # act
    $result = Confirm-AzBPAksNodePool -ResourceGroupName $rgName -ClusterName $aksName -Name $nodePoolName

    # assert
    $result | Should -Be -Not $null
  }
}
