terraform {
  required_version = "~> 1.6.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22.0"
    }
  }
  backend "s3" {
    bucket         = "amethyst-terraform-backend"
    key            = "amethyst"
    dynamodb_table = "tfstate-lock"
    region         = "us-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["262264826613"]
  region              = "us-west-2"
}

locals {
  project         = "amethyst"
  oidc_issuer_url = "https://raw.githubusercontent.com/timtorChen/oidc-test/main/amethyst"
}