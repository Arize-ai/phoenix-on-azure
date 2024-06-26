param name string
param location string = resourceGroup().location
param tags object = {}

param sku object
param storage object
param administratorLogin string
@secure()
param administratorLoginPassword string
param databaseNames array = [
  'phoenix'
]
param allowedSingleIPs array = []
param allowAzureIPsFirewall bool = false

// PostgreSQL version
param version string

// Latest official version 2022-12-01 does not have Bicep types available
resource postgresServer 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  location: location
  tags: tags
  name: name
  sku: sku
  properties: {
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    storage: storage
    highAvailability: {
      mode: 'Disabled'
    }
  }

  resource database 'databases' = [
    for name in databaseNames: {
      name: name
    }
  ]

  resource firewall_azure 'firewallRules' =
    if (allowAzureIPsFirewall) {
      name: 'allow-all-azure-internal-IPs'
      properties: {
        startIpAddress: '0.0.0.0'
        endIpAddress: '0.0.0.0'
      }
    }

  resource firewall_single 'firewallRules' = [
    for ip in allowedSingleIPs: {
      name: 'allow-single-${replace(ip, '.', '')}'
      properties: {
        startIpAddress: ip
        endIpAddress: ip
      }
    }
  ]
}

output fqdn string = postgresServer.properties.fullyQualifiedDomainName
