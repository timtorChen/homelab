terraform {
  required_version = "~> 1.14.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.9"
    }
    time = {
      source = "hashicorp/time"
    }
  }
  backend "s3" {
    bucket       = "amethyst-terraform-backend"
    key          = "homelab/azure"
    use_lockfile = true
    region       = "us-west-2"
  }
}

provider "azuread" {
  tenant_id = "a5ccdd11-d4cc-424b-ab4a-6bef963f831c"
}

data "azuread_client_config" "main" {}

data "azuread_application_published_app_ids" "main" {}

data "azuread_service_principal" "main" {
  client_id = data.azuread_application_published_app_ids.main.result["MicrosoftGraph"]
}

locals {
  # entra application sectet expires in 2 years by default
  # set 1 year and trigger the rotation in next "terraform apply"
  entra_app_rotate_hours = 8760

  # cloudflare
  entra_app_cloudflare_web_redirect_uris = ["https://timtor.cloudflareaccess.com/cdn-cgi/access/callback"]
  entra_app_cloudflare_graph_scopes = [
    "email",
    "offline_access",
    "openid",
    "profile",
    "User.Read",
    "Directory.Read.All",
    "GroupMember.Read.All",
  ]

  entra_app_grafana_web_redirect_uris = ["https://grafana.timtor.dev/login/generic_oauth"]
  entra_app_grafana_web_logout_url    = "https://grafana.timtor.dev"
  entra_app_grafana_graph_scopes = [
    "User.Read",
    "GroupMember.Read.All"
  ]

  # miniflux
  entra_app_miniflux_web_redirect_uris = ["https://miniflux.timtor.dev/oauth2/oidc/callback"]
  entra_app_miniflux_web_logout_url    = "https://miniflux.timtor.dev"
  entra_app_miniflux_graph_scopes = [
    "email",
    "openid",
    "profile"
  ]

  # immich
  entra_app_immich_web_redirect_uris = [
    "https://photo.timtor.dev/auth/login",
    "https://photo.timtor.dev/user-settings",
    "https://photo.timtor.dev/api/oauth/mobile-redirect",
    # "app.immich:///oauth-callback"
  ]
  entra_app_immich_web_logout_url = "https://photo.timtor.dev"
  entra_app_immich_graph_scopes = [
    "email",
    "openid",
    "profile"
  ]

  # opencode
  entra_app_opencode_web_redirect_uris = [
    "https://oc.timtor.dev/oidc-callback.html",
    # "http://127.0.0.1"
  ]
  entra_app_opencode_web_logout_url = "https://opencode.timtor.dev"
  entra_app_opencode_graph_scopes = [
    "email",
    "openid",
    "profile"
  ]
}
