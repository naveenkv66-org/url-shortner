param location string = resourceGroup().location
var uniqueId  = uniqueString(resourceGroup().id)

module keyvault './modules/secrets/keyvalut.bicep' = {
  name: 'keyvaultDeployment-${uniqueId}'
  params: {
    keyvaultName: 'kv-${uniqueId}'
    location: location
  }
}

module apiService './modules/compute/appservice.bicep' = {
  name: 'apiDeployment-${uniqueId}'
  params: {
    appName: 'api-${uniqueId}'
    appServicePlanName: 'plan-api-${uniqueId}'
    location: location
  }
}
