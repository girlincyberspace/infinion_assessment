variable "resource_group_name" {
  description = "Name of Resource group"
  default = "rg-hub-spoke"
}

variable "location" {
  description = "Location of Resource group"
  default     = "East US"
  
}

variable "tags" {
  description = "Tags to be applied to the Resource group"
  type        = map(string)
  default     = {
    environment = "development"
    project     = "hub-spoke-network"
    terraform   = "true"
  }
  
}