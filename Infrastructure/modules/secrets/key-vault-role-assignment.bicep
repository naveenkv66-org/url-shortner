param keyvaultName string
param principalids array
param principalType string

param roleDefentionId string = 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7' //roledef id is predefined ids from azure based on role
resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyvaultName
}

resource kevualtRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = [for principalid in principalids: {
  name: guid(keyvault.id, principalid, roleDefentionId)
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefentionId)
    principalId: principalid
    principalType:principalType
  }
}]
