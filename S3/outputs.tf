output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.data_bucket.id
}

 output "kms_key_id" {
  description = "The ID of the KMS key"
  value       = aws_kms_key.S3_data_bucket_key.id
}

output "kms_role_arn" {
  description = "The ARN of the KMS role"
  value       = aws_iam_role.kms_role.arn
}
  