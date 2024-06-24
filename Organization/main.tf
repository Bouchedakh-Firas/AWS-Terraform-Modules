provider "aws" {
  region = var.region
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  "guardduty.amazonaws.com"]
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "management_ou" {
  name      = "Management"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "security_ou" {
  name      = "Security"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "data_ou" {
  name      = "Data"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_account" "management_account" {
  name      = "ManagementAccount"
  email     = var.management_account_email
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "audit_account" {
  name      = "AuditAccount"
  email     = var.audit_account_email
  parent_id = aws_organizations_organizational_unit.security_ou.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "centralized_logging_account" {
  name      = "CentralizedLoggingAccount"
  email     = var.centralized_logging_account_email
  parent_id = aws_organizations_organizational_unit.security_ou.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "data_account" {
  name      = "DataAccount"
  email     = var.data_account_email
  parent_id = aws_organizations_organizational_unit.data_ou.id
  role_name = "OrganizationAccountAccessRole"
}

output "organization_id" {
  description = "The ID of the AWS organization"
  value       = aws_organizations_organization.org.id
}

output "management_ou_id" {
  description = "The ID of the Management OU"
  value       = aws_organizations_organizational_unit.management_ou.id
}

output "security_ou_id" {
  description = "The ID of the Security OU"
  value       = aws_organizations_organizational_unit.security_ou.id
}

output "data_ou_id" {
  description = "The ID of the Data OU"
  value       = aws_organizations_organizational_unit.data_ou.id
}

output "management_account_id" {
  description = "The ID of the Management account"
  value       = aws_organizations_account.management_account.id
}

output "audit_account_id" {
  description = "The ID of the Audit account"
  value       = aws_organizations_account.audit_account.id
}

output "centralized_logging_account_id" {
  description = "The ID of the Centralized Logging account"
  value       = aws_organizations_account.centralized_logging_account.id
}

output "data_account_id" {
  description = "The ID of the Data account"
  value       = aws_organizations_account.data_account.id
}
