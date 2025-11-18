param vnetName string
param location string
param addressPrefix string
param subnetName string
param subnetPrefix string
param tags object


resource vnet 'Microsoft.Network/virtualNetworks@2024-10-01'={
  name:vnetName
  location:location
  tags:tags
  properties:{
    addressSpace: {
      addressPrefixes:[
        addressPrefix
      ]
    }
    subnets:[
      {
        name:subnetName
        properties:{
          addressPrefix:subnetPrefix
        }
      }
    ]
  }
}


output vnetId string = vnet.id
output vnetName string = vnet.name
output subnetId string = vnet.properties.subnets[0].id
output subnetNae string = vnet.properties.subnets[0].name
