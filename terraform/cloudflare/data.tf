data "aws_ssm_parameter" "cloudflare" {
  name = "/terraform/cloudflare"
}

data "cloudflare_account" "main" {
  filter = {
    name = local.account_name
  }
}

data "cloudflare_zone" "main" {
  filter = {
    name = local.zone
  }
}
