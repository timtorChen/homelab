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

  entra_app_miniflux_web_redirect_uris = ["https://miniflux.timtor.dev/oauth2/oidc/callback"]
  entra_app_miniflux_web_logout_url    = "https://miniflux.timtor.dev"
  entra_app_miniflux_graph_scopes = [
    "email",
    "openid",
    "profile"
  ]
  entra_app_miniflux_rotate_hours = local.entra_app_rotate_hours

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
  entra_app_cloudflare_rotate_hours = local.entra_app_rotate_hours
}
