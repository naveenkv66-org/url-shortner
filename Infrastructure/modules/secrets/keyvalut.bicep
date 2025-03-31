param keyvaultName string
param location string = resourceGroup().location




resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyvaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
   
  }
}

output keyvaultId string = keyvault.id
output keyvaultName string = keyvault.name
