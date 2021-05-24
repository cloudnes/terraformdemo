resource "azurerm_recovery_services_vault" "vault" {
  name                = var.rsv_name
  location            = var.rsv_location
  resource_group_name = var.rsv_rg
  sku                 = "Standard"
  soft_delete_enabled = false
  tags                = var.tags
}