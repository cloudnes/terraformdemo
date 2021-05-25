output "RG_name" {
  value = module.rg.name
}

output "kube_config" {
  sensitive = true
  value     = module.aks.kube_config
}
output "name" {
  value     = module.aks.name
}

