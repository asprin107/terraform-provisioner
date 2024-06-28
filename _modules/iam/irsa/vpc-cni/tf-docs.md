## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa_role"></a> [irsa\_role](#module\_irsa\_role) | ../common | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.irsa-att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | EKS OIDC provider arn for federation. | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_url"></a> [eks\_oidc\_provider\_url](#input\_eks\_oidc\_provider\_url) | EKS OIDC provider url. | `string` | n/a | yes |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_k8s_service_account_name"></a> [k8s\_service\_account\_name](#input\_k8s\_service\_account\_name) | Kubernetes service account name for IRSA. | `string` | `"aws-node"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | IRSA Name suffix about aws load balancer controller. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_irsa-role-arn"></a> [irsa-role-arn](#output\_irsa-role-arn) | n/a |
| <a name="output_irsa-role-name"></a> [irsa-role-name](#output\_irsa-role-name) | n/a |
