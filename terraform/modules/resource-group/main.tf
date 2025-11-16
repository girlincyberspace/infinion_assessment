resource "azurerm_resource_group" "hub_spoke" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}