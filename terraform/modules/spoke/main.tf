resource "azurerm_virtual_network" "spoke" {
  name = var.spoke_vnet_name
  address_space = var.spoke_address_space
    location = var.location
    resource_group_name = var.resource_group_name
    tags = var.tags
}

resource "azurerm_subnet" "workload" {
  name                 = "workload-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.workload_subnet_address_prefixes
  
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
    name                      = "${var.spoke_vnet_name}-to-${var.hub_vnet_name}-peering"
    resource_group_name       = var.resource_group_name
    virtual_network_name      = azurerm_virtual_network.spoke.name
    remote_virtual_network_id = var.hub_vnet_id
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    use_remote_gateways = false
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
    name                      = "${var.hub_vnet_name}-to-${var.spoke_vnet_name}-peering"
    resource_group_name       = var.resource_group_name
    virtual_network_name      = var.hub_vnet_name
    remote_virtual_network_id = azurerm_virtual_network.spoke.id
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit = true
}

resource "azurerm_route_table" "spoke" {
    name                = "${var.spoke_vnet_name}-route-table"
    location            = var.location
    resource_group_name = var.resource_group_name
    tags                = var.tags
}

resource "azurerm_route" "to_remote_spoke" {
    name                = "route-to-remote-spoke"
    resource_group_name = var.resource_group_name
    route_table_name    = azurerm_route_table.spoke.name
    address_prefix      = var.remote_spoke_address_space[0]
    next_hop_type       = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_route" "to_internet" {
    name                = "route-to-internet"
    resource_group_name = var.resource_group_name
    route_table_name    = azurerm_route_table.spoke.name
    address_prefix      = "0.0.0.0/0"
    next_hop_type       = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  
}

resource "azurerm_subnet_route_table_association" "workload" {
    subnet_id      = azurerm_subnet.workload.id
    route_table_id = azurerm_route_table.spoke.id
}


