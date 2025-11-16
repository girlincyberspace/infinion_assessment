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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "resource_group" {
  source              = "./modules/resource_group"
  name = "hub-spoke-rg"
  location          = "eastus"
  tags = {
    environment = "production"
    project     = "hub-spoke-network"
  }
}

module "hub" {
  source              = "./modules/hub"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  hub_vnet_name = "vnet-hub"
  hub_address_space   = ["1.0.0.0/16"]
  firewall_subnet_prefix = ["1.0.0.0/24"]
  tags                = module.resource_group.tags
}

module "firewall" {
  source              = "./modules/firewall"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  firewall_name      = "hub-firewall"
  firewall_subnet_id = module.hub.firewall_subnet_id
  tags                = module.resource_group.tags

  spoke_address_spaces = [
    local.spoke1_cidr,
    local.spoke2_cidr
  ]

}

module "spoke1" {
  source              = "./modules/spoke"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  spoke_vnet_name     = "vnet-spoke1"
  spoke_address_space = ["10.1.0.0/16"]
  workload_subnet_address_prefixes = ["10.1.10.0/24"]
  hub_vnet_id         = module.hub.hub_vnet_id
  hub_vnet_name = module.hub.hub_vnet_name
  firewall_private_ip = module.firewall.firewall_private_ip
  remote_spoke_address_space = ["10.2.0.0/16"]
  tags                = module.resource_group.tags
  
}

module "spoke2" {
  source              = "./modules/spoke"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  spoke_vnet_name     = "vnet-spoke2"
  spoke_address_space = ["10.2.0.0/16"]
  workload_subnet_address_prefixes = ["10.2.10.0/24"]
  hub_vnet_id         = module.hub.hub_vnet_id
  hub_vnet_name       = module.hub.hub_vnet_name
  firewall_private_ip = module.firewall.firewall_private_ip
  remote_spoke_address_space = ["10.1.0.0/16"]
  tags                = module.resource_group.tags

}

module "spoke_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  nsg_name            = "spoke-workload-nsg"
  tags                = module.resource_group.tags

  nsg_rules = {
    allow_inbound_ssh = {
      name                        = "allow-inbound-ssh"
      priority                    = 110
      direction                   = "Inbound"
      access                      = "Allow"
      protocol                    = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "22"
      source_address_prefix       = "VirtualNetwork"
      destination_address_prefix  = "VirtualNetwork"
    }

    allow_inbound_icmp = {
      name                        = "allow-inbound-icmp"
      priority                    = 120
      direction                   = "Inbound"
      access                      = "Allow"
      protocol                    = "Icmp"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "VirtualNetwork"
      destination_address_prefix  = "VirtualNetwork"
    }

    allow_outbound_internet = {
      name                        = "allow-outbound-internet"
      priority                    = 130
      direction                   = "Outbound"
      access                      = "Allow"
      protocol                    = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "80,443"
      source_address_prefix       = "VirtualNetwork"
      destination_address_prefix  = "Internet"
  }
}
}

resource "azurerm_subnet_network_security_group_association" "spoke1_workload_subnet_nsg_assoc" {
  subnet_id                 = module.spoke1.workload_subnet_id
  network_security_group_id = module.spoke_nsg.nsg_id
  
}

resource "azurerm_subnet_network_security_group_association" "spoke2_workload_subnet_nsg_assoc" {
  subnet_id                 = module.spoke2.workload_subnet_id
  network_security_group_id = module.spoke_nsg.nsg_id

}

module "vm1" {
  source              = "./modules/virtual-machine"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vm_name             = "spoke1-vm1"
  vm_size             = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = var.vm_admin_password
  disable_password_authentication = false
  publisher           = "Canonical"
  offer               = "0001-com-ubuntu-server-focal"
  sku                 = "20_04-lts"
  storage_version    = "latest"
  os_disk_name       = "spoke1-vm1-os-disk"
  caching            = "ReadWrite"
  managed_disk_type  = "Standard_LRS"
  disk_size_gb       = 30
  subnet_id          = module.spoke1.workload_subnet_id
  tags               = module.resource_group.tags
}
  
module "vm2" {
  source              = "./modules/virtual-machine"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vm_name             = "spoke2-vm1"
  vm_size             = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = var.vm_admin_password
  disable_password_authentication = false
  publisher           = "Canonical"
  offer               = "0001-com-ubuntu-server-focal"
  sku                 = "20_04-lts"
  storage_version    = "latest"
  os_disk_name       = "spoke2-vm1-os-disk"
  caching            = "ReadWrite"
  managed_disk_type  = "Standard_LRS"
  disk_size_gb       = 30
  subnet_id          = module.spoke2.workload_subnet_id
  tags               = module.resource_group.tags
}