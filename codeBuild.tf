// Codebuild infrastructure:
resource "aws_codebuild_project" "prowler_codebuild_project" {
  name         = "prowler-codebuild-project"
  description  = "Prowler Codebuild Project"
  service_role = aws_iam_role.prowler_codebuild_role.arn

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.security_assessments.id
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "default_region"
      value = var.default_region
    }
    environment_variable {
      name  = "prowler_version"
      value = var.prowler_version
    }

  }
  source {
    type      = "NO_SOURCE"
    buildspec = file("${path.module}/buildspec.yml")
  }
  tags = {
    Environment = "Prowler"
  }
}

