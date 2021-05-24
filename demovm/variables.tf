locals{
  #Base config
  location    = "East US 2"
  environment = "prod"
  prefix      = "saul"
  rg_name     = "${local.prefix}${local.environment}-RG"
  tenant_id   = data.azurerm_client_config.current.tenant_id
  object_id   = data.azurerm_client_config.current.object_id
  cluster_size = 2


  # vnet config
  vnet_name= "${local.prefix}${local.environment}_vnet"
  vnet_address_cidr="10.1.0.0/16"
 
  #subnet config
  subnet_name="${local.prefix}${local.environment}_vmsnet"
  subnet_cidr="10.1.2.0/24"
  #front end subnet
  subnet_name_front = "${local.prefix}${local.environment}_frontsnet"
  subnet_cidr_front = "10.1.1.0/24"
  #jump subnet config
  subnet_name_jump = "${local.prefix}${local.environment}_jumpsnet"
  subnet_cidr_jump= "10.1.3.0/24"
  #Public IP name 
  pip_appgw_name= "${local.prefix}${local.environment}_appgw_pip"
  pip_jump_name = "${local.prefix}${local.environment}_jump_pip"
  #NSG config
  nsg_name= "${local.prefix}${local.environment}_nsg"
  nsg_name_appgw= "${local.prefix}${local.environment}appgw_nsg"
  nsg_name_jump= "${local.prefix}${local.environment}jump_nsg"
  #NSG rule
  nsg_allowed_addresses=["10.1.0.0/16"]
  nsg_allowed_addresses_gw=["0.0.0.0/0"]
  nsg_allowed_addresses_jump =["174.128.60.160"]

  #Storage account config
  sa_tier              = "Standard"
  sa_replication       = "LRS"
  sa_name  = "${local.prefix}${local.environment}diagnosticssa"



  #RSV config
  rsv_name ="${local.prefix}${local.environment}-rsv"

  #backup policy config
  vm_policy_name ="${local.prefix}${local.environment}_vmBackup_policy"
  timezone = "Central Standard Time"

  #Key vault settings
  kv_name                       = "${local.prefix}${local.environment}-kv"
  kv_sku                        = "standard"
  retention_days                = 7
  kv_ap_key_permissions         = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
  kv_ap_secret_permissions      = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
  kv_ap_certificate_permissions = ["backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "restore", "setissuers", "update"]
  kv_ap_storage_permissions     = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas", "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
  kv_ap_secret_permissions_identity=["get"]
  #Secret settings
  secret_name                     = "AdminAccount-${local.environment}"
  kv_secret_length                = 32
  kv_secret_min_upper             = 5
  kv_secret_min_lower             = 5
  kv_secret_min_numeric           = 5
  kv_secret_min_special           = 5
  kv_secret_allowed_special_chars = "!@#$%&*()-_=+[]{}<>:?"
  kv_secret_content               = "VM admin user password"
#Disk Encryption key config
encrypt_key_name    = "${local.prefix}${local.environment}-DiskEncryptKey"

#certificate
certname= "${local.prefix}${local.environment}-cert"
cert_path = "cert.pfx"

  #VM Nic Config
  vm_nic_name              = "${local.prefix}${local.environment}_nic"
  nic_ipc_name            = "${local.prefix}${local.environment}_internal"
  nic_private_ip_allocation = "Dynamic"
  private_ip                = ""
  
  #Jump VM Nic Config
  vm_nic_name_jump              = "${local.prefix}${local.environment}_nic"
  nic_ipc_name_jump            = "${local.prefix}${local.environment}_internal"
  

  #AVS variables
  avs_name = "${local.prefix}${local.environment}_avs"
#RSV variables

  #VM variables
  vm_name           = "${local.prefix}VM${local.environment}"
  vm_size           = "Standard_D4as_v4"
  vm_admin_username = "DemoAdmin"
  vm_oscaching      = "ReadWrite"
  osdisk_sa_type    = "StandardSSD_LRS"
  win_os_sku        = "2019-Datacenter"
  os_disk_name      = "${local.prefix}VM${local.environment}_disk"
  vm_tags           = local.tags
  cert_store        ="Cert:\\LocalMachine\\My"
 #Jump VM variables
 vm_name_jump      = "${local.prefix}VM${local.environment}jump"
 os_disk_name_jump      = "${local.prefix}VM${local.environment}jump_disk"
 vm_size_jump           = "Standard_D4as_v4"
 #application gateway config

identity_name = "Appgw_ssl_manager"
appgway_name = "${local.prefix}VM${local.environment}_appgw"
probe_fqdn = "saulcajero.tk"
probe_name = "web_probe"
 
 # Tags for the environment
  tags = {
    Environment = "${local.environment}"
  }
}

