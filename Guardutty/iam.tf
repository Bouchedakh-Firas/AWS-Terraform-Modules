resource "aws_iam_role" "guardduty_role" {
  name = "GuardDutyServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "guardduty.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "guardduty_policy" {
  name = "GuardDutyPolicy"
  role = aws_iam_role.guardduty_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeFlowLogs",
          "s3:GetBucketLogging",
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy",
          "cloudtrail:DescribeTrails",
          "cloudtrail:GetTrailStatus",
          "cloudtrail:ListTags",
          "cloudtrail:ListTrails"
        ]
        Resource = "*"
      }
    ]
  })
}
