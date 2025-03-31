
param appServicePlanName string 
param location string = resourceGroup().location
param appName string
param keyVaultName string

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  kind:'linux'
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1' 
  }
  properties: {
    reserved: true
  }
}



resource webApp 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings:[
        {name:'KeyVaultName'
         value: keyVaultName}
      ]
    }
  }
  
}

resource webAppConfig 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: webApp
  name: 'web'
  properties:{scmType: 'GitHub'}
}

output appServiceId string = webApp.id
output appServiceName string = webApp.name
output appServicePlanId string = appServicePlan.id
