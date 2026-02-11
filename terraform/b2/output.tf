output "grafana-app-key-id" {
  value = nonsensitive(b2_application_key.grafana.application_key_id)
}

output "grafana-app-key" {
  value = nonsensitive(b2_application_key.grafana.application_key)
}

output "nextcloud-app-key-id" {
  value = nonsensitive(b2_application_key.nextcloud.application_key_id)
}

output "nextcloud-app-key" {
  value = nonsensitive(b2_application_key.nextcloud.application_key)
}

output "immich-app-key-id" {
  value = nonsensitive(b2_application_key.immich.application_key_id)
}

output "immich-app-key" {
  value = nonsensitive(b2_application_key.immich.application_key)
}

output "miniflux-app-key-id" {
  value = nonsensitive(b2_application_key.miniflux.application_key_id)
}

output "miniflux-app-key" {
  value = nonsensitive(b2_application_key.miniflux.application_key)
}

output "vaultwarden-app-key-id" {
  value = nonsensitive(b2_application_key.vaultwarden.application_key_id)
}

output "vaultwarden-app-key" {
  value = nonsensitive(b2_application_key.vaultwarden.application_key)
}

output "navidrome-app-key-id" {
  value = nonsensitive(b2_application_key.navidrome.application_key_id)
}

output "navidrome-app-key" {
  value = nonsensitive(b2_application_key.navidrome.application_key)
}

output "unifi-controller-app-key-id" {
  value = nonsensitive(b2_application_key.unifi-controller.application_key_id)
}

output "unifi-controller-app-key" {
  value = nonsensitive(b2_application_key.unifi-controller.application_key)
}

output "etcd-backup-app-key-id" {
  value = nonsensitive(b2_application_key.etcd-backup.application_key_id)
}

output "etcd-backup-app-key" {
  value = nonsensitive(b2_application_key.etcd-backup.application_key)
}
