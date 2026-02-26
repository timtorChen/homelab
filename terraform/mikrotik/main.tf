terraform {
  required_version = "~> 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.34.0"
    }
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "~> 1.99.0"
    }
  }
  backend "s3" {
    bucket       = "amethyst-terraform-backend"
    key          = "homelab/mikrotik"
    use_lockfile = true
    region       = "us-west-2"
  }
}

provider "routeros" {
  hosturl  = "http://192.168.248.1:8080"
  username = local.mikrotik_username
  password = local.mikrotik_password
}

locals {
  bgp_name             = "peer-to-cilium"
  bgp_as_number        = "65000"
  bgp_remote_as_number = "65001"
  bgp_remote_address   = "192.168.253.1/24"
}
