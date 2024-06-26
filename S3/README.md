<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.53.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.kms_role](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.kms_role_policy](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/iam_role_policy) | resource |
| [aws_s3_bucket.data_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.acl](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.S3-logging](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_object_lock_configuration.object_lock](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.allow_access_from_another_account](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.bucket-encryption](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versionning](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/data-sources/caller_identity) | data source |
| [aws_kms_key.by_alias_arn](https://registry.terraform.io/providers/hashicorp/aws/5.53.0/docs/data-sources/kms_key) | data source |
| [template_file.iam-policy-template](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources in | `string` | `"eu-west-3"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS key ID to use for encryption (if not creating a new key) | `string` | `null` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket | `string` | `"data-source-firas"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The ID of the S3 bucket |
<!-- END_TF_DOCS -->