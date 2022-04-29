provider "cloudflare" {
  email   = local.cloudflare_email
  api_key = local.cloudflare_api_key
}

resource "cloudflare_record" "cname-mask" {
  zone_id = local.cloudflare_home_zone_id

  type    = "A"
  name    = "cname"
  value   = local.home_ipv4
  proxied = true
  ttl     = 1 # 1 means auto
}
