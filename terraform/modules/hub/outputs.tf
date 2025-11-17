output "hub_vnet_id" {
  description = "The ID of the Hub Virtual Network"
  value       = azurerm_virtual_network.hub.id
  
}

output "firewall_subnet_id" {
  description = "The ID of the Firewall Subnet"
  value       = azurerm_subnet.firewall_subnet.id
}

output "hub_vnet_name" {
  description = "The name of the Hub Virtual Network"
  value       = azurerm_virtual_network.hub.name
}