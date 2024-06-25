variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-3"
}

variable "kms_key_id" {
  description = "The KMS key ID to use for encryption (if not creating a new key)"
  type        = string
  default     = null
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "data-source-firas"
}
