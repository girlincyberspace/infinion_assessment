variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
  
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}   

variable "subnet_id" {
  description = "The ID of the subnet where the network interface will be created."
  type        = string  
  
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
  default     = "P@ssw0rd1234!"
}

variable "disable_password_authentication" {
  description = "Whether to disable password authentication."
  type        = bool
  default     = false
}

variable "publisher" {
  description = "The publisher of the VM image."
  type        = string
  default     = "Canonical"
}

variable "offer" {
  description = "The offer of the VM image."
  type        = string
  default     = "UbuntuServer"
}

variable "sku" {
  description = "The SKU of the VM image."
  type        = string
  default     = "18.04-LTS"
}

variable "storage_version" {
  description = "The version of the VM image."
  type        = string
  default     = "latest"
}

variable "os_disk_name" {
  description = "The name of the OS disk."
  type        = string
  default     = "osdisk"
}

variable "caching" {
  description = "The caching type of the OS disk."
  type        = string
  default     = "ReadWrite"
}

variable "managed_disk_type" {
  description = "The type of managed disk."
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "The size of the OS disk in GB."
  type        = number
  default     = 30
}

