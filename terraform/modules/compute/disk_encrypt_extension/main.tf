resource "azurerm_virtual_machine_extension" "vmextension" {
  name                       = "AzureDiskEncryption"
  virtual_machine_id         = var.vm_id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryption"
  type_handler_version       = "2.2"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "EncryptionOperation": "EnableEncryption",
        "KeyVaultURL": "${var.kv_uri}",
        "KeyVaultResourceId": "${var.kv_id}",					
        "KeyEncryptionKeyURL": "${var.encryptkey_id}",
        "KekVaultResourceId": "${var.kv_id}",					
        "KeyEncryptionAlgorithm": "RSA-OAEP",
        "VolumeType": "All"
    }
SETTINGS

  tags = var.tags
}