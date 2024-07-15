## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.56.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_addon"></a> [addon](#module\_addon) | ../../_modules/eks/addon/v1 | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ../../_modules/eks/cluster/v1 | n/a |
| <a name="module_naming"></a> [naming](#module\_naming) | ../../_modules/naming | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../_modules/network/v1 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.service_sg_for_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [http_http.current_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gha_config_url"></a> [gha\_config\_url](#input\_gha\_config\_url) | The information of the target GitHub URL for the action runner to connect to. | `string` | n/a | yes |
| <a name="input_gha_secret_name"></a> [gha\_secret\_name](#input\_gha\_secret\_name) | Secret name for github action runner auth. it must contain github PAT. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region name. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service name. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_naming"></a> [naming](#output\_naming) | Object associated with naming convention. |
| <a name="output_network"></a> [network](#output\_network) | Result of created network resources. |
