param environmentName string
param location string = resourceGroup().location
param principalId string = ''


// Monitor application with Application Insights and Log Analytics as workspace
module monitoring 'monitor/monitoring.bicep' = {
  name: 'monitoring'
  params:{
    environmentName: environmentName
    location: location
  }
}

// Cosmos Mongo ToDo Database
module cosmos 'db/db.bicep' = {
  name: 'cosmos'
  params:{
    environmentName:environmentName
    location: location
  }
}

