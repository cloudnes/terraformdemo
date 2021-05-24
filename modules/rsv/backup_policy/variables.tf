variable "vm_policy_name" {
  description = "The Name which should be used for this VM backup policy"
  type        = string
}

variable "rsv_name" {
  description = "Name of the Rsv to be assosiated this policy"
  type        = string
}


variable "vm_policy_rg" {
  description = "Resource group where the policy will be deployed"
  type        = string
}

variable "timezone" {
  type = string
  default = "Central Standard Time"

  validation {
    condition     = contains(["Central Standard Time", "Pacific Standard Time", "Eastern Standard Time"], var.timezone)
    error_message = "Valid values for var: timezone are ( Central Standard Time , Pacific Standard Time , Eastern Standard Time)."
  } 
}

variable "tags" {
  description = "Enter Tags to identify deployed resources"
  type        = map(string)
  default     = {}
}