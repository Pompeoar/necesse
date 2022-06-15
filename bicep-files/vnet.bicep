param location string = 'eastus2'
param vnetName string = 'vn-necesse'
param vnetSubnetName string = 'sn-necesse'
param publicIpAddressName string = 'ip-necesse'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: vnetSubnetName
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

resource symbolicname 'Microsoft.Network/publicIPAddresses@2021-08-01' = {
  name: publicIpAddressName
  location: location  
  sku: {
    name: 'Standard'    
  }  
  properties: {           
    ipAddress: '20.22.215.192'    
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'       
  }  
}
