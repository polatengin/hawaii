BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $actionGroupName = "aghawaii${env:buildId}"
  $location = "global"

  Write-Host "Running Action Group Tests for {buildId: $env:buildId}, {rgName: $rgName}, {actionGroupName: $actionGroupName}, {location: $location}"
}

Describe "Verify Action Group" {
  It "Should contain an Action Group named $actionGroupName" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    Write-Host $result | ConvertTo-Json -Depth 100

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain an Action Group named $actionGroupName in $location" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result | Should -BeInLocation $location
  }

  It "Should contain an Action Group named $actionGroupName in $rgName" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result | Should -BeInResourceGroup $rgName
  }
}
