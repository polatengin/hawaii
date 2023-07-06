BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $aksName  = "aks-hawaii-${env:buildId}"
  $location = "${env:location}"
  $nodePoolName   = "nodepoolbenchpresstest"

  # log
  Write-Host "Running AKS Cluster Tests for {buildId: $env:buildId}, {rgName: $rgName}, {aksName: $aksName}, {nodePoolName: $nodePoolName}, {location: $location}"
}

Describe "Verify AKS Cluster" {
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
  It "Should contain the AKS Node Pool" {
    # act
    $result = Confirm-AzBPAksNodePool -ResourceGroupName $rgName -ClusterName $aksName -Name $nodePoolName

    # assert
    $result | Should -Be -Not $null
  }
}
