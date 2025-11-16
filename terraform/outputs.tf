output "hub_vnet_id" {
  value = module.hub.hub_vnet_id
  description = "The ID of the Hub Virtual Network"
}

output "spoke1_vnet_id" {
  value = module.spoke1.spoke_vnet_id
  description = "The ID of Spoke 1 Virtual Network"
}

output "spoke2_vnet_id" {
  value = module.spoke2.spoke_vnet_id
  description = "The ID of Spoke 2 Virtual Network"
}

output "firewall_private_ip" {
  value       = module.firewall.firewall_private_ip
  description = "The private IP address of the firewall"
}

output "firewall_public_ip" {
  value       = module.firewall.firewall_public_ip
  description = "The public IP address of the firewall"
  
}