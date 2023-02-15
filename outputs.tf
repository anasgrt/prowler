output "s3_bucket_arn" {
  description = "S3 Bucket ARN"
  value = aws_s3_bucket.prowlerBucket.arn
}

output "s3_bucket_name" {
  description = "S3 Bucket Name (ID)"
  value = aws_s3_bucket.prowlerBucket.id
}

output "codebuild_project_arn" {
  description = "CodeBuild Project ARN"
  value = aws_codebuild_project.prowler_codebuild_project.arn
}

output "cloudwatch_event_rule_id" {
  description = "Cloudwatch event rule id"
  value = aws_cloudwatch_event_rule.prowler_event_rule.id
}

output "S3_bucket_domain_name" {
  description = "S3 Bucket Domain Name"
  value = aws_s3_bucket.prowlerBucket.bucket_domain_name
}