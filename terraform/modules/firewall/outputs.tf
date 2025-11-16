output "firewall_id" {
  description = "The ID of the firewall"
  value       = azurerm_firewall.hub.id
  
}

output "firewall_private_ip" {
  description = "The private IP address of the firewall"
  value       = azurerm_firewall.hub.ip_configuration[0].private_ip_address
  
}

output "firewall_public_ip" {
  description = "The public IP address of the firewall"
  value       = azurerm_public_ip.fw-pip.ip_address
  
}