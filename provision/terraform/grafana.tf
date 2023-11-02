provider "grafana" {
  url  = local.grafana_url
  auth = local.grafana_api_key
}

# -- Datasource
resource "grafana_data_source" "mimir-lab" {
  type = "prometheus"
  name = "mimir-lab"
  url  = "https://mimir.s.timtor.dev/prometheus"
  http_headers = {
    "X-Scope-OrgID" = "lab"
  }
}

resource "grafana_data_source" "mimir-garden" {
  type = "prometheus"
  name = "mimir-garden"
  url  = "https://mimir.s.timtor.dev/prometheus"
  http_headers = {
    "X-Scope-OrgID" = "garden"
  }
}

resource "grafana_data_source" "loki_lab" {
  type = "loki"
  name = "loki-lab"
  url  = "https://loki.s.timtor.dev"
  http_headers = {
    "X-Scope-OrgID" = "lab"
  }
}

resource "grafana_data_source" "loki_garden" {
  type = "loki"
  name = "loki-garden"
  url  = "https://loki.s.timtor.dev"
  http_headers = {
    "X-Scope-OrgID" = "garden"
  }
}

# -- Alerting
resource "grafana_contact_point" "discord" {
  name = "discord"
  discord {
    url = local.grafana_discord_webhook_url
  }
}

resource "grafana_notification_policy" "main" {
  # the default contact point
  contact_point = grafana_contact_point.discord.name
  # use "..." as no grouping
  group_by = ["..."]
}