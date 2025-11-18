using './main.bicep'

//Resource Group
param rgName  = 'rg-demo'
param location  = 'westeurope'
param tags  ={
  'ke-app-name' : 'test'
  'ke-app-business-unit' :'test'
  'ke-app-budget' : 'somevalue'
  'ke-app-department' : 'test'
  'ke-app-end-of-life-date' :'somedate'
  'ke-app-tech-contact' :'some_value'
  'ke-app-environment' : 'test'
  'ke-app-cost-owner' : 'test'
}

//Stoarge Account
param saName  = 'dstrgacct0112ed6b7hd5'
param containerName  = 'files'

//Virtual Network
param vnetName = 'vnet-demo'
param vnetAddressPrefix = '10.0.0.0/16'
param subnetName ='default'
param subnetPrefix = '10.0.0.0/24'

//Virtual Machine
param vmName = 'vm-demo-win'
param vmSize = 'Standard_B2s'
param adminUsername = 'azureadmin'
param adminPassword = 'P@ssw0rd123!Complex'
param osDiskType = 'Premium_LRS'


