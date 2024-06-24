variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "email" {
  description = "The email address to use for GuardDuty notifications"
  type        = string
  default     = "your-email@example.com"
}
