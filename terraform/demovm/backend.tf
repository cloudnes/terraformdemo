provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.58.0"
    }
  }
  backend "azurerm" {}
}

data "azurerm_client_config" "current" {
}