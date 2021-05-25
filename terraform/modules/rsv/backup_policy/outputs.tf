  output "vm_policy_name" {
      value = azurerm_backup_policy_vm.vm_policy.name
  } 

  output "vm_policy_rg" {
      value = azurerm_backup_policy_vm.vm_policy.resource_group_name 
  }
   output "id" {
      value = azurerm_backup_policy_vm.vm_policy.id
  }