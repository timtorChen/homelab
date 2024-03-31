data "aws_caller_identity" "main" {}

data "aws_region" "main" {}

# Parameter store secrets
data "aws_ssm_parameter" "ceph-admin" {
  name = "/amethyst/ceph-admin"
}

locals {
  ceph_s3_access_key = jsondecode(data.aws_ssm_parameter.ceph-admin.value)["access_key"]
  ceph_s3_secret_key = jsondecode(data.aws_ssm_parameter.ceph-admin.value)["secret_key"]
}