variable "cert_name" {
  description = "Specifies the name of the Certificate "
  type        = string
}
variable "kv_id" {
  description = "Specifies the id of the Key Vault"
  type        = string
}

variable "cert_path" {
  description = "Path of the Certificate file"
  type        = string
}