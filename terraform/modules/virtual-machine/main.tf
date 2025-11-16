resource "azurerm_public_ip" "nic-pip" {
  name                = "pip-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.vm_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nic-pip.id
  }

  tags = var.tags
  
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.nic.id]
  size                            = var.vm_size 
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  tags                            = var.tags
  disable_password_authentication = var.disable_password_authentication

  source_image_reference {
  publisher = var.publisher
  offer     = var.offer  
  sku       = var.sku
  version   = var.storage_version
  }

  os_disk {
  name                 = var.os_disk_name
  caching              = var.caching
  storage_account_type = var.managed_disk_type
  disk_size_gb         = var.disk_size_gb 
  }
}