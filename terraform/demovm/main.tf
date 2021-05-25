module "rg" {
  source   = "./../modules/resource_group"
  name     = local.rg_name
  location = local.location
  tags     = local.tags
}
resource "azurerm_user_assigned_identity" "identity_agw" {
  location            = module.rg.location
  resource_group_name = module.rg.name
  name                = local.identity_name
  tags                = local.tags
}

module "vnet"{
  source= "./../modules/network/vnet"
  name = local.vnet_name
  rg_name  = module.rg.name
  location = module.rg.location
  address_space = [local.vnet_address_cidr]
  tags               = local.tags
  depends_on = [    module.rg     ]
}

module "subnet" {
  source       = "./../modules/network/subnet"
  name         = local.subnet_name
  rg_name      = module.rg.name
  vnet_name    = module.vnet.name
  address_cidr = [local.subnet_cidr]
  depends_on = [
    module.vnet
  ]
}
module "subnet_front" {
  source       = "./../modules/network/subnet"
  name         = local.subnet_name_front
  rg_name      = module.rg.name
  vnet_name    = module.vnet.name
  address_cidr = [local.subnet_cidr_front]
  depends_on = [
    module.vnet
  ]
}
module "subnet_jump" {
  source       = "./../modules/network/subnet"
  name         = local.subnet_name_jump
  rg_name      = module.rg.name
  vnet_name    = module.vnet.name
  address_cidr = [local.subnet_cidr_jump]
  depends_on = [
    module.vnet
  ]
}
module "pip_appgw"{
  source       = "./../modules/network/pip"
  name = local.pip_appgw_name
  rg_name = module.rg.name
  location   = module.rg.location
  allocation_method   = "Static"
  sku = "Standard"
  tags       = local.tags

}

module "pip_jump"{
  source       = "./../modules/network/pip"
  name = local.pip_jump_name
  rg_name = module.rg.name
  location   = module.rg.location
  allocation_method   = "Dynamic"
  tags       = local.tags

}


