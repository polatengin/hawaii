BeforeAll {
  Import-Module BenchPress.Azure

  # arrange
  $rgName = "rg-hawaii-${env:buildId}"
  $location = "${env:location}"
  $nameSpaceName = "evnthbnmspace-hawaii-${env:buildId}"
  $eventHubName = "evnthb-hawaii-${env:buildId}"
  $consumerGroupName = "evntconsumer-hawaii-${env:buildId}"

  # log
  Write-Host "Running Event Hub Tests for {rgName: $rgName}, {nameSpaceName: $nameSpaceName}, {eventHubName: $eventHubName}, {consumerGroupName: $consumerGroupName}, {location: $location}"
}

Describe "Verify Event Hub" {
  It "Should contain the Event Hub named $eventHubName" {
    # arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub named $eventHubName" {
    # arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpaceName
      PropertyKey       = "Name"
      PropertyValue     = $eventHubName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub named $eventHubName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    # act and assert
    Confirm-AzBPEventHub @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub named $eventHubName in the location" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    # act and assert
    Confirm-AzBPEventHub @params | Should -BeInLocation $location
  }

  It "Should contain the Event Hub named $eventHubName in  $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    # act and assert
    Confirm-AzBPEventHub @params | Should -BeInResourceGroup $rgName
  }
}

Describe "Verify Event Hub Namespace" {
  It "Should contain the Event Hub Namespace named $nameSpaceName" {
    # arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub Namespace named $nameSpaceName" {
    # arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpaceName
      PropertyKey       = "Name"
      PropertyValue     = $nameSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub Namespace named $nameSpaceName" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeSuccessful
  }

  It "Should contain the Event Hub Namespace named $nameSpaceName in the location" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeInLocation $location
  }

  It "Should contain the Event Hub Namespace named $nameSpaceName in the resource group" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeInResourceGroup $rgName
  }
}

Describe "Verify Event Hub Consumer Group" {
  It "Should contain the Event Hub Consumer Group named $consumerGroupName" {
    # arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroupName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub Consumer Group named $consumerGroupName" {
    # arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroupName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      PropertyKey       = "Name"
      PropertyValue     = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub Consumer Group named $consumerGroupName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeSuccessful
  }

  It "Should contain the Event Hub Consumer Group named $consumerGroupName in the location" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeInLocation $location
  }

  It "Should contain the Event Hub Consumer Group named $consumerGroupName in the resource group" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeInResourceGroup $rgName
  }
}
