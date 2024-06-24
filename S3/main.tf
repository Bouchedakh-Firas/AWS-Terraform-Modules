terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}
provider "aws" {
  region = "eu-west-3"
}
################KMS###############

data "aws_caller_identity" "current" {}


data "aws_kms_key" "by_alias_arn" {
  key_id = "arn:aws:kms:eu-west-3:473868803624:key/50f39e62-d811-493f-a398-3ea85388f567"
}

/* resource "aws_kms_key" "S3_data_bucket_key" {
  description             = "S3 data encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = 20
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/amplify-project"
        },
        Action = [
          "kms:ReplicateKey",
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/amplify-project"
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
      }
    ]
  })
} */

##########################S3######################
resource "aws_s3_bucket" "data_bucket" {
  bucket = "data-source-firas"
  /* depends_on = [aws_kms_key.S3_data_bucket_key] */
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.data_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_policy.allow_access_from_another_account]
}
resource "aws_s3_bucket_acl" "example" {
  bucket     = aws_s3_bucket.data_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.data_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      /*       kms_master_key_id = aws_kms_key.S3_data_bucket_key.arn
 */ kms_master_key_id = data.aws_kms_key.by_alias_arn.key_id
      sse_algorithm                                                                         = "aws:kms"
    }
  }
}

output "bucket_name" {
  value = aws_s3_bucket.data_bucket.id
}

##############S3 Policies#############################

data "template_file" "iam-policy-template" {
  template = file("/Policies/S3Tls-Bucket-Policy.json.tpl")

  vars = {
    sid-name   = "Policy for S3 Access"
    bucket-arn = aws_s3_bucket.data_bucket.arn
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket     = aws_s3_bucket.data_bucket.id
  policy     = data.template_file.iam-policy-template.rendered
  depends_on = [aws_s3_bucket.data_bucket]
}
