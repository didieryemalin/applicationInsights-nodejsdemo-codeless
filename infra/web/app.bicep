param environmentName string
param location string = resourceGroup().location
param appInsightsInstrumentationKey string
param appInsightsConnectionString string
param cosmosConnectionString string
param functionAppUrl string

module appserviceplan 'host/appserviceplan.bicep' = {
  name: 'appserviceplan'
  params: {
    environmentName: environmentName
    location: location
    kind: 'linux'
    reserved: true
    sku: {
      name: 'B1'
      tier: 'Basic'
    }
    purpose: 'todoapp'
  }
}

module appservice 'host/appservice.bicep' = {
  name: 'appservice'
  params: {
    environmentName: environmentName
    location: location
    appServicePlanId: appserviceplan.outputs.appServicePlanId
    runtimeName: 'node'
    runtimeVersion: '16-lts'
    purpose: 'todoapp'
    appInsightsConnectionString: appInsightsConnectionString
    appInsightsInstrumentationKey: appInsightsInstrumentationKey
    cosmosConnectionString: cosmosConnectionString
    functionAppUrl: functionAppUrl
  }
}

output todoAppURL string = appservice.outputs.uri
