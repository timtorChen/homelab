data "aws_ssm_parameter" "cloudflare" {
  name = "/terraform/cloudflare"
}

data "cloudflare_accounts" "main" {}

data "cloudflare_zone" "main" {
  name = local.zone
}
