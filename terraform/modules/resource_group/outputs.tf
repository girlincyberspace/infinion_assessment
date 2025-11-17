output "resource_group_name" {
  description = "The name of the created Resource Group."
  value       = azurerm_resource_group.hub_spoke.name
}

output "location" {
  description = "The Azure region where the Resource Group is located."
  value       = azurerm_resource_group.hub_spoke.location
}

output "tags" {
  description = "The tags associated with the Resource Group."
  value       = azurerm_resource_group.hub_spoke.tags
}