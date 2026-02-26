terraform {
  required_version = "~> 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.34.0"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "~> 0.12.0"
    }
  }
  backend "s3" {
    bucket       = "amethyst-terraform-backend"
    key          = "homelab/b2"
    use_lockfile = true
    region       = "us-west-2"
  }
}

provider "aws" {
  allowed_account_ids = ["262264826613"]
  region              = "us-west-2"
}

provider "b2" {
  application_key_id = local.b2_application_key_id
  application_key    = local.b2_application_key
}

locals {
  bucket_prefix         = "timtor-homelab"
  b2_application_key_id = jsondecode(data.aws_ssm_parameter.b2.value)["application_key_id"]
  b2_application_key    = jsondecode(data.aws_ssm_parameter.b2.value)["application_key"]
  b2_read_write_capabilities = [
    "deleteFiles",
    "listBuckets",
    "listFiles",
    "readBucketEncryption",
    "readBucketReplications",
    "readBuckets",
    "readFiles",
    "shareFiles",
    "writeBucketEncryption",
    "writeBucketReplications",
    "writeFiles"
  ]
}
