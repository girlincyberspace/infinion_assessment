resource "azurerm_public_ip" "fw-pip" {
  name = "pip-${var.firewall_name}"
    location = var.location
    resource_group_name = var.resource_group_name
    allocation_method = "Static"
    sku = "Standard"
    tags = var.tags
}

resource "azurerm_firewall" "hub" {
    name                = var.firewall_name
    location            = var.location
    resource_group_name = var.resource_group_name
    sku_name          = "AZFW_VNet"
    sku_tier = "Standard"
    tags = var.tags
    
    ip_configuration {
        name                 = "fw-ip-config"
        subnet_id            = var.firewall_subnet_id
        public_ip_address_id = azurerm_public_ip.fw-pip.id
    }
    
}

resource "azurerm_firewall_network_rule_collection" "allow_spoke_to_spoke" {
  name                = "allow-spoke-to-spoke"
  azure_firewall_name = azurerm_firewall.hub.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "allow-spoke-to-spoke-rule"
    protocols              = ["Any"]
    source_addresses      = var.spoke_address_spaces
    destination_addresses = var.spoke_address_spaces
    destination_ports     = ["*"]
  }
  
}

resource "azurerm_firewall_application_rule_collection" "allow_internet" {
  name                = "allow-internet"
  azure_firewall_name = azurerm_firewall.hub.name
  resource_group_name = var.resource_group_name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "allow-internet-rule"
    protocol {
        type = "Http"
        port = 80
    }
    protocol {
        type = "Https"
        port = 443
    }
    source_addresses      = var.spoke_address_spaces
    target_fqdns = ["*.microsoft.com", "*.google.com"]
  }

}