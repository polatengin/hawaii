using './main.bicep'

param name = 'clstr-hawaii-${readEnvironmentVariable('buildId', '001')}'
param streamAnalyticsJobName = 'hawaiijob-${readEnvironmentVariable('buildId', '001')}'
param streamAnalyticsFunctionName = 'hawaiifunction'
param streamAnalyticsInputName = 'hawaiiinput'
param streamAnalyticsOutputName = 'hawaiioutput'
param streamAnalyticsTransformationName = 'hawaiitransformation'
param numberOfStreamingUnits = 1
param location = 'westus'
