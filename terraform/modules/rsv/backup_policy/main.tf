resource "azurerm_backup_policy_vm" "vm_policy" {
  name                = var.vm_policy_name
  resource_group_name = var.vm_policy_rg
  recovery_vault_name = var.rsv_name

  timezone = var.timezone

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
instant_restore_retention_days = 2
  retention_daily {
    count = 10
  }

  retention_weekly {
    count    = 5
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = 7
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

}