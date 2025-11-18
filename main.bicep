targetScope = 'subscription'

param rgName string
param location string
param saName string
param containerName string
param tags object

module rg './modules/resource-group.bicep' = {
  name: 'rgModule'
  scope: subscription()
  params: {
    name: rgName
    location: location
    tags: tags  // <- Now it works
  }
}

module storage './modules/storage-account.bicep'={
  name:'saModule'
  scope:resourceGroup(rgName)
  params: {
    name: saName
    location : location
  }
}

module container './modules/blob-container.bicep'={
  name : 'containerModule'
  scope: resourceGroup(rgName)
  params:{
    storageAccountName: saName
    containerName: containerName
  }
}
