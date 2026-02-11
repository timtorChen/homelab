resource "b2_application_key" "grafana" {
  key_name     = "grafana"
  bucket_ids   = [b2_bucket.grafana.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "nextcloud" {
  key_name     = "nextcloud"
  bucket_ids   = [b2_bucket.nextcloud.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "immich" {
  key_name     = "immich"
  bucket_ids   = [b2_bucket.immich.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "miniflux" {
  key_name     = "miniflux"
  bucket_ids   = [b2_bucket.miniflux.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "vaultwarden" {
  key_name     = "vaultwarden"
  bucket_ids   = [b2_bucket.vaultwarden.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "unifi-controller" {
  key_name     = "unifi-controller"
  bucket_ids   = [b2_bucket.unifi-controller.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "navidrome" {
  key_name     = "navidrome"
  bucket_ids   = [b2_bucket.navidrome.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

resource "b2_application_key" "etcd-backup" {
  key_name     = "etcd-backup"
  bucket_ids   = [b2_bucket.etcd-backup.bucket_id]
  capabilities = local.b2_read_write_capabilities
}

