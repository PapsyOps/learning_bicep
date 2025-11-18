param vmName string
param location string
param vmSize string
param adminUsername string
@secure ()
param adminPassword string
param tags object ={}
param osDiskType string 
param subnetId string

// Network Interface

resource nic 'Microsoft.Network/networkInterfaces@2024-10-01' ={
  name : '${vmName}-nic'
  location : location
  tags : tags
  properties:{
    ipConfigurations:[
      {
        name: 'ipconfig1'
        properties:{
          subnet:{
            id:subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

//Virtual Machine

resource vm 'Microsoft.Compute/virtualMachines@2025-04-01'={
  name:vmName
  location:location
  tags:tags
  properties:{
    hardwareProfile :{
      vmSize:vmSize
    }
    storageProfile:{
      imageReference:{
        publisher:'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku:'2022-datacentre-azure-edition'
        version:'latest'
      }
      osDisk:{
        createOption:'FromImage'
        managedDisk:{
          storageAccountType:osDiskType
        }
        diskSizeGB:127
      }
    }
    osProfile:{
      computerName: vmName
      adminUsername: adminUsername
      adminPassword:adminPassword
      windowsConfiguration:{
        enableAutomaticUpdates:true
        provisionVMAgent:true
        patchSettings:{
          patchMode:'AutomaticByPlatform'
          automaticByPlatformSettings:{
            rebootSetting:'IfRequired'
          }
        }
      }
    }
    networkProfile:{
      networkInterfaces:[
        {
          id:nic.id
          properties:{
            primary:true
          }
        }
      ]
    }
  }
}


output vmId string = vm.id
output vmName string = vm.name
output privateIP string = nic.properties.ipConfigurations[0].properties.privateIPAddress
