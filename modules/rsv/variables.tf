variable "rsv_name" {
  description = "The Name which should be used for this RSV"
  type        = string
}

variable "rsv_location" {
  description = "Region where resource will be deployed"
  type        = string
}


variable "rsv_rg" {
  description = "Resource group where the Rsv will be deployed"
  type        = string
}



variable "tags" {
  description = "Enter Tags to identify deployed resources"
  type        = map(string)
  default     = {}
}