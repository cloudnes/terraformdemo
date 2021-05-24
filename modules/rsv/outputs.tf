output  "rsv_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "rsv_location" {
  value = azurerm_recovery_services_vault.vault.location
}


output "rsv_rg" {
  value = azurerm_recovery_services_vault.vault.resource_group_name
}
