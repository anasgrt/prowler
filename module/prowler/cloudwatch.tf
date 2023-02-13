resource "aws_cloudwatch_event_rule" "prowler_event_rule" {
  name                = "periodical-daily-cloudwatch-event"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "codebuild_event_target" {
  rule      = aws_cloudwatch_event_rule.prowler_event_rule.name
  target_id = "SendToCodeBuild"
  arn       = aws_codebuild_project.prowler_codebuild_project.arn
  role_arn  = aws_iam_role.codebuild_cloudwatch_trigger_role.arn
}

data "aws_iam_policy_document" "codebuild_cloudwatch_trigger_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild_cloudwatch_trigger_role" {
  name               = "prowler-codebuild-project-trigger-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_cloudwatch_trigger_role.json
}

data "aws_iam_policy_document" "codebuild_cloudwatch_trigger_policy" {
  statement {
    actions   = ["CodeBuild:StartBuild"]
    resources = [aws_codebuild_project.prowler_codebuild_project.arn]
  }
}

resource "aws_iam_role_policy" "codebuild_cloudwatch_trigger_policy" {
  name   = "prowler-codebuild-project-cloudwatch-policy"
  role   = aws_iam_role.codebuild_cloudwatch_trigger_role.id
  policy = data.aws_iam_policy_document.codebuild_cloudwatch_trigger_policy.json
}





