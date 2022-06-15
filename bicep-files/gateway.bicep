
resource appcontainerdelete 'Microsoft.ContainerInstance/containerGroups@2021-10-01' = {
  properties: {
    sku: 'Standard'
    containers: [
      {
        name: 'appcontainer-delete'
        properties: {
          image: 'mcr.microsoft.com/azuredocs/aci-helloworld'
          ports: [
            {
              protocol: 'TCP'
              port: 80
            }
          ]
          environmentVariables: []
          resources: {
            requests: {
              memoryInGB: '1.5'
              cpu: '1.0'
            }
          }
        }
      }
    ]
    initContainers: []
    restartPolicy: 'Always'
    ipAddress: {
      ports: [
        {
          protocol: 'TCP'
          port: 80
        }
      ]
      type: 'Private'
    }
    osType: 'Linux'
    subnetIds: [
      {
        id: '/subscriptions/e7caf91e-c10d-47b0-b910-ff9cb3c1a400/resourceGroups/rg-necesse/providers/Microsoft.Network/virtualNetworks/myVNet/subnets/myACISubnet'
      }
    ]
  }
  name: 'appcontainer-delete'
  location: 'eastus'
  tags: {
  }
}
