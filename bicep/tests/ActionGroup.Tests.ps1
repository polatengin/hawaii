BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $actionGroupName = "aghawaii${env:buildId}"
  $location = "global"
  $emailReceiverAddress = "sampleactiongroup@contoso.com"

  # log
  Write-Host "Running Action Group Tests for {buildId: $env:buildId}, {rgName: $rgName}, {actionGroupName: $actionGroupName}, {location: $location}, {emailReceiverAddress: $emailReceiverAddress}"
}

Describe "Verify Action Group" {
  It "Should contain an Action Group named $actionGroupName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
    }
  
    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }
  
  It "Should contain an Action Group named $actionGroupName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
      PropertyKey       = "GroupShortName"
      PropertyValue     = $actionGroupName
    }
  
    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Action Group" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result | Should -Be -Not $null
  }

  It "Should contain the Action Group in the location" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.Location | Should -Be "$location"
  }

  It "Should contain the Action Group in the resource group" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.ResourceGroupName | Should -Be "$rgName"
  }

  It "Should contain the Action Group with one email receiver" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.EmailReceivers.Length | Should -Be 1
  }

  It "Should contain the Action Group with the correct email receiver" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.EmailReceivers[0].EmailAddress | Should -Be "$emailReceiverAddress"
  }

  It "Should contain the Action Group with the correct email receiver status enabled" {
    # act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    # assert
    $result.ResourceDetails.EmailReceivers[0].Status | Should -Be 1
  }
}
