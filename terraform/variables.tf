variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "development"
    project     = "hub-spoke-network"
    terraform   = "true"
  }
}