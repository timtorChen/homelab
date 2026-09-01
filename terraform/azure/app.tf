# Cloudflare
resource "azuread_application" "cloudflare" {
  display_name = "Cloudflare (terraform)"

  web {
    redirect_uris = local.entra_app_cloudflare_web_redirect_uris
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.main.result["MicrosoftGraph"]
    dynamic "resource_access" {
      for_each = local.entra_app_cloudflare_graph_scopes

      content {
        type = "Scope"
        id   = data.azuread_service_principal.main.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

resource "time_rotating" "cloudflare" {
  rotation_hours = local.entra_app_cloudflare_rotate_hours
}

resource "azuread_application_password" "cloudflare" {
  display_name   = "main (terraform)"
  application_id = azuread_application.cloudflare.id

  rotate_when_changed = {
    rotation = time_rotating.cloudflare.id
  }
}

# Miniflux
resource "azuread_application" "miniflux" {
  display_name = "Miniflux (terraform)"

  web {
    redirect_uris = local.entra_app_miniflux_web_redirect_uris
    logout_url    = local.entra_app_miniflux_web_logout_url
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.main.result["MicrosoftGraph"]
    dynamic "resource_access" {
      for_each = local.entra_app_cloudflare_graph_scopes

      content {
        type = "Scope"
        id   = data.azuread_service_principal.main.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

resource "time_rotating" "miniflux" {
  rotation_hours = local.entra_app_miniflux_rotate_hours
}

resource "azuread_application_password" "miniflux" {
  display_name   = "main (terraform)"
  application_id = azuread_application.miniflux.id

  rotate_when_changed = {
    rotation = time_rotating.miniflux.id
  }
}

# Output
output "_entra_tenant_id" {
  value = data.azuread_client_config.main.tenant_id
}

output "entra_app_cloudflare_application_id" {
  value = azuread_application.cloudflare.client_id
}

output "entra_app_cloudflare_application_secret" {
  value = nonsensitive(azuread_application_password.cloudflare.value)
}

output "entra_app_miniflux_application_id" {
  value = azuread_application.miniflux.client_id
}

output "entra_app_miniflux_application_secret" {
  value = nonsensitive(azuread_application_password.miniflux.value)
}


