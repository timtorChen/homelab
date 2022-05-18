terraform {
  required_version = "~> 1.1.9"

  backend "http" {}
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~>2.9.10"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~>0.6.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>3.12.2"
    }
  }
}
