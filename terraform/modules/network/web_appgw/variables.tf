variable "appgway_name" {
  description = "The name of the Application Gateway"
  type        = string
}

variable "rg_name" {
  description = "The name of the resourcer group"
  type        = string
}

variable "location" {
  description = "location of the application gateway"
  type        = string
}

variable "subnet_id" {
  description = " application gateway  subnet id"
  type        = string
}

variable "pip" {
  description = "Public ip of the Application Gateway"
  type        = string
}

variable "ssl_cert_name" {
  description = "SSL certificate name inside the application gateway"
  type        = string
}

variable "ssl_secret_id" {
  description = "SSL certificate  id"
  type        = string
}
variable "probe_fqdn" {
  description = " FQDN of the domain"
  type        = string
}
variable "probe_name" {
  description = "Name of the Health probe"
  type        = string
}
variable "appgw_identity_id" {
  description = "Identity  id for SSL certificate"
  type        = list(string)
}
