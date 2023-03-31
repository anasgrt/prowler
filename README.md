## Authors
Module is maintained by [Anas AL Hamd] (https://github.com/anasnedtech).

## General Notes:
1- Make sure that Cloudwatch(Event Bridge) default bus is in /STARTED/ state in /Schema discovery/)
since the Cloudwatch scheduling is workable only in the default event bus, so it is not possible
to create a new event bus in this code and associate it with this scheduling.

2- Prowler STABLE release version has to be selected "https://github.com/prowler-cloud/prowler/releases", latest version is usually NOT stable and after testing some problems emerged with region filtering in prowler command "prowler aws -f $default_region".

3- Prowler needs (access_key_id , secret_key , default_region) varibles in this terraform code to execute its command in the buildspec.yml (buildcode), so these variables should be modified upon code usage; to be applicable with the account we want to security inspect.

4- Schedule timing in this module is in (UTC) timing.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.prowler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_codebuild_project.prowler_codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_iam_policy.prowler_additions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prowler_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prowler_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prowler_security_hub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_cloudwatch_trigger_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.prowler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild_cloudwatch_trigger_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.prowler_additions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prowler_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prowler_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prowler_security_hub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.security_assessments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.codebuild_cloudwatch_trigger_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_cloudwatch_trigger_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prowler_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | default AWS region for Prowler Security Assessment | `string` | `""` | no |
| <a name="input_prowler_version"></a> [prowler\_version](#input\_prowler\_version) | Prowler Release Installation Version | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | Cloudwatch event rule expression triggered every day at 12:00pm UTC /NOT Netherlands time zone/ | `string` | `"cron(00 12 * * ? *)"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_S3_bucket_domain_name"></a> [S3\_bucket\_domain\_name](#output\_S3\_bucket\_domain\_name) | S3 Bucket Domain Name |
| <a name="output_cloudwatch_event_rule_id"></a> [cloudwatch\_event\_rule\_id](#output\_cloudwatch\_event\_rule\_id) | Cloudwatch event rule id |
| <a name="output_codebuild_project_arn"></a> [codebuild\_project\_arn](#output\_codebuild\_project\_arn) | CodeBuild Project ARN |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 Bucket ARN |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | S3 Bucket Name (ID) |
<!-- END_TF_DOCS -->