terraform {
  required_version = "~> 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
  }
  backend "s3" {
    bucket         = "amethyst-terraform-backend"
    key            = "homelab/local"
    dynamodb_table = "tfstate-lock"
    region         = "us-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["262264826613"]
  region              = "us-west-2"
}

provider "aws" {
  alias  = "ceph-fast"
  region = "us-east-1" # it just works
  endpoints {
    s3 = "https://s3-fast.timtor.dev"
  }
  access_key                  = local.ceph_s3_access_key
  secret_key                  = local.ceph_s3_secret_key
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  s3_use_path_style           = true
}

locals {
  project         = "amethyst"
  oidc_issuer_url = "https://raw.githubusercontent.com/timtorChen/homelab/main/amethyst"
}
