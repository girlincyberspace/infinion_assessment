output "spoke_vnet_id" {
  description = "The ID of the spoke virtual network."
  value       = azurerm_virtual_network.spoke.id
}

output "workload_subnet_id" {
  description = "The ID of the workload subnet."
  value       = azurerm_subnet.workload.id
}

output "spoke_route_table_id" {
  description = "The ID of the spoke route table."
  value       = azurerm_route_table.spoke.id
}

output "vnet_cidr" {
  description = "The CIDR block of the spoke virtual network."
  value       = tolist(azurerm_virtual_network.spoke.address_space)[0]
  
}