resource "aws_s3_bucket" "loki" {
  provider = aws.ceph-fast
  bucket   = "${local.project}-loki"
}

resource "aws_s3_bucket_policy" "loki" {
  provider = aws.ceph-fast
  bucket   = aws_s3_bucket.loki.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Principal" : {
          "AWS" : ["arn:aws:iam:::user/loki"]
        }
        "Action" : [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        "Effect" : "Allow"
        "Resource" : [
          "${aws_s3_bucket.loki.arn}",
          "${aws_s3_bucket.loki.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket" "mimir" {
  provider = aws.ceph-fast
  bucket   = "${local.project}-mimir"
}

resource "aws_s3_bucket_policy" "mimir" {
  provider = aws.ceph-fast
  bucket   = aws_s3_bucket.mimir.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Principal" : {
          "AWS" : "arn:aws:iam:::user/mimir"
        }
        "Action" : [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        "Effect" : "Allow"
        "Resource" : [
          "${aws_s3_bucket.mimir.arn}",
          "${aws_s3_bucket.mimir.arn}/*"
        ]
      }
    ]
  })
}

