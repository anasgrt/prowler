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
| [aws_cloudwatch_event_rule.prowler_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.codebuild_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_codebuild_project.prowler_codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_iam_role.codebuild_cloudwatch_trigger_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.prowler_codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild_cloudwatch_trigger_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.codebuild_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.prowlerBucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_iam_policy_document.codebuild_cloudwatch_trigger_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_cloudwatch_trigger_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prowler_codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key_id"></a> [access\_key\_id](#input\_access\_key\_id) | default access key id for the AWS prowler user | `string` | `""` | no |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | default AWS region for Prowler Security Assessment | `string` | `""` | no |
| <a name="input_prowler_version"></a> [prowler\_version](#input\_prowler\_version) | Prowler Release Installation Version | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | Cloudwatch event rule expression triggered every day at 12:00pm UTC /NOT Netherlands time zone/ | `string` | `"cron(0 12 * * ? *)"` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | default secret key for the AWS prowler user | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_S3_bucket_domain_name"></a> [S3\_bucket\_domain\_name](#output\_S3\_bucket\_domain\_name) | S3 Bucket Domain Name |
| <a name="output_cloudwatch_event_rule_id"></a> [cloudwatch\_event\_rule\_id](#output\_cloudwatch\_event\_rule\_id) | Cloudwatch event rule id |
| <a name="output_codebuild_project_arn"></a> [codebuild\_project\_arn](#output\_codebuild\_project\_arn) | CodeBuild Project ARN |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 Bucket ARN |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | S3 Bucket Name (ID) |
<!-- END_TF_DOCS -->