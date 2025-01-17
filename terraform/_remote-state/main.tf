terraform {
  required_version = "~> 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
  }
}

provider "aws" {
  allowed_account_ids = ["262264826613"]
}

resource "aws_s3_bucket" "backend" {
  bucket = "amethyst-terraform-backend"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name           = "tfstate-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
