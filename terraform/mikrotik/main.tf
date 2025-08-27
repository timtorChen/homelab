terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.10.0"
    }
    routeros = {
      source = "terraform-routeros/routeros"
      version = "~> 1.86.3"
    }
  }
  backend "s3" {
    bucket         = "amethyst-terraform-backend"
    key            = "homelab/mikrotik"
    use_lockfile   = true
    region         = "us-west-2"
  }
}

provider "routeros" {
  hosturl = "http://192.168.248.1:8080"
  username = local.mikrotik_username
  password = local.mikrotik_password
}

