variable "resource_group_name" {
  description = "The name of the resource group in which to create the firewall."
  type        = string
  
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "spoke_vnet_name" {
  description = "The name of the spoke virtual network."
  type        = string
}

variable "spoke_address_space" {
  description = "The address space for the spoke virtual network."
  type        = list(string)
}

variable "workload_subnet_address_prefixes" {
  description = "The address prefixes for the workload subnet."
  type        = list(string)
}

variable "hub_vnet_id" {
  description = "The ID of the hub virtual network to peer with."
  type        = string
}

variable "hub_vnet_name" {
  description = "The name of the hub virtual network."
  type        = string
}

variable "firewall_private_ip" {
  description = "The private IP address of the firewall to route traffic through."
  type        = string
  
}

variable "remote_spoke_address_space" {
  description = "The address space of the remote spoke virtual network for routing."
  type        = list(string)
}