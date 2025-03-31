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
    keyVaultName: keyvault.outputs.keyvaultName
  }
  dependsOn: [
    keyvault
  ]
}

module keyvaultRoleAssignment './modules/secrets/key-vault-role-assignment.bicep' = {
  name: 'keyvaultRoleAssignment-${uniqueId}'
  params: {
    keyvaultName: keyvault.outputs.keyvaultName
    principalids: [
      apiService.outputs.appServiceId
    ]
    principalType: 'ServicePrincipal'
  }
  dependsOn: [
    keyvault
    apiService
  ]
}