module "nsg" {
  source   = "./../modules/network/nsg"
  name     = local.nsg_name
  rg_name  = module.rg.name
  location = module.rg.location
  tags     = local.tags
  depends_on = [
    module.subnet
  ]
}
module "nsg_appgw" {
  source   = "./../modules/network/nsg"
  name     = local.nsg_name_appgw
  rg_name  = module.rg.name
  location = module.rg.location
  tags     = local.tags
  depends_on = [
    module.subnet_front
  ]
}
module "nsg_jump" {
  source   = "./../modules/network/nsg"
  name     = local.nsg_name_jump
  rg_name  = module.rg.name
  location = module.rg.location
  tags     = local.tags
  depends_on = [
    module.subnet_jump
  ]
}
module "web_nsg_rule" {
  source                     = "./../modules/network/nsg/sr"
  name                       = "web"
  description                = "Allow web access"
  rg_name                    = module.rg.name
  nsg_name                   = module.nsg.name
  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["80","443","3389"]
  source_address_prefixes    = local.nsg_allowed_addresses
  destination_address_prefix = "*"
}
module "appgw_web_nsg_rule" {
  source                     = "./../modules/network/nsg/sr"
  name                       = "web"
  description                = "Allow web access"
  rg_name                    = module.rg.name
  nsg_name                   = module.nsg_appgw.name
  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["80","443"]
  source_address_prefixes    = local.nsg_allowed_addresses_gw
  destination_address_prefix = "*"
}
module "appgwv2_nsg_rule" {
  source                     = "./../modules/network/nsg/sr"
  name                       = "applicationgateway"
  description                = "Allow "
  rg_name                    = module.rg.name
  nsg_name                   = module.nsg_appgw.name
  priority                   = 4096
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["65200-65535"]
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
module "nsg_rule_jump" {
  source                     = "./../modules/network/nsg/sr"
  name                       = "applicationgateway"
  description                = "Allow "
  rg_name                    = module.rg.name
  nsg_name                   = module.nsg_jump.name
  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_ranges    = ["3389"]
  source_address_prefixes    = local.nsg_allowed_addresses_jump
  destination_address_prefix = "*"
}

module "nsg_subnet_association" {
  source    = "./../modules/network/subnet/nsg_association"
  subnet_id = module.subnet.id
  nsg_id    = module.nsg.id
}
module "nsg_subnet_association_appgw" {
  source    = "./../modules/network/subnet/nsg_association"
  subnet_id = module.subnet_front.id
  nsg_id    = module.nsg_appgw.id
}
module "nsg_subnet_association_jump" {
  source    = "./../modules/network/subnet/nsg_association"
  subnet_id = module.subnet_jump.id
  nsg_id    = module.nsg_jump.id
}

module "sa"{
source   = "./../modules/storage"
name= local.sa_name
rg_name= module.rg.name
location= module.rg.location
tier        = local.sa_tier
replication = local.sa_replication
tags        = local.tags
}

module "rsv"{
  source        = "./../modules/rsv" 
  rsv_name      = local.rsv_name
  rsv_location  = module.rg.location
  rsv_rg        = module.rg.name
  tags          = local.tags
}
module "backup_policy"{
  source        = "./../modules/rsv/backup_policy" 
  vm_policy_name  = local.vm_policy_name
  vm_policy_rg    = module.rsv.rsv_rg 
  rsv_name        = module.rsv.rsv_name
  timezone = local.timezone
}


module "kv" {
  source      = "./../modules/kv"
  name        = local.kv_name
  rg_name     = module.rg.name
  location    = module.rg.location
  tenant_id   = local.tenant_id
  sku         = local.kv_sku
  soft_delete = local.retention_days
  tags        = local.tags
}


module "kv_ap" {
  source                  = "./../modules/kv/access_policy"
  kv_id                   = module.kv.id
  tenant_id               = local.tenant_id
  object_id               = local.object_id
  key_permissions         = local.kv_ap_key_permissions
  secret_permissions      = local.kv_ap_secret_permissions
  certificate_permissions = local.kv_ap_certificate_permissions
  storage_permissions     = local.kv_ap_storage_permissions
}
module "kv_ap_identity" {
  source                  = "./../modules/kv/access_policy"
  kv_id                   = module.kv.id
  tenant_id               = local.tenant_id
  object_id               = azurerm_user_assigned_identity.identity_agw.principal_id
  secret_permissions      = local.kv_ap_secret_permissions_identity
  depends_on = [
    azurerm_user_assigned_identity.identity_agw , module.kv
  ]
}


module "secretpassword" {
  source                = "./../modules/kv/secret"
  name                  = local.secret_name
  kv_id                 = module.kv.id
  content               = local.kv_secret_content
  secret_length         = local.kv_secret_length
  min_upper             = local.kv_secret_min_upper
  min_lower             = local.kv_secret_min_lower
  min_numeric           = local.kv_secret_min_numeric
  min_special           = local.kv_secret_min_special
  allowed_special_chars = local.kv_secret_allowed_special_chars
  depends_on = [
    module.kv_ap
  ]
  tags                  = local.tags
}

module "encrypt_key"{
  source                = "./../modules/kv/key"
  key_name              = local.encrypt_key_name
  kv_id                 = module.kv.id
  depends_on = [
    module.kv_ap
  ]
}

module "ssl_cert"{
source                = "./../modules/kv/certificate"
cert_name             = local.certname
kv_id                 = module.kv.id
cert_path             = local.cert_path
depends_on = [
    module.kv_ap
  ]
}

module "appgw"{
source                = "./../modules/network/web_appgw"
appgway_name = local.appgway_name
rg_name = module.rg.name
location = module.rg.location
subnet_id =module.subnet_front.id
pip = module.pip_appgw.id
ssl_cert_name = module.ssl_cert.name
ssl_secret_id = module.ssl_cert.id
appgw_identity_id = [azurerm_user_assigned_identity.identity_agw.id]
probe_fqdn = local.probe_fqdn
probe_name = local.probe_name
}


module "vm_nic" {
  count = 2
  source                = "./../modules/network/nic"
  name                  = "${local.vm_nic_name}-${count.index}"
  rg_name               = module.rg.name
  location              = module.rg.location
  ipc_name              = "${local.nic_ipc_name}-${count.index}"
  subnet_id             =  module.subnet.id
  private_ip_allocation = local.nic_private_ip_allocation
  private_ip   =          local.private_ip
  tags                  = local.tags
  depends_on = [
    module.subnet
  ]
}
module "vm_nic_jump" {
  source                = "./../modules/network/nic"
  name                  = local.vm_nic_name_jump
  rg_name               = module.rg.name
  location              = module.rg.location
  ipc_name              = local.nic_ipc_name_jump
  subnet_id             =  module.subnet_jump.id
  private_ip_allocation = local.nic_private_ip_allocation
  private_ip   =          local.private_ip
  tags                  = local.tags
  pip_id                = module.pip_jump.id
  depends_on = [
    module.subnet_jump , module.pip_jump
  ]
}


module "avs" {
  source   = "./../modules/compute/avs"
  name     = local.avs_name
  rg_name  = module.rg.name
  location = module.rg.location
  avs_fd   = 2
  avs_ud   = 5
  tags     = local.tags
}


module "vm-1" {
  count = local.cluster_size
  source            = "./../modules/compute/vm-win"
  name              = "${local.vm_name}-${count.index}"
  rg_name           = module.rg.name
  location          = module.rg.location
  avs_id            = module.avs.id
  size              = local.vm_size
  vm_admin_username = local.vm_admin_username
  vm_admin_password = module.secretpassword.value
  nic_ids           = [element (module.vm_nic.*.id, count.index)]
  os_caching        = local.vm_oscaching
  sa_type           = local.osdisk_sa_type
  sku               = local.win_os_sku
  tags              = local.vm_tags
  os_disk_name      = "${local.os_disk_name}-${count.index}"
  sa_uri            = module.sa.pbe
  key_vault_id      = module.kv.id
  url_cert          = module.ssl_cert.id
}

module "vm-jump" {
  source            = "./../modules/compute/vm-win"
  name              = local.vm_name_jump
  rg_name           = module.rg.name
  location          = module.rg.location
  size              = local.vm_size_jump
  vm_admin_username = local.vm_admin_username
  vm_admin_password = module.secretpassword.value
  nic_ids           = [module.vm_nic_jump.id]
  os_caching        = local.vm_oscaching
  sa_type           = local.osdisk_sa_type
  sku               = local.win_os_sku
  tags              = local.vm_tags
  os_disk_name      = local.os_disk_name_jump
  sa_uri            = module.sa.pbe
  key_vault_id      = module.kv.id
  url_cert          = module.ssl_cert.id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "backend_pool" {
  count = local.cluster_size
  network_interface_id    = element (module.vm_nic.*.id, count.index)
  ip_configuration_name   = element (module.vm_nic.*.ipc_name, count.index)
  backend_address_pool_id = module.appgw.backend_address_pool
  depends_on = [
    module.appgw , module.vm_nic
  ]
}

resource "azurerm_backup_protected_vm" "vm_backup" {
  count= local.cluster_size
  resource_group_name = module.backup_policy.vm_policy_rg 
  recovery_vault_name = module.rsv.rsv_name
  source_vm_id        = element (module.vm-1.*.id, count.index)
  backup_policy_id    = module.backup_policy.id
  depends_on = [
    module.rsv , module.vm-1
  ]
}


module "vmdiskencrypt" {
  count= local.cluster_size
  source               = "./../modules/compute/disk_encrypt_extension"
  vm_id                = element (module.vm-1.*.id, count.index)
  kv_id                = module.kv.id
  kv_uri               = module.kv.kv_uri
  encryptkey_id        = module.encrypt_key.id
  tags = local.tags
   depends_on = [
    module.vm-1 , module.encrypt_key
  ]
}

resource "azurerm_virtual_machine_extension" "vm_extension_install_iis" {
  count = local.cluster_size
  depends_on = [
    module.vm-1
  ]
  name                       = "vm_extension_install_iis"
  virtual_machine_id         = element (module.vm-1.*.id, count.index)
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
  
        "fileUris":["https://raw.githubusercontent.com/cloudnes/terraformdemo/main/install-iis.ps1"],
        "commandToExecute":"powershell -ExecutionPolicy Unrestricted -File install-iis.ps1"
    }
SETTINGS
}