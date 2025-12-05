# Parameter store secrets
data "aws_ssm_parameter" "mikrotik" {
  name = "/terraform/mikrotik"
}

locals {
  mikrotik_username = jsondecode(data.aws_ssm_parameter.mikrotik.value)["username"]
  mikrotik_password = jsondecode(data.aws_ssm_parameter.mikrotik.value)["password"]
}
