variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "development"
    project     = "hub-spoke-network"
    terraform   = "true"
  }
}

variable "vm_admin_password" {
  description = "The admin password for virtual machines."
  type        = string
  sensitive   = true
}