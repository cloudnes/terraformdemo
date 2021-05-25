resource "azurerm_application_gateway" "appgw" {
  name                = var.appgway_name
  resource_group_name = var.rg_name
  location            = var.location

  sku {
        capacity = 1
        name     = "WAF_v2"
        tier     = "WAF_v2"
  }
  ssl_certificate {
    name                = var.ssl_cert_name
    key_vault_secret_id = var.ssl_secret_id
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id
  }


frontend_port {
        name = "port_443"
        port = 443
    }
frontend_port {
        name = "port_80"
        port = 80
    }

  frontend_ip_configuration {
    name            = "appGwPublicFrontendIp"
    public_ip_address_id = var.pip
  }

  backend_address_pool {
    name = "backendAdressPool"
  }

  backend_http_settings {
    name                  = "http_settings"
    cookie_based_affinity = "Disabled"
    pick_host_name_from_backend_address = false
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
    probe_name            = var.probe_name
  }

  http_listener {
    name                           = "http_basic_listener"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_80"
    protocol                       = "Http"
    require_sni                    = false
  }
  http_listener {
    name                           = "https_basic_listener"
    frontend_ip_configuration_name = "appGwPublicFrontendIp"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    require_sni                    = false
    ssl_certificate_name           = var.ssl_cert_name
  }
    request_routing_rule {
    name                       = "https_rule"
    rule_type                  = "Basic"
    http_listener_name         = "https_basic_listener"
    backend_address_pool_name  = "backendAdressPool"
    backend_http_settings_name = "http_settings"
  }
  redirect_configuration {
        include_path         = true
        include_query_string = true
        name                 = "httptohttps_redirect_rule"
        redirect_type        = "Permanent"
        target_listener_name = "https_basic_listener"
    }

 request_routing_rule {
    name                        = "http_rule"
    rule_type                   = "Basic"
    http_listener_name          = "http_basic_listener"
    redirect_configuration_name = "httptohttps_redirect_rule"
  }

  identity {
        identity_ids = var.appgw_identity_id
        type         = "UserAssigned"
    }

    probe {
          host                                      = var.probe_fqdn
          interval                                  = 30 
          name                                      = var.probe_name
          path                                      = "/"
          pick_host_name_from_backend_http_settings = false
          protocol                                  = "Https" 
          timeout                                   = 30
          unhealthy_threshold                       = 3 
         
        }

    lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
      ssl_certificate,
      redirect_configuration,
      autoscale_configuration
    ]
  }
}