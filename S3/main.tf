################KMS###############

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "S3_data_bucket_key" {
  description             = "S3 data encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "key-default-1",
    Statement = [
      {
        Sid    = "Enable IAM User Permissions",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
      },
      {
        Sid    = "Allow administration of the key",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/User_CLI"
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
        Sid    = "Allow use of the key",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/User_CLI"
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
  tags = {
    Name = "S3-KMS"
  }
}

##########################S3######################
resource "aws_s3_bucket" "data_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "S3-datasource"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.data_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [aws_s3_bucket_policy.allow_access_from_another_account]
}

resource "aws_s3_bucket_acl" "acl" {
  bucket     = aws_s3_bucket.data_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_versioning" "versionning" {
  bucket = aws_s3_bucket.data_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encryption" {
  bucket = aws_s3_bucket.data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.S3_data_bucket_key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

##############S3 Policies#############################

data "template_file" "iam-policy-template" {
  template = file("${path.module}/Policies/S3Tls-Bucket-Policy.json.tpl")

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

##############IAM Role for KMS########################

resource "aws_iam_role" "kms_role" {
  name = "KMSRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "KMSRole"
  }
}

resource "aws_iam_role_policy" "kms_role_policy" {
  name = "KMSRolePolicy"
  role = aws_iam_role.kms_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = aws_kms_key.S3_data_bucket_key.arn
      }
    ]
  })
}
