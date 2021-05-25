resource "azurerm_windows_virtual_machine" "vm"{
  name                            = var.name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  network_interface_ids           = var.nic_ids
  license_type                    = "Windows_Server"
  availability_set_id            = var.avs_id

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_caching
    storage_account_type = var.sa_type
  }

   boot_diagnostics {
    storage_account_uri = var.sa_uri
  }
source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.sku
    version   = "latest"
  }
  secret {
    key_vault_id =   var.key_vault_id
     certificate {
      store = "MY"
      url = var.url_cert
      }
  
  }    
 

  tags = var.tags
}