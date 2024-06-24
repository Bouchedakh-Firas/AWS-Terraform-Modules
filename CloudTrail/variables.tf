variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-3"
}

variable "organization_trail_name" {
  description = "The name of the CloudTrail trail"
  type        = string
  default     = "organization-trail"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store CloudTrail logs"
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch Log Group to store CloudTrail logs"
  type        = string
}
