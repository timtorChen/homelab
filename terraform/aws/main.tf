terraform {
  required_version = "~> 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.34.0"
    }
  }
  backend "s3" {
    bucket       = "amethyst-terraform-backend"
    key          = "homelab/aws"
    use_lockfile = true
    region       = "us-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["262264826613"]
  region              = "us-west-2"
}

locals {
  project         = "amethyst"
  oidc_issuer_url = "https://raw.githubusercontent.com/timtorChen/homelab/main/amethyst"
}
