terraform {
  required_version = "~> 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
  backend "s3" {
    bucket         = "amethyst-terraform-backend"
    key            = "homelab/cloudflare"
    dynamodb_table = "tfstate-lock"
    region         = "us-west-2"
  }
}

provider "cloudflare" {
  api_token = local.cloudflare_token
}

locals {
  cloudflare_token                 = jsondecode(data.aws_ssm_parameter.cloudflare.value)["cloudflare_token"]
  cloudflare_tunnel_homelab_secret = jsondecode(data.aws_ssm_parameter.cloudflare.value)["cloudflare_tunnel_homelab_secret"]
}

locals {
  zone       = "timtor.dev"
  zone_id    = data.cloudflare_zone.main.zone_id
  account_id = data.cloudflare_accounts.main.accounts[0].id
}

locals {
  homelab_network_cidr = "192.168.248.0/21"
  homelab_dns_server   = ["192.168.248.1"]
  homelab_private_domains = [
    "drive.timtor.dev",
    "grafana.timtor.dev",
    "hass.timtor.dev",
    "music.timtor.dev",
    "photo.timtor.dev",
    "rss.timtor.dev",
    "s3-fast.timtor.dev",
    "ui.timtor.dev",
    "vault.timtor.dev"
  ]
  homelab_public_ingress_rules = [
    {
      hostname = "grafana.timtor.dev"
      service  = "https://grafana.timtor.dev"
    },
    {
      hostname = "kromgo.timtor.dev"
      service  = "https://kromgo.timtor.dev"
    },
    {
      hostname = "flux.timtor.dev"
      service  = "https://flux.timtor.dev"
    },
    {
      service = "http_status:404"
    }
  ]
}
