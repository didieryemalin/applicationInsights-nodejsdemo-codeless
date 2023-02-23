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
    appSettings:{
      APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
      APPLICATIONINSIGHTS_CONNECTION_STRING: appInsightsConnectionString
      ApplicationInsightsAgent_EXTENSION_VERSION:'~3'
      WEBSITE_NODE_DEFAULT_VERSION:'~16'
      XDT_MicrosoftApplicationInsights_Mode:'recommended'
      XDT_MicrosoftApplicationInsights_NodeJS:'1'
      DATABASE_NAME:'todo-db'
      DATABASE_URL: cosmosConnectionString
      TASK_PROCESSOR_URL:'${functionAppUrl}/api/ProcessTasks?'
    }
  }
}
