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

