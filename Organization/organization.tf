/* resource "aws_organizations_organization" "org" {
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
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
 */
