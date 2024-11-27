resource "cloudflare_zero_trust_tunnel_cloudflared" "homelab" {
  account_id = local.account_id
  name       = "homelab"
  secret     = local.cloudflare_tunnel_homelab_secret
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "homelab" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab.id

  config {
    warp_routing {
      enabled = true
    }
    # "Networks > Tunnels > Public Hostname" on web
    dynamic "ingress_rule" {
      for_each = local.homelab_public_ingress_rules
      iterator = rule
      content {
        hostname = try(rule.value.hostname, null)
        service  = rule.value.service
      }
    }
  }
}

# "Networks > Tunnels > Private Network" on web,
# the added private network item will reconcile to "Network > Routes" 
resource "cloudflare_zero_trust_tunnel_route" "homelab" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab.id
  network    = local.homelab_network_cidr
}

# default device profile
resource "cloudflare_zero_trust_device_profiles" "default" {
  account_id           = local.account_id
  default              = true
  name                 = "Default"
  description          = "Default profile"
  captive_portal       = 180
  allow_mode_switch    = true
  tunnel_protocol      = "wireguard"
  service_mode_v2_mode = "warp"
  # TODO: support argument after 5.0.0
  # lan_allow_minutes = 0 
}

# local fallback domain is bound to account
resource "cloudflare_zero_trust_local_fallback_domain" "default" {
  account_id = local.account_id

  dynamic "domains" {
    for_each = local.homelab_private_domains
    iterator = domain
    content {
      suffix     = domain.value
      dns_server = local.homelab_dns_server
    }
  }
}
