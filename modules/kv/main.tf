resource "azurerm_key_vault" "kv" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = var.sku
  tags                = var.tags
  soft_delete_retention_days  = var.soft_delete
  purge_protection_enabled    = false
  enabled_for_template_deployment = true 
  enabled_for_disk_encryption = true
  enabled_for_deployment = true
}