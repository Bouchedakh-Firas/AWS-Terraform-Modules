output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector"
  value       = aws_guardduty_detector.main.id
}

output "guardduty_organization_configuration" {
  description = "GuardDuty organization configuration status"
  value       = aws_guardduty_organization_configuration.main.auto_enable
}
