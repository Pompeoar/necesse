@description('Name for the container group')
param name string = 'aci-necesse'

@description('Location for resource.')
param location string = resourceGroup().location

@description('Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials.')
param image string = 'pixil/necesse'

@description('Port to open on the container and the public IP address.')
param port int = 14159

@description('The number of CPU cores to allocate to the container.')
param cpuCores int = 1

@description('The amount of memory to allocate to the container in gigabytes.')
param memoryInGb int = 2

@description('The behavior of Azure runtime if container has stopped.')
@allowed([
  'Always'
  'Never'
  'OnFailure'
])
param restartPolicy string = 'Always'

var storage_name = 'necesse${uniqueString(resourceGroup().id)}'

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: storage_name
}

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2021-09-01' = {
  name: name
  location: location
  properties: {
    containers: [
      {
        name: name
        properties: {
          image: image
          ports: [
            {
              port: port
              protocol: 'UDP'
            }
          ]
          resources: {
            requests: {
              cpu: cpuCores
              memoryInGB: memoryInGb
            }
          }
          volumeMounts: [
            {
              mountPath: '/config'
              name: 'config'
              readOnly: false
            }
          ]        
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: restartPolicy
    ipAddress: {
      type: 'private'
      ports: [
        {
          port: port
          protocol: 'UDP'
        }
      ]
      ip:'10.0.2.4'
    }
    volumes: [
      {
        azureFile: {
          readOnly: false
          shareName: 'config'
          storageAccountName: storage.name
          storageAccountKey: storage.listKeys().keys[0].value
        }
        name: 'config'
      }
    ]
  }
}
