resource "aws_s3_bucket" "prowlerBucket" {
  bucket        = "prowler-kabisa-bucket1985"
  force_destroy = true
}
// Codebuild IAM role:
resource "aws_iam_role" "prowler_codebuild_role" {
  name               = "codebuild_bucket_role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
}

// Ploicies attached to Codebuild IAM role:
data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

// Policies for S3 bucket and Cloudwatch logs with attachments to Codebuild Iam role:
resource "aws_iam_policy" "codebuild_bucket_policy" {
  name        = "codebuild_bucket_policy"
  description = "Policy that allows CodeBuild to put objects in S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.prowlerBucket.arn}",
          "${aws_s3_bucket.prowlerBucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_bucket_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_bucket_policy.arn
  role       = aws_iam_role.prowler_codebuild_role.name
}

resource "aws_iam_policy" "codebuild_log_policy" {
  name        = "codebuild_log_policy"
  description = "Policy that allows CodeBuild to create CloudWatch Logs log streams"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_log_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_log_policy.arn
  role       = aws_iam_role.prowler_codebuild_role.name
}

// Codebuild infrastructure:
resource "aws_codebuild_project" "prowler_codebuild_project" {
  name         = "prowler-codebuild-project"
  description  = "Prowler Codebuild Project"
  service_role = aws_iam_role.prowler_codebuild_role.arn

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.prowlerBucket.id
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




