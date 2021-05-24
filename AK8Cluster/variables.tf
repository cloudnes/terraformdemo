locals {
  location       = "Central US"
  environment    = "PRD"
  rg_name = "AKS-RG"
  prefix = "scajero"
  aks_prefix="${local.prefix}-aks_cluster"
  dns_prefix="${local.prefix}-ak8"
  pool_name= "nodepool"
  agents_count= 1
  size = "Standard_D2as_v4"
  disk_size= 30

  
tags = {
    Environment   = "${local.environment}"
   
  }
}