output "id" {
  value = azurerm_key_vault.kv.id
}

output "name"{

  value = azurerm_key_vault.kv.name 
}

output "kv_uri" {
  value = azurerm_key_vault.kv.vault_uri
}