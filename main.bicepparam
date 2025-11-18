using './main.bicep'

param rgName  = 'rg-demo'
param location  = 'westeurope'
param saName  = 'dstrgacct0112ed6b7hd5'
param containerName  = 'files'
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


