# Site OIDC docs on S3 public bucket
resource "aws_s3_bucket" "kubernetes-oidc" {
  bucket = "${local.project}-kubernetes-oidc"
}

resource "aws_s3_bucket_public_access_block" "frontend_public_access" {
  bucket                  = aws_s3_bucket.kubernetes-oidc.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "kubernetes-oidc" {
  bucket = aws_s3_bucket.kubernetes-oidc.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.kubernetes-oidc.id}/*",
        "Condition" : {
          "Bool" : {
            "aws:SecureTransport" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.kubernetes-oidc.id}/*",
      }
    ]
  })
}

# OIDC provider
data "tls_certificate" "kubernetes-oidc" {
  url = "https://${aws_s3_bucket.kubernetes-oidc.bucket_regional_domain_name}"
}

resource "aws_iam_openid_connect_provider" "kubernetes-oidc" {
  url            = "https://${aws_s3_bucket.kubernetes-oidc.bucket_regional_domain_name}"
  client_id_list = ["sts.amazonaws.com"]
  # TODO: remove me
  # certificate thumbprints is not required for JWKs on S3 bucket
  thumbprint_list = [data.tls_certificate.kubernetes-oidc.certificates[0].sha1_fingerprint]
}

output "kubernetes-oidc-bucket" {
  value = "s3://${aws_s3_bucket.kubernetes-oidc.id}"
}

output "kubernetes-oidc-provider-url" {
  value = "https://${aws_s3_bucket.kubernetes-oidc.bucket_regional_domain_name}"
}
