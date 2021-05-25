output "name" {
  value = azurerm_key_vault_certificate.SSL_Cert.name
}
output "id" {
  value = azurerm_key_vault_certificate.SSL_Cert.secret_id
}