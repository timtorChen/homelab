data "sops_file" "infra_secret" {
  source_file = "secret.sops.yaml"
}

#- proxmox
locals {
  pm_api_url  = "https://192.168.254.1:8006/api2/json"
  pm_user     = "tf-prov@pve"
  pm_password = data.sops_file.infra_secret.data["secret_pm_password"]

  server_1_password = data.sops_file.infra_secret.data["secret_node_server_1_password"]
  server_2_password = data.sops_file.infra_secret.data["secret_node_server_2_password"]
  agent_1_password  = data.sops_file.infra_secret.data["secret_node_agent_1_password"]
  agent_2_password  = data.sops_file.infra_secret.data["secret_node_agent_2_password"]
  agent_3_password  = data.sops_file.infra_secret.data["secret_node_agent_3_password"]

  template_ubuntu2004 = "ubuntu-2004-golden"
  public_keys         = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLbEPIl3h8xFhpa8fBrZIr2PTJIQvfYwyg4sgyPDlH+Auio7eudxJTgjIey32QH1Mu64rDLKhdvPfrFP5IRoF9UGgvpK9LsXJ9D9Imqp+dBZRe7n7OYxiPQToGOSD03CX0JwgUbSP7EkWbo9q4cdhkGJkroYyPP/6afw6TU9NA2j3kRnHfOXKTFf+xuFET5YXoKclTkBPylxSih87jbHK+3aI7j+vQc2H8cx+ydNy0kx+aktRkuoS1DHUeXzJlDBffeDom/Ey5o9dy7ZYNdtkoWFy/G2QnXcprYNAwZIEZB2Dikj6jHYCxjsGXoH4JvruTdmtoB7fU9nbdzTahbu9FvfeKY/A4X6IlQ9JEkvcCzt5XoZyue1jRLoO1KAbcP8J0E5VVH1hBVRy4opRX7JmBQKpPeBjCWUYTv67BJCAY2n8RS7HwcwNXh34wJxw+bCmq5afc3F1vq3CbRMNAJXAss/fCfDJh3sTE36sdxuhkw4svoamshcjUHQhxTNKQLWk= timtor@timtor-hp
    EOF

  k3s_nodes = {
    "server-vm-1" = {
      id             = 101
      server         = true
      cores          = 1
      memory         = 4096
      size           = "50G"
      storage        = "vm-nvme"
      template       = local.template_ubuntu2004
      sshkeys        = local.public_keys
      user           = "ubuntu"
      password       = local.server_1_password
      ipconfig0      = "ip=192.168.255.1/21,gw=192.168.248.1"
      ssh_forward_ip = "192.168.255.1"
    },
    "server-vm-2" = {
      id             = 102
      server         = true
      cores          = 1
      memory         = 4096
      size           = "50G"
      storage        = "vm-nvme"
      template       = local.template_ubuntu2004
      sshkeys        = local.public_keys
      user           = "ubuntu"
      password       = local.server_1_password
      ipconfig0      = "ip=192.168.255.2/21,gw=192.168.248.1"
      ssh_forward_ip = "192.168.255.2"
    },
    "server-vm-3" = {
      id             = 103
      server         = true
      cores          = 1
      memory         = 4096
      size           = "50G"
      storage        = "vm-nvme"
      template       = local.template_ubuntu2004
      sshkeys        = local.public_keys
      user           = "ubuntu"
      password       = local.server_1_password
      ipconfig0      = "ip=192.168.255.3/21,gw=192.168.248.1"
      ssh_forward_ip = "192.168.255.3"
    },
    "agent-vm-1" = {
      id             = 106
      server         = false
      cores          = 2
      memory         = 8192
      size           = "20G"
      storage        = "vm-ssd"
      template       = local.template_ubuntu2004
      sshkeys        = local.public_keys
      user           = "ubuntu"
      password       = local.agent_1_password
      ipconfig0      = "ip=192.168.255.6/21,gw=192.168.248.1"
      ssh_forward_ip = "192.168.255.6"
    },
    "agent-vm-2" = {
      id             = 107
      server         = false
      cores          = 2
      memory         = 8192
      size           = "20G"
      storage        = "vm-ssd"
      template       = local.template_ubuntu2004
      sshkeys        = local.public_keys
      user           = "ubuntu"
      password       = local.agent_2_password
      ipconfig0      = "ip=192.168.255.7/21,gw=192.168.248.1"
      ssh_forward_ip = "192.168.255.7"
    }
    "agent-vm-3" = {
      id             = 108
      server         = false
      cores          = 2
      memory         = 8192
      size           = "20G"
      storage        = "vm-ssd"
      template       = local.template_ubuntu2004
      sshkeys        = local.public_keys
      user           = "ubuntu"
      password       = local.agent_3_password
      ipconfig0      = "ip=192.168.255.8/21,gw=192.168.248.1"
      ssh_forward_ip = "192.168.255.8"
    }
  }
}

#- cloudflare
locals {
  cloudflare_email        = data.sops_file.infra_secret.data["secret_cloudflare_email"]
  cloudflare_api_key      = data.sops_file.infra_secret.data["secret_cloudflare_api_key"]
  cloudflare_home_zone_id = data.sops_file.infra_secret.data["secret_cloudflare_home_zone_id"]
}

#- static
locals {
  home_ipv4 = data.sops_file.infra_secret.data["secret_home_ipv4"]
}
