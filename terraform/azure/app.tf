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
  rotation_hours = local.entra_app_rotate_hours
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
      for_each = local.entra_app_miniflux_graph_scopes

      content {
        type = "Scope"
        id   = data.azuread_service_principal.main.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

resource "time_rotating" "miniflux" {
  rotation_hours = local.entra_app_rotate_hours
}

resource "azuread_application_password" "miniflux" {
  display_name   = "main (terraform)"
  application_id = azuread_application.miniflux.id

  rotate_when_changed = {
    rotation = time_rotating.miniflux.id
  }
}

# Grafana
resource "azuread_application" "grafana" {
  display_name = "Grafana (terraform)"

  web {
    redirect_uris = local.entra_app_grafana_web_redirect_uris
    logout_url    = local.entra_app_grafana_web_logout_url
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.main.result["MicrosoftGraph"]
    dynamic "resource_access" {
      for_each = local.entra_app_grafana_graph_scopes

      content {
        type = "Scope"
        id   = data.azuread_service_principal.main.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

resource "time_rotating" "grafana" {
  rotation_hours = local.entra_app_rotate_hours
}

resource "azuread_application_password" "grafana" {
  display_name   = "main (terraform)"
  application_id = azuread_application.grafana.id

  rotate_when_changed = {
    rotation = time_rotating.grafana.id
  }
}

# Immich
resource "azuread_application" "immich" {
  display_name = "Immich (terraform)"

  web {
    redirect_uris = local.entra_app_immich_web_redirect_uris
    logout_url    = local.entra_app_immich_web_logout_url
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.main.result["MicrosoftGraph"]
    dynamic "resource_access" {
      for_each = local.entra_app_immich_graph_scopes

      content {
        type = "Scope"
        id   = data.azuread_service_principal.main.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

resource "time_rotating" "immich" {
  rotation_hours = local.entra_app_rotate_hours
}

resource "azuread_application_password" "immich" {
  display_name   = "main (terraform)"
  application_id = azuread_application.immich.id

  rotate_when_changed = {
    rotation = time_rotating.immich.id
  }
}

# Opencode
resource "azuread_application" "opencode" {
  display_name = "Opencode (terraform)"

  web {
    redirect_uris = local.entra_app_opencode_web_redirect_uris
    logout_url    = local.entra_app_opencode_web_logout_url
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.main.result["MicrosoftGraph"]
    dynamic "resource_access" {
      for_each = local.entra_app_opencode_graph_scopes

      content {
        type = "Scope"
        id   = data.azuread_service_principal.main.oauth2_permission_scope_ids[resource_access.value]
      }
    }
  }
}

resource "time_rotating" "opencode" {
  rotation_hours = local.entra_app_rotate_hours
}

resource "azuread_application_password" "opencode" {
  display_name   = "main (terraform)"
  application_id = azuread_application.opencode.id

  rotate_when_changed = {
    rotation = time_rotating.opencode.id
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

output "entra_app_grafana_application_id" {
  value = azuread_application.grafana.client_id
}

output "entra_app_grafana_application_secret" {
  value = nonsensitive(azuread_application_password.grafana.value)
}

output "entra_app_immich_application_id" {
  value = azuread_application.immich.client_id
}

output "entra_app_immich_application_secret" {
  value = nonsensitive(azuread_application_password.immich.value)
}

output "entra_app_opencode_application_id" {
  value = azuread_application.opencode.client_id
}

output "entra_app_opencode_application_secret" {
  value = nonsensitive(azuread_application_password.opencode.value)
}


