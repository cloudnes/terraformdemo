output "id" {
  value = azurerm_network_interface.nic.id
}

output "ipc_name" {
  value = azurerm_network_interface.nic.ip_configuration[0].name
}
