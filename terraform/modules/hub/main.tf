resource "azurerm_virtual_network" "hub" {
  name = var.hub_vnet_name
    address_space       = var.hub_address_space
    location            = var.location
    resource_group_name = var.resource_group_name
    tags                = var.tags
}

# Hub Subnets
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.firewall_subnet_prefix
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.bastion_subnet_prefix
  
}