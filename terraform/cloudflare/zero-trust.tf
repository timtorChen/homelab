resource "cloudflare_zero_trust_tunnel_cloudflared" "homelab" {
  account_id    = data.cloudflare_account.main.account_id
  name          = "homelab"
  config_src    = "cloudflare"
  tunnel_secret = local.cloudflare_tunnel_homelab_secret
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "homelab" {
  account_id = data.cloudflare_account.main.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab.id
  config = {
    ingress = [
      for rule in local.homelab_public_ingress_rules : {
        hostname = try(rule.hostname, null)
        service  = rule.service
    }]
  }
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "homelab" {
  account_id = data.cloudflare_account.main.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab.id
  network    = local.homelab_network_cidr
}

resource "cloudflare_zero_trust_device_custom_profile" "homelab" {
  account_id        = data.cloudflare_account.main.account_id
  name              = "homelab"
  precedence        = 100
  match             = "identity.email == \"test@timtor.dev\""
  captive_portal    = 180
  allow_mode_switch = true
  tunnel_protocol   = "wireguard"
  switch_locked     = false
  allowed_to_leave  = true
  allow_updates     = true
  auto_connect      = 0
  service_mode_v2 = {
    mode = "warp"
  }
  exclude           = []
  lan_allow_minutes = 0
}

resource "cloudflare_zero_trust_device_custom_profile_local_domain_fallback" "homelab" {
  account_id = data.cloudflare_account.main.account_id
  policy_id  = cloudflare_zero_trust_device_custom_profile.homelab.policy_id
  domains = [
    for domain in local.homelab_private_domains : {
      suffix     = domain
      dns_server = local.homelab_dns_server
  }]
}
