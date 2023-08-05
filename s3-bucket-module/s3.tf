# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest

module "hyeonju-s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.1"

  bucket = "hyeonju-tf-bucket"

  acl                      = "public-read"
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  attach_policy = true
  policy        = data.aws_iam_policy_document.hyeonju-s3-bucket-policy.json

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website-test.hashicorp.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    {
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
    }
  ]

  lifecycle_rule = [
    {
      id      = "dev_expiration_90days"
      enabled = true

      filter = {
        prefix = "config/"
      }

      expiration = {
        days                         = 90
        expired_object_delete_marker = true
      }
    }
  ]
}

data "aws_iam_policy_document" "hyeonju-s3-bucket-policy" {
  statement {
    sid = "AddPublicReadCannedAcl"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      module.hyeonju-s3-bucket.s3_bucket_arn,
      "${module.hyeonju-s3-bucket.s3_bucket_arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["985984781526"]
    }
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["public-read"]
    }
  }
  statement {
    sid = "PublicReadGetObject"
    actions = [
      "s3:GetObject"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      "${module.hyeonju-s3-bucket.s3_bucket_arn}/*"
    ]
  }
}
