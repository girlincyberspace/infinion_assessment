variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}

variable "location" {
  description = "The location/region where the Network Security Group will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Network Security Group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Network Security Group"
  type        = map(string)
  default     = {}
}

variable "nsg_rules" {
  description = "A map of Network Security Rules to be created within the Network Security Group"
  type = map(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
  default = {}
}