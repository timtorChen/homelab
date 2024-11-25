# Parameter store secrets
data "aws_ssm_parameter" "grafana" {
  name = "/terraform/grafana"
}

locals {
  grafana_token = jsondecode(data.aws_ssm_parameter.grafana.value)["grafana_token"]
}
