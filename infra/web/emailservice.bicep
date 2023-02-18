param environmentName string
param location string = resourceGroup().location

module appserviceplan 'appserviceplan.bicep' = {
  name: 'appserviceplan'
  params: {
    environmentName: environmentName
    location: location
    purpose: 'func'
    kind: 'functionapp'
    sku: {
      name: 'Y1'
      tier: 'Dynamic'
      size: 'Y1'
      family: 'Y'
      capacity: 0
    }
  }
}

module functionapp 'functionapp.bicep' = {
  name: 'functionapp'
  params: {

  }
}

output appServicePlanId string = appserviceplan.outputs.appServicePlanId
