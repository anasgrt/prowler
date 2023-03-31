data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "security_assessments" {
  bucket        = "security-assessments-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}
