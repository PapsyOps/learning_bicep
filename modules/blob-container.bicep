param storageAccountName string
param containerName string

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' ={
  name: '${storageAccountName}/default/${containerName}'
}
