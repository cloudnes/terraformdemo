variable "vm_id" {
  description = "Specifies the VM id "
  type        = string
}

variable "kv_uri" {
  description = "Key Vault uri where the key is stored."
  type        = string
}
variable "kv_id" {
  description = "key vault id where the key is stored. "
  type        = string
}
variable "encryptkey_id" {
  description = "Encryption Key id "
  type        = string
}
variable "tags" {
  description = "Enter Tags to identify deployed resources"
  type        = map(string)
  default     = {}
}

