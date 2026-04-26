terraform {
  required_version = "~> 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.13.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.12.0"
    }
  }
  backend "s3" {
    bucket       = "amethyst-terraform-backend"
    key          = "homelab/github"
    use_lockfile = true
    region       = "us-west-2"
  }
}

provider "github" {}

locals {
  github_labels = {
    "area/core" = {
      color       = "#7db9de" # 勿忘草
      description = "OS, Kubernetes, or platform changes"
    },
    "area/app" = {
      color       = "#a8d8b9" # 白綠
      description = "Application changes"
    },
    "type/feat" = {
      color       = "#fad689" # 淺黃
      description = "Feature or new things"
    },
    "type/migration" = {
      color       = "#d4c5f9"
      description = "Moving in APIs, systems, or architectures"
    },
    "type/bug" = {
      color       = "#336774" # 錆御納戶
      description = "Unexpected behavior"
    },
    "type/chore" = {
      color       = "#bdc0ba" # 白鼠
      description = "Version bumps or boring things"
    },
    "risk/high" = {
      color       = "#f4a7b9" # 一斥染
      description = "High risk of breaking things"
    }
  }
}

# !NOTICE
# github_issue_label id is stored as "repo_name:label_name"
resource "github_issue_label" "main" {
  repository  = "homelab"
  for_each    = local.github_labels
  name        = each.key
  color       = replace(each.value.color, "#", "")
  description = try(each.value.description, null)
}
