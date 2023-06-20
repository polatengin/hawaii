using './main.bicep'

param location = 'westus'
param name = 'clstr-test'
param streamAnalyticsJobName = 'testjob'
param streamAnalyticsFunctionName = 'testfunction'
param streamAnalyticsInputName = 'testinput'
param streamAnalyticsOutputName = 'testoutput'
param streamAnalyticsTransformationName = 'testtransformation'
param numberOfStreamingUnits = 1
