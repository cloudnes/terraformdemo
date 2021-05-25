provider "azurerm" {
  features {}
}

 backend "azurerm" {     
 storage_account_name  = "backendtfscajero"     
 container_name        = "tstate"     
 key                   = "terraform.tfstate"   
 } 

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.58.0"
    }
  }
}

data "azurerm_client_config" "current" {
}