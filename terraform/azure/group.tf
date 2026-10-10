# Security groups
resource "azuread_group" "admin" {
  display_name            = "admin"
  description             = "Cluster administrators (terraform)"
  security_enabled        = true
  prevent_duplicate_names = true
}

resource "azuread_group" "grafana_super_admin" {
  display_name            = "grafana-super-admin"
  description             = "Grafana super administrators (terraform)"
  security_enabled        = true
  prevent_duplicate_names = true
}

resource "azuread_group" "grafana_admin" {
  display_name            = "grafana-admin"
  description             = "Grafana administrators (terraform)"
  security_enabled        = true
  prevent_duplicate_names = true
}

resource "azuread_group" "grafana_editor" {
  display_name            = "grafana-editor"
  description             = "Grafana editors (terraform)"
  security_enabled        = true
  prevent_duplicate_names = true
}

resource "azuread_group" "grafana_viewer" {
  display_name            = "grafana-viewer"
  description             = "Grafana viewers (terraform)"
  security_enabled        = true
  prevent_duplicate_names = true
}

# Output
output "entra_group_admin_object_id" {
  value = azuread_group.admin.object_id
}

output "entra_group_grafana_super_admin_object_id" {
  value = azuread_group.grafana_super_admin.object_id
}

output "entra_group_grafana_admin_object_id" {
  value = azuread_group.grafana_admin.object_id
}

output "entra_group_grafana_editor_object_id" {
  value = azuread_group.grafana_editor.object_id
}

output "entra_group_grafana_viewer_object_id" {
  value = azuread_group.grafana_viewer.object_id
}
