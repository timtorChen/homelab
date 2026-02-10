resource "b2_bucket" "grafana" {
    bucket_name = "${local.bucket_prefix}-grafana"
    bucket_type = "allPrivate"

    lifecycle_rules {
      file_name_prefix = ""
      days_from_hiding_to_deleting = "1"
      days_from_starting_to_canceling_unfinished_large_files = "1"
    }
}

resource "b2_bucket" "nextcloud" {
    bucket_name = "${local.bucket_prefix}-nextcloud"
    bucket_type = "allPrivate"

    lifecycle_rules {
      file_name_prefix = ""
      days_from_hiding_to_deleting = "1"
      days_from_starting_to_canceling_unfinished_large_files = "1"
    }
}

resource "b2_bucket" "immich" {
    bucket_name = "${local.bucket_prefix}-immich"
    bucket_type = "allPrivate"

    lifecycle_rules {
      file_name_prefix = ""
      days_from_hiding_to_deleting = "1"
      days_from_starting_to_canceling_unfinished_large_files = "1"
    }
}

resource "b2_bucket" "miniflux" {
    bucket_name = "${local.bucket_prefix}-miniflux"
    bucket_type = "allPrivate"

    lifecycle_rules {
      file_name_prefix = ""
      days_from_hiding_to_deleting = "1"
      days_from_starting_to_canceling_unfinished_large_files = "1"
    }
}

resource "b2_bucket" "vaultwarden" {
    bucket_name = "${local.bucket_prefix}-vaultwarden"
    bucket_type = "allPrivate"
}

resource "b2_bucket" "navidrome" {
    bucket_name = "${local.bucket_prefix}-navidrome"
    bucket_type = "allPrivate"
}

resource "b2_bucket" "unifi-controller" {
    bucket_name = "${local.bucket_prefix}-unifi-controller"
    bucket_type = "allPrivate"
}

resource "b2_bucket" "etcd-backup" {
    bucket_name = "${local.bucket_prefix}-etcd-backup"
    bucket_type = "allPrivate"
}
