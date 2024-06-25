terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}
provider "aws" {
  default_tags {
    tags = {
      Environment = "Dev"
      Owner       = "firas.bouchedakh@snef.fr"
    }
  }
  region = var.aws_region
}
