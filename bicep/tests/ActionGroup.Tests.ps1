BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = "rg-hawaii-${env:buildId}"
  $actionGroupName = "aghawaii${env:buildId}"
  $location = "global"

  Write-Host "Running Action Group Tests for {buildId: $env:buildId}, {rgName: $rgName}, {actionGroupName: $actionGroupName}, {location: $location}"
}

Describe "Verify Action Group" {
  It "Should contain an Action Group named $actionGroupName" {
    param($actionGroupName)

    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    Write-Host ($result.ResourceDetails | ConvertTo-Json -Depth 100)

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain an Action Group named '{0}' in '{1}'" -TestCases $actionGroupName,$location {
    param($actionGroupName, $location)

    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain an Action Group named $actionGroupName in $rgName" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }
}
