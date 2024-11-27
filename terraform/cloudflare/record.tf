resource "cloudflare_record" "homelab-public" {
  for_each = { for index, rule in local.homelab_public_ingress_rules :
    index => rule
    if try(rule.hostname, null) != null
  }

  zone_id         = local.zone_id
  type            = "CNAME"
  name            = split(".", each.value.hostname)[0]
  content         = "${cloudflare_zero_trust_tunnel_cloudflared.homelab.id}.cfargotunnel.com"
  proxied         = true
  allow_overwrite = true

}

