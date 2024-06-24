data "aws_caller_identity" "current" {}

resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_guardduty_organization_configuration" "main" {
  detector_id = aws_guardduty_detector.main.id
  auto_enable = true
}
