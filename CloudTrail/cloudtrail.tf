resource "aws_cloudtrail" "organization_trail" {
  name                          = var.organization_trail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail.bucket
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail.arn
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_log_role.arn
  is_organization_trail         = true
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}

resource "aws_iam_role" "cloudtrail_log_role" {
  name = "CloudTrail_CloudWatchLogs_Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudtrail_log_policy" {
  name = "CloudTrail_CloudWatchLogs_Policy"
  role = aws_iam_role.cloudtrail_log_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
      }
    ]
  })
}
