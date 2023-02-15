resource "aws_s3_bucket" "prowlerBucket" {
  bucket = "prowler-kabisa-bucket1985"
}

data "aws_iam_policy_document" "prowler_codebuild_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "prowler_codebuild_role" {
  name               = "prowler-codebuild-project-role"
  assume_role_policy = data.aws_iam_policy_document.prowler_codebuild_role.json
}

resource "aws_iam_role_policy_attachment" "codebuild_deploy" {
  role       = aws_iam_role.prowler_codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

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
      name  = "access_key_id"
      value = var.access_key_id
    }

    environment_variable {
      name  = "secret_key"
      value = var.secret_key
    }

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



