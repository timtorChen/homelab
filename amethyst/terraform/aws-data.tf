data "aws_caller_identity" "main" {}

data "aws_region" "main" {}

data "tls_certificate" "main" {
  url = local.oidc_issuer_url
}
