targetScope = 'subscription'

param rgName string
param location string
param saName string
param containerName string
param tags object
param vnetName string
param vnetAddressPrefix string
param subnetName string
param subnetPrefix string
param vmName string
param vmSize string
param adminUsername string
@secure()
param adminPassword string
param osDiskType string

//Resource Group Module
module rg './modules/resource-group.bicep' = {
  name: 'rgModule'
  scope: subscription()
  params: {
    name: rgName
    location: location
    tags: tags  // <- Now it works
  }
}

//Virtual Network Module
module vnet './modules/virtual-network.bicep'= {
  name: 'vnetModule'
  scope:resourceGroup(rgName)
  dependsOn:[
    rg
  ]
  params:{
    vnetName: vnetName
    location: location
    addressPrefix: vnetAddressPrefix
    subnetName:subnetName
    subnetPrefix:subnetPrefix
    tags:tags
  }
}

//Storage Account Module
module storage './modules/storage-account.bicep'={
  name:'saModule'
  scope:resourceGroup(rgName)
  params: {
    name: saName
    location : location
  }
}

//Blob Container Module
module container './modules/blob-container.bicep'={
  name : 'containerModule'
  scope: resourceGroup(rgName)
  params:{
    storageAccountName: saName
    containerName: containerName
  }
}

//Virtual Machine Module
module vm './modules/virtual-machine.bicep' ={
  name : 'vmModule'
  scope:resourceGroup(rgName)
  dependsOn:[
    vnet
  ]
  params:{
    vmName:vmName
    location:location
    vmSize:vmSize
    adminUsername:adminUsername
    adminPassword:adminPassword
    subnetId:vnet.outputs.subnetId
    osDiskType:osDiskType
    tags:tags
  }
}

//Outputs
output resourceGroupName string = rg.outputs.resourceGroupName
output vnetName string = vnet.outputs.vnetName
output vmName string = vm.outputs.vmName
output vmPrivateIP string = vm.outputs.privateIP
