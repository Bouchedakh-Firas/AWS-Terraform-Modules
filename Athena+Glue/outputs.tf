output "glue_crawler_role_arn" {
  description = "The ARN of the Glue Crawler IAM role"
  value       = aws_iam_role.crawler_role.arn
}

output "glue_crawler_role_name" {
  description = "The name of the Glue Crawler IAM role"
  value       = aws_iam_role.crawler_role.name
}

output "required_policy_attachment_id" {
  description = "The ID of the required policy attachment"
  value       = aws_iam_role_policy_attachment.required_policy_attachment.id
}

output "inline_policy_attachment_name" {
  description = "The name of the inline policy attached to the Glue Crawler role"
  value       = aws_iam_role_policy.inline_policy.name
}
