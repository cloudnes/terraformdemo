resource "azurerm_key_vault_certificate" "SSL_Cert" {
  name         = var.cert_name
  key_vault_id = var.kv_id

  certificate {
    contents = filebase64(var.cert_path)
    password = ""
  }
  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }
  
  }