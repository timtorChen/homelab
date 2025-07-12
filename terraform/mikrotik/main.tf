terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.97.0"
    }
    routeros = {
      source = "terraform-routeros/routeros"
      version = "~> 1.85.3"
    }
  }
  backend "s3" {
    bucket         = "amethyst-terraform-backend"
    key            = "homelab/mikrotik"
    dynamodb_table = "tfstate-lock"
    region         = "us-west-2"
  }
}

provider "routeros" {
  hosturl = "api://192.168.248.1:8080"
  username = local.mikrotik_username
  password = local.mikrotik_passsword
}