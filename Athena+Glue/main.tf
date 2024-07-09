
# Define the IAM Role for Glue Crawler
resource "aws_iam_role" "crawler_role" {
  name = "AWSGlueServiceRole-AthenaPolicy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "AWSGlueServiceRole-AthenaPolicy"
  }
}

# Template file for inline policy for KMS
data "template_file" "iam_kms_policy_template" {
  template = file("${path.module}/Policies/KMSCrawlerPolicy.json.tpl")

  vars = {
    sid_name = "PolicyGlueCrawlerKMSOperations"
    kms-arn  = var.s3_kms_arn
  }
}

# Template file for inline policy for S3
data "template_file" "iam_s3_policy_template" {
  template = file("${path.module}/Policies/AWSGlueServiceRole-Athena-Test-EZCRC-s3Policy.json.tpl")

  vars = {
    sid_name   = "PolicyGlueCrawlerS3Operations"
    bucket-arn = var.bucket_data_source_arn
  }
}

# Attach the required policy to the role
resource "aws_iam_role_policy_attachment" "required_policy_attachment" {
  role       = aws_iam_role.crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Attach the inline policy for KMS to the role
resource "aws_iam_role_policy" "inline_policy" {
  name   = "GlueCrawlerKMSPolicy"
  role   = aws_iam_role.crawler_role.id
  policy = data.template_file.iam_kms_policy_template.rendered
}

# Attach the inline policy for S3 to the role
resource "aws_iam_role_policy" "inline_policy_s3" {
  name   = "GlueCrawlerS3Policy"
  role   = aws_iam_role.crawler_role.id
  policy = data.template_file.iam_s3_policy_template.rendered
}



resource "aws_glue_catalog_database" "glue_health_database" {
  name = var.database_name
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = aws_glue_catalog_database.glue_health_database.name
  name          = "Athena-health-crawler"
  role          = aws_iam_role.crawler_role.arn

  s3_target {
    path = var.bucket_data_source
  }
  depends_on = [aws_glue_catalog_database.glue_health_database]
}


/////Working kms policy to be added to the keyh policy ///
/* 
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow administration of the key for User_CLI",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:user/User_CLI"
            },
            "Action": [
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
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key for User_CLI",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:user/User_CLI"
            },
            "Action": [
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key for specific role",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:role/AWSGlueServiceRole-AthenaPolicy"
            },
            "Action": [
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow AWS Glue to use the key",
            "Effect": "Allow",
            "Principal": {
                "Service": "glue.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow administration of the key for specific role",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:role/AWSGlueServiceRole-AthenaPolicy"
            },
            "Action": [
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
            "Resource": "*"
        }
    ]
}
 */

//////////////////////////////////////////////////////

////OLD KMS policy //////////
/* 
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow administration of the key for User_CLI",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:user/User_CLI"
            },
            "Action": [
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
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key for User_CLI",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::471112643196:user/User_CLI"
            },
            "Action": [
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key for specific role",
            "Effect": "Allow",
            "Principal": {
                "AWS": "AROAW3MEAOJ6G27OCZ3JM"
            },
            "Action": [
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow AWS Glue to use the key",
            "Effect": "Allow",
            "Principal": {
                "Service": "glue.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow administration of the key for specific role",
            "Effect": "Allow",
            "Principal": {
                "AWS": "AROAW3MEAOJ6G27OCZ3JM"
            },
            "Action": [
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
            "Resource": "*"
        }
    ]
} */
