variable "bucket_data_source_arn" {
  type        = string
  description = "Bucket ARN for the crawler permission"
  default     = "arn:aws:s3:::data-source-firas/health/"
}

variable "bucket_data_source" {
  type        = string
  description = "Bucket path for the crawler"
  default     = "s3://data-source-firas/health/"
}

variable "athena_bucket_output" {
  type        = string
  description = "Bucket ARN for the Athena outputs"
  default     = "arn:aws:s3:::data-source-firas/athena-outputs"
}

variable "database_name" {
  type        = string
  description = "Glue database name"
  default     = "default-health-data-database"
}

variable "s3_kms_arn" {
  type        = string
  description = "KMS ARN for the S3 bucket encryption"
  default     = "arn:aws:kms:eu-west-3:471112643196:key/c86839c9-cfe7-4561-8362-78a302543e6a"
}




