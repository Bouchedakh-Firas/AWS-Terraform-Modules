variable "organization_name" {
  description = "The name of the AWS organization"
  type        = string
  default     = "HealthOrg"
}

variable "management_account_email" {
  description = "The email address of the management account"
  type        = string
}

variable "audit_account_email" {
  description = "The email address of the audit account"
  type        = string
}

variable "centralized_logging_account_email" {
  description = "The email address of the centralized logging account"
  type        = string
}

variable "data_account_email" {
  description = "The email address of the data account"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}
