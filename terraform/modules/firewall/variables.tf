variable "resource_group_name" {
  description = "The name of the resource group in which to create the firewall."
  type        = string
  
}

variable "firewall_name" {
  description = "The name of the firewall."
  type        = string

}

variable "location" {
  description = "The location where the firewall will be created."
  type        = string

}

variable "firewall_subnet_id" {
  description = "The ID of the subnet where the firewall will be deployed."
  type        = string

}

variable "spoke_address_spaces" {
  description = "The address spaces for the spoke VNets."
  type        = list(string)
  default = [ ]

}

variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
  default     = { }

}