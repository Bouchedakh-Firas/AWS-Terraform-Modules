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
