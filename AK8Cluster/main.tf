module "rg" {
  source   = "./../modules/resource_group"
  name     = local.rg_name
  location = local.location
  tags     = local.tags
}

module "aks"{
  source   = "./../modules/ak8"
  name               = local.aks_prefix
  location            = local.location
  rg_name             = module.rg.name
  dns_prefix          = local.dns_prefix
  agents_pool_name    = local.pool_name
  agents_count        = local.agents_count
  agents_size         = local.size
  os_disk_size_gb     = local.disk_size
  tags                = local.tags
}

provider "kubernetes" {
  host                   = "${module.aks.kube_config.0.host}"
  client_certificate     = "${base64decode(module.aks.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(module.aks.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(module.aks.kube_config.0.cluster_ca_certificate)}"
}


resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "nginx"
    namespace = "default"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          image = "nginx:1.14.2"
          name  = "nginx-container"
          port {
            container_port = 80
          }
         
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name = "nginx"
  }
  spec {
  selector = {
      app = "nginx"
    }
    port {
      port =80
    }
    type ="LoadBalancer"
    
  }
}
