variable "hub_vnet_name" {
  description = "Name of the Hub Virtual Network"
  default     = "vnet-hub"
  
}

variable "resource_group_name" {
  description = "Name of Resource group for Hub VNet"
  default     = "rg-hub-spoke"
  
}

variable "location" {
  description = "Location for all resources"
  default     = "East US"
  
}

variable "hub_address_space" {
  description = "Address space for the Hub Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]

}

variable "firewall_subnet_prefix" {
  description = "Address prefix for the Firewall subnet"
  default     = "10.0.0.0/24"

}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "development"
    project     = "hub-spoke-network"
    terraform   = "true"
  }
}