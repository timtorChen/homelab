resource "aws_iam_openid_connect_provider" "main" {
  url             = local.oidc_issuer_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.main.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "cert-manager" {
  name = "${local.project}-cert-manager"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:cert-manager:cert-manager",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cert-manager" {
  name = "${local.project}-cert-manager"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/cert-manager"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cert-manager" {
  role       = aws_iam_role.cert-manager.name
  policy_arn = aws_iam_policy.cert-manager.arn
}

resource "aws_iam_role" "cloudflared" {
  name = "${local.project}-cloudflared"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:cloudflared:cloudflared",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cloudflared" {
  name = "${local.project}-cloudflared"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/cloudflared"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudflared" {
  role       = aws_iam_role.cloudflared.name
  policy_arn = aws_iam_policy.cloudflared.arn
}

resource "aws_iam_role" "snmp-exporter-mikrotik" {
  name = "${local.project}-snmp-exporter-mikrotik"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:snmp-exporter-mikrotik:snmp-exporter-mikrotik",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "snmp-exporter-mikrotik" {
  name = "${local.project}-snmp-exporter-mikrotik"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/snmp-exporter-mikrotik"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "snmp-exporter-mikrotik" {
  role       = aws_iam_role.snmp-exporter-mikrotik.name
  policy_arn = aws_iam_policy.snmp-exporter-mikrotik.arn
}

resource "aws_iam_role" "grafana" {
  name = "${local.project}-grafana"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:grafana:grafana",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "grafana" {
  name = "${local.project}-grafana"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/grafana"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "grafana" {
  role       = aws_iam_role.grafana.name
  policy_arn = aws_iam_policy.grafana.arn
}

resource "aws_iam_role" "grafana-postgres-secret-holder" {
  name = "${local.project}-grafana-postgres-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:grafana:grafana-postgres-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "grafana-postgres-secret-holder" {
  name = "${local.project}-grafana-postgres-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/grafana-postgres"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "grafana-postgres-secret-holder" {
  role       = aws_iam_role.grafana-postgres-secret-holder.name
  policy_arn = aws_iam_policy.grafana-postgres-secret-holder.arn
}

resource "aws_iam_role" "loki" {
  name = "${local.project}-loki"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:loki:loki",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "loki" {
  name = "${local.project}-loki"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/loki"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "loki" {
  role       = aws_iam_role.loki.name
  policy_arn = aws_iam_policy.loki.arn
}

resource "aws_iam_role" "mimir" {
  name = "${local.project}-mimir"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mimir:mimir",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "mimir" {
  name = "${local.project}-mimir"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/mimir"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "mimir" {
  role       = aws_iam_role.mimir.name
  policy_arn = aws_iam_policy.mimir.arn
}

resource "aws_iam_role" "unpoller" {
  name = "${local.project}-unpoller"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:unpoller:unpoller",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

}

resource "aws_iam_policy" "unpoller" {
  name = "${local.project}-unpoller"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/unpoller"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "unpoller" {
  role       = aws_iam_role.unpoller.name
  policy_arn = aws_iam_policy.unpoller.arn
}

resource "aws_iam_role" "unifi-controller" {
  name = "${local.project}-unifi-controller"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:unifi-controller:unifi-controller",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "unifi-controller" {
  name = "${local.project}-unifi-controller"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/unifi-controller"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "unifi-controller" {
  role       = aws_iam_role.unifi-controller.name
  policy_arn = aws_iam_policy.unifi-controller.arn
}

resource "aws_iam_role" "unifi-controller-backup-secret-holder" {
  name = "${local.project}-unifi-controller-backup-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:unifi-controller:unifi-controller-backup-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "unifi-controller-backup-secret-holder" {
  name = "${local.project}-unifi-controller-backup-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/unifi-controller-backup"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "unifi-controller-backup-secret-holder" {
  role       = aws_iam_role.unifi-controller-backup-secret-holder.name
  policy_arn = aws_iam_policy.unifi-controller-backup-secret-holder.arn
}

resource "aws_iam_role" "wego" {
  name = "${local.project}-wego"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:wego:wego",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "wego" {
  name = "${local.project}-wego"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/wego"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "wego" {
  role       = aws_iam_role.wego.name
  policy_arn = aws_iam_policy.wego.arn
}

resource "aws_iam_role" "nextcloud" {
  name = "${local.project}-nextcloud"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:nextcloud",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "nextcloud" {
  name = "${local.project}-nextcloud"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/nextcloud"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nextcloud" {
  role       = aws_iam_role.nextcloud.name
  policy_arn = aws_iam_policy.nextcloud.arn
}

resource "aws_iam_role" "nextcloud-backup-secret-holder" {
  name = "${local.project}-nextcloud-backup-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:nextcloud-backup-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "nextcloud-backup-secret-holder" {
  name = "${local.project}-nextcloud-backup-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/nextcloud-backup"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nextcloud-backup-secret-holder" {
  role       = aws_iam_role.nextcloud-backup-secret-holder.name
  policy_arn = aws_iam_policy.nextcloud-backup-secret-holder.arn
}

resource "aws_iam_role" "nextcloud-postgres-secret-holder" {
  name = "${local.project}-nextcloud-postgres-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:nextcloud-postgres-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "nextcloud-postgres-secret-holder" {
  name = "${local.project}-nextcloud-postgres-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/nextcloud-postgres"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nextcloud-postgres-secret-holder" {
  role       = aws_iam_role.nextcloud-postgres-secret-holder.name
  policy_arn = aws_iam_policy.nextcloud-postgres-secret-holder.arn
}

resource "aws_iam_role" "nextcloud-dragonfly" {
  name = "${local.project}-nextcloud-dragonfly"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:nextcloud-dragonfly",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "nextcloud-dragonfly" {
  name = "${local.project}-nextcloud-dragonfly"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/nextcloud-dragonfly"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nextcloud-dragonfly" {
  role       = aws_iam_role.nextcloud-dragonfly.name
  policy_arn = aws_iam_policy.nextcloud-dragonfly.arn
}

resource "aws_iam_role" "vaultwarden" {
  name = "${local.project}-vaultwarden"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:vaultwarden:vaultwarden",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "vaultwarden" {
  name = "${local.project}-vaultwarden"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/vaultwarden"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vaultwarden" {
  role       = aws_iam_role.vaultwarden.name
  policy_arn = aws_iam_policy.vaultwarden.arn
}

resource "aws_iam_role" "vaultwarden-backup" {
  name = "${local.project}-vaultwarden-backup"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:vaultwarden:vaultwarden-backup",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "vaultwarden-backup" {
  name = "${local.project}-vaultwarden-backup"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/vaultwarden-backup"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vaultwarden-backup" {
  role       = aws_iam_role.vaultwarden-backup.name
  policy_arn = aws_iam_policy.vaultwarden-backup.arn
}

resource "aws_iam_role" "navidrome" {
  name = "${local.project}-navidrome"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:navidrome",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "navidrome" {
  name = "${local.project}-navidrome"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/navidrome"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "navidrome" {
  role       = aws_iam_role.navidrome.name
  policy_arn = aws_iam_policy.navidrome.arn
}

resource "aws_iam_role" "navidrome-backup-secret-holder" {
  name = "${local.project}-navidrome-backup-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:navidrome-backup-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "navidrome-backup-secret-holder" {
  name = "${local.project}-navidrome-backup-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/navidrome-backup"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "navidrome-backup-secret-holder" {
  role       = aws_iam_role.navidrome-backup-secret-holder.name
  policy_arn = aws_iam_policy.navidrome-backup-secret-holder.arn
}

resource "aws_iam_role" "immich" {
  name = "${local.project}-immich"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:immich",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "immich" {
  name = "${local.project}-immich"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/immich"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "immich" {
  role       = aws_iam_role.immich.name
  policy_arn = aws_iam_policy.immich.arn
}

resource "aws_iam_role" "immich-backup-secret-holder" {
  name = "${local.project}-immich-backup-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:immich-backup-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "immich-backup-secret-holder" {
  name = "${local.project}-immich-backup-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/immich-backup"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "immich-backup-secret-holder" {
  role       = aws_iam_role.immich-backup-secret-holder.name
  policy_arn = aws_iam_policy.immich-backup-secret-holder.arn
}

resource "aws_iam_role" "immich-postgres-secret-holder" {
  name = "${local.project}-immich-postgres-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:immich-postgres-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "immich-postgres-secret-holder" {
  name = "${local.project}-immich-postgres-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/immich-postgres"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "immich-postgres-secret-holder" {
  role       = aws_iam_role.immich-postgres-secret-holder.name
  policy_arn = aws_iam_policy.immich-postgres-secret-holder.arn
}

resource "aws_iam_role" "immich-dragonfly" {
  name = "${local.project}-immich-dragonfly"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:immich-dragonfly",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "immich-dragonfly" {
  name = "${local.project}-immich-dragonfly"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/immich-dragonfly"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "immich-dragonfly" {
  role       = aws_iam_role.immich-dragonfly.name
  policy_arn = aws_iam_policy.immich-dragonfly.arn
}

resource "aws_iam_role" "immich-typesense" {
  name = "${local.project}-immich-typesense"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:immich-typesense",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "immich-typesense" {
  name = "${local.project}-immich-typesense"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/immich-typesense"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "immich-typesense" {
  role       = aws_iam_role.immich-typesense.name
  policy_arn = aws_iam_policy.immich-typesense.arn
}

resource "aws_iam_role" "immich-typesense-backup-secret-holder" {
  name = "${local.project}-immich-typesense-backup-secret-holder"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.main.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${aws_iam_openid_connect_provider.main.url}:sub" : "system:serviceaccount:mydata:immich-typesense-backup-secret-holder",
            "${aws_iam_openid_connect_provider.main.url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "immich-typesense-backup-secret-holder" {
  name = "${local.project}-immich-typesense-backup-secret-holder"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:GetParameters",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.main.name}:${data.aws_caller_identity.main.account_id}:parameter/amethyst/immich-typesense-backup"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "immich-typesense-backup-secret-holder" {
  role       = aws_iam_role.immich-typesense-backup-secret-holder.name
  policy_arn = aws_iam_policy.immich-typesense-backup-secret-holder.arn
}
