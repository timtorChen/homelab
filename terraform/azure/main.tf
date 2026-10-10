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
}
