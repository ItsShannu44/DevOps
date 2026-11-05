@description('Name of the Azure Key Vault')
param KeyVaultName string

@description('Name of the User Assigned Managed Idebtity')
param identityName string

@description('Azure deployment location')
param location string = resourceGroup().location

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' ={
    name: KeyVaultName
    location: location

    properties:{
        enableRbacAuthorization: true
        tenantId: subscription().tenantId
        sku:{
            name: 'standard'
            family: 'A'
        }

        enableSoftDelete: true
        softDeleteRetentionInDays: 7
        publicNetworkAccess: 'Enabled'
    }
}

resource manageIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31'={
    name: identityName
    location: location
}

resource keyVaultSecretUserRole 'Microsoft.Authorization/roleAssignments@2022-04-01'={
    scope: keyVault
    name: guid(
        keyVault.id, manageIdentity.id, 'KeyVaultSecretUser'
    )

    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')
        principalId: manageIdentity.properties.principalId
        principalType: 'ServicePrincipal'
    }
}

//Outputs
output keyValueName string = keyVault.name
output keyVauktUri string = keyVault.properties.vaultUri
output managedIdentityName string = manageIdentity.name
output managedIdentityPrincipalId string = manageIdentity.properties.principalId
