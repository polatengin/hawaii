using './main.bicep'

param name = 'clstr-test-${readEnvironmentVariable('buildId', '001')}'
param streamAnalyticsJobName = 'testjob-${readEnvironmentVariable('buildId', '001')}'
param streamAnalyticsFunctionName = 'testfunction'
param streamAnalyticsInputName = 'testinput'
param streamAnalyticsOutputName = 'testoutput'
param streamAnalyticsTransformationName = 'testtransformation'
param numberOfStreamingUnits = 1
param location = 'westus'
