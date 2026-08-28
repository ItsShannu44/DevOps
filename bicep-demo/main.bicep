//Comment: Parameter: Azure Storage Account globally unique Name
@description('Name of the Azure Storage Account')
param storageAccountName string

//param: Location uses resourceGroup().location
@description('Azure region for the Storage Account')
param location string = resourceGroup().location

//param: pricing/replication - SKU(Locally  Redundant Storage.)
@description('Storage Account SKU')
param storageSku string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2026-04-01'={
  name: storageAccountName
  location: location
  sku:{
    name: storageSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
}

output storageAccountName string= storageAccount.name
output storageAccountId string= storageAccount.id
