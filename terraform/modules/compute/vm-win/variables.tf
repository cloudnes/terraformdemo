variable "name" {
  description = "The name of the Linux Virtual Machine"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group in which the Linux Virtual Machine should exist"
  type        = string
}

variable "location" {
  description = "The Azure location where the Linux Virtual Machine should exist"
  type        = string
}

variable "size" {
  description = "The SKU which should be used for this Virtual Machine, such as Standard_D4s_v3"
  type        = string
}

variable "vm_admin_username" {
  description = "The username of the local administrator used for the Virtual Machine"
  type        = string
}

variable "vm_admin_password" {
  description = "The Password which should be used for the local-administrator on this Virtual Machine"
  type        = string
}

variable "nic_ids" {
  description = "A list of Network Interface ID's which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine"
  type        = list(string)
}


variable "os_disk_name" {
  description = "The name which should be used for the Internal OS Disk"
  type        = string
  default     = ""
}

variable "os_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
  type        = string
}

variable "sa_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS"
  type        = string
}
variable "sa_uri" {
  description = "Diagnostics Settings Storage account uri"
  type        = string
}
variable "sku" {
  description = "Windows Custom Image ID"
  type        = string
}
variable "avs_id" {
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist"
  type        = string
  default= null
}

variable "url_cert" {
  description = "URL of the cert"
  type        = string
 
}

variable "key_vault_id" {
  description = "key_vault_id"
  type        = string
}

variable "tags" {
  description = "Enter Tags to identify deployed resources"
  type        = map(string)
  default     = {}
}