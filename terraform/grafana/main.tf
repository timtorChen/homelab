terraform {
  required_version = "~> 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "3.15.3"
    }
  }
  backend "s3" {
    bucket         = "amethyst-terraform-backend"
    key            = "homelab/grafana"
    dynamodb_table = "tfstate-lock"
    region         = "us-west-2"
  }
}

provider "grafana" {
  url  = "https://grafana.timtor.dev"
  auth = local.grafana_token
}

resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "prometheus"
  url  = "http://mimir-query-frontend.mimir:8080/prometheus"
}

module "grafana_alert" {
  source  = "timtorChen/grafana-alert/module"
  version = "~> 0.4.0"

  prom_datasource_uid     = grafana_data_source.prometheus.uid
  enable_node_alert       = true
  enable_smartprom_alert  = true
  enable_etcd_alert       = true
  enable_kubernetes_alert = true
  enable_ceph_alert       = true
}
