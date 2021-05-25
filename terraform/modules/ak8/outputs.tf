output "kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.aks.kube_config
}

output "name" {
  value     = azurerm_kubernetes_cluster.aks.name
}