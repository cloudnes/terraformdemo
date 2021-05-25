variable "rg_name" {
  description = "The name of the Resource Group where the Managed Disk should exist"
  type        = string
}
variable "location" {
  description = "Specified the supported Azure location where the resource exists"
  type        = string
}
variable "name" {
  description = "The name  of the AKS cluster"
  type        = string
}
variable "dns_prefix" {
  description = "The DNS prefix  of the AKS cluster"
  type        = string
}
variable "agents_count" {
  description = "The number of Nodes that should exist in the Agent Pool"
  type        = number
}
variable "agents_pool_name" {
  description = "The default Azure AKS agentpool (nodepool) name."
  type        = string
  default     = "nodepool"
}

variable "agents_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}
variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Enter Tags to identify deployed resources"
  type        = map(string)
  default     = {}
}