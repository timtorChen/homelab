# Parameter store secrets
data "aws_ssm_parameter" "b2" {
  name = "/terraform/b2"
}
