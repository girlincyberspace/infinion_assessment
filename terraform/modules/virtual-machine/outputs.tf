output "vm_id" {
  description = "The ID of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm.id
  
}

output "vm_ip_address" {
  description = "The public IP address of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "nic_id" {
  description = "The ID of the network interface associated with the virtual machine."
  value       = azurerm_network_interface.nic.id
  
}

