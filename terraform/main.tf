terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }

  required_version = ">=1.9.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_public_ip" "fw_pip" {
  name                = "pip-fw"
  location            = azurerm_resource_group.hub_spoke.location
  resource_group_name = azurerm_resource_group.hub_spoke.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_firewall" "hub" {
  name                = "fw-hub"
  location            = azurerm_resource_group.hub_spoke.location
  resource_group_name = azurerm_resource_group.hub_spoke.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  tags                = var.tags

  ip_configuration {
    name                 = "fw-ip-config"
    subnet_id            = module.hub.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }

  depends_on = [module.hub]
}