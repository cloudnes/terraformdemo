resource "azurerm_key_vault_key" "encrypt_key" {
  name         = var.key_name
  key_vault_id = var.kv_id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}