resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = var.log_group_name
  retention_in_days = 365
}
