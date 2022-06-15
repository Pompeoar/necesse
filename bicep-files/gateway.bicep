param appGatewayName string = 'ag-necesse'
param location string = 'eastus2'
param vnetName string = 'vn-necesse'
param publicIpAddressName string = 'ip-necesse'
param containerGroupName string = 'aci-necesse'

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name: vnetName
}

resource publicIpAddress 'Microsoft.Network/publicIPAddresses@2021-08-01' existing = {
  name: publicIpAddressName
}

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2021-09-01' existing = {
  name: containerGroupName
}

resource agnecesse 'Microsoft.Network/applicationGateways@2021-08-01' = {
  name: appGatewayName
  location: location
  tags: {
  }
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/gatewayIPConfigurations/appGatewayIpConfig'
        properties: {
          subnet: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/virtualNetworks/vn-necesse/subnets/sn-ag-necesse'
          }
        }
      }
    ]
    sslCertificates: []
    trustedRootCertificates: []
    trustedClientCertificates: []
    sslProfiles: []
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/frontendIPConfigurations/appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/publicIPAddresses/ip-necesse'
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_14159'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/frontendPorts/port_14159'
        properties: {
          port: 14159
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'backend-pool-necesse'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/backendAddressPools/backend-pool-necesse'
        properties: {
          backendAddresses: [
            {
              ipAddress: '10.0.2.4'
            }
          ]
        }
      }
    ]
    loadDistributionPolicies: []
    backendHttpSettingsCollection: [
      {
        name: 'backend-settings-necesse'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/backendHttpSettingsCollection/backend-settings-necesse'
        properties: {
          port: 14159
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: 'listener-necesse'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/httpListeners/listener-necesse'
        properties: {
          frontendIPConfiguration: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/frontendPorts/port_14159'
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
        }
      }
    ]
    listeners: []
    urlPathMaps: []
    requestRoutingRules: [
      {
        name: 'routing-rule-necesse'
        id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/requestRoutingRules/routing-rule-necesse'
        properties: {
          ruleType: 'Basic'
          priority: 1
          httpListener: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/httpListeners/listener-necesse'
          }
          backendAddressPool: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/backendAddressPools/backend-pool-necesse'
          }
          backendHttpSettings: {
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/applicationGateways/ag-necesse/backendHttpSettingsCollection/backend-settings-necesse'
          }
        }
      }
    ]
    routingRules: []
    probes: []
    rewriteRuleSets: []
    redirectConfigurations: []
    privateLinkConfigurations: []
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 10
    }
  }
}
