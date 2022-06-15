param location string = resourceGroup().location

var storage_name = 'necesse${uniqueString(resourceGroup().id)}'

resource necesseStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
