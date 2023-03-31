// Codebuild IAM role:
resource "aws_iam_role" "prowler" {
  name                = "security_assessments_prowler_codebuild"
  managed_policy_arns = ["arn:aws:iam::aws:policy/SecurityAudit", "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
  assume_role_policy  = data.aws_iam_policy_document.prowler_assume.json
}

// Policies attached to Codebuild IAM role:
data "aws_iam_policy_document" "prowler_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

// Policies for S3 bucket and Cloudwatch logs with attachments to Codebuild Iam role:
resource "aws_iam_policy" "prowler_bucket" {
  name        = "prowler_bucket"
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
          "${aws_s3_bucket.security_assessments.arn}",
          "${aws_s3_bucket.security_assessments.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "prowler_bucket" {
  policy_arn = aws_iam_policy.prowler_bucket.arn
  role       = aws_iam_role.prowler.name
}

resource "aws_iam_policy" "prowler_log" {
  name        = "prowler_log"
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

resource "aws_iam_role_policy_attachment" "prowler_log" {
  policy_arn = aws_iam_policy.prowler_log.arn
  role       = aws_iam_role.prowler.name
}


resource "aws_iam_policy" "prowler_additions" {
  name        = "prowler_additions"
  description = "Additional Read-only Permissions need for several checks"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "account:Get*",
          "appstream:Describe*",
          "appstream:List*",
          "codeartifact:List*",
          "codebuild:BatchGet*",
          "ds:Describe*",
          "ds:Get*",
          "ds:List*",
          "ec2:GetEbsEncryptionByDefault",
          "ecr:Describe*",
          "elasticfilesystem:DescribeBackupPolicy",
          "glue:GetConnections",
          "glue:GetSecurityConfiguration*",
          "glue:SearchTables",
          "lambda:GetFunction*",
          "macie2:GetMacieSession",
          "s3:GetAccountPublicAccessBlock",
          "shield:DescribeProtection",
          "shield:GetSubscriptionState",
          "ssm:GetDocument",
          "support:Describe*",
          "tag:GetTagKeys",
          "organizations:DescribeOrganization",
          "organizations:ListPolicies*",
          "organizations:DescribePolicy"
        ],
        Resource = "*",
        Effect   = "Allow",
        Sid      = "AllowMoreReadForProwler"
      },
      {
        Effect = "Allow",
        Action = [
          "apigateway:GET"
        ],
        Resource = [
          "arn:aws:apigateway:*::/restapis/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "prowler_additions" {
  policy_arn = aws_iam_policy.prowler_additions.arn
  role       = aws_iam_role.prowler.name
}


resource "aws_iam_policy" "prowler_security_hub" {
  name        = "prowler_security_hub"
  description = "Policy to send findings to Security Hub"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "securityhub:BatchImportFindings",
          "securityhub:GetFindings"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "prowler_security_hub" {
  policy_arn = aws_iam_policy.prowler_security_hub.arn
  role       = aws_iam_role.prowler.name
}
