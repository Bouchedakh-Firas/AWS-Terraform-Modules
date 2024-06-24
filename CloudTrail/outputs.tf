output "cloudtrail_s3_bucket" {
  description = "The name of the S3 bucket storing CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail.bucket
}

output "cloudtrail_log_group" {
  description = "The name of the CloudWatch Log Group storing CloudTrail logs"
  value       = aws_cloudwatch_log_group.cloudtrail.name
}

output "cloudtrail_name" {
  description = "The name of the CloudTrail"
  value       = aws_cloudtrail.organization_trail.name
}
