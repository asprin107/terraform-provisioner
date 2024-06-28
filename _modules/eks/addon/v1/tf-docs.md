## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa-aws_ebs_csi_driver"></a> [irsa-aws\_ebs\_csi\_driver](#module\_irsa-aws\_ebs\_csi\_driver) | ../../../iam/irsa/aws-ebs-csi-driver | n/a |
| <a name="module_irsa-aws_efs_csi_driver"></a> [irsa-aws\_efs\_csi\_driver](#module\_irsa-aws\_efs\_csi\_driver) | ../../../iam/irsa/aws-efs-csi-driver | n/a |
| <a name="module_irsa-aws_load_balancer_controller"></a> [irsa-aws\_load\_balancer\_controller](#module\_irsa-aws\_load\_balancer\_controller) | ../../../iam/irsa/aws-load-balancer-controller | n/a |
| <a name="module_irsa-aws_mountpoint_s3_csi_driver"></a> [irsa-aws\_mountpoint\_s3\_csi\_driver](#module\_irsa-aws\_mountpoint\_s3\_csi\_driver) | ../../../iam/irsa/aws-mountpoint-s3-csi-driver | n/a |
| <a name="module_irsa-cluster_autoscaler"></a> [irsa-cluster\_autoscaler](#module\_irsa-cluster\_autoscaler) | ../../../iam/irsa/cluster-autoscaler | n/a |
| <a name="module_irsa-external_secrets"></a> [irsa-external\_secrets](#module\_irsa-external\_secrets) | ../../../iam/irsa/external-secrets | n/a |
| <a name="module_irsa-kyverno"></a> [irsa-kyverno](#module\_irsa-kyverno) | ../../../iam/irsa/kyverno | n/a |
| <a name="module_irsa-vpc_cni"></a> [irsa-vpc\_cni](#module\_irsa-vpc\_cni) | ../../../iam/irsa/vpc-cni | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.adot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.aws_ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.aws_efs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.aws_mountpoint_s3_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_security_group.argocd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.kyverno](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [http_http.current_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adot-enabled"></a> [adot-enabled](#input\_adot-enabled) | Defines whether `AWS Distro for OpenTelemetry` is installed or not. | `bool` | `false` | no |
| <a name="input_adot-resolve_conflicts_on_create"></a> [adot-resolve\_conflicts\_on\_create](#input\_adot-resolve\_conflicts\_on\_create) | Defines a workaround if conflict occurs during creation. | `string` | `"OVERWRITE"` | no |
| <a name="input_adot-resolve_conflicts_on_update"></a> [adot-resolve\_conflicts\_on\_update](#input\_adot-resolve\_conflicts\_on\_update) | Defines a workaround if conflict occurs during the update. | `string` | `"NONE"` | no |
| <a name="input_adot-version"></a> [adot-version](#input\_adot-version) | Addon version of `AWS Distro for OpenTelemetry`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html | `string` | `"v0.94.1-eksbuild.1"` | no |
| <a name="input_argocd-access_type"></a> [argocd-access\_type](#input\_argocd-access\_type) | Defines the type of access for `argocd`. Possible values are `simple` and `custom.` If configured as `simple`, generate ingress as an alb of AWS. If configured as `custom`, it must be configured directly by injecting values file. | `string` | `"simple"` | no |
| <a name="input_argocd-enabled"></a> [argocd-enabled](#input\_argocd-enabled) | Defines whether `argocd` is installed or not. | `bool` | `true` | no |
| <a name="input_argocd-namespace"></a> [argocd-namespace](#input\_argocd-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"argocd"` | no |
| <a name="input_argocd-values"></a> [argocd-values](#input\_argocd-values) | Inject the values file of addon. | `list(string)` | `null` | no |
| <a name="input_argocd-version"></a> [argocd-version](#input\_argocd-version) | Addon version of `argocd`. | `string` | `"6.7.18"` | no |
| <a name="input_aws_ebs_csi_driver-enabled"></a> [aws\_ebs\_csi\_driver-enabled](#input\_aws\_ebs\_csi\_driver-enabled) | Defines whether `EBS CSI driver` is installed or not. | `bool` | `true` | no |
| <a name="input_aws_ebs_csi_driver-irsa-enabled"></a> [aws\_ebs\_csi\_driver-irsa-enabled](#input\_aws\_ebs\_csi\_driver-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `true` | no |
| <a name="input_aws_ebs_csi_driver-namespace"></a> [aws\_ebs\_csi\_driver-namespace](#input\_aws\_ebs\_csi\_driver-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_aws_ebs_csi_driver-resolve_conflicts_on_create"></a> [aws\_ebs\_csi\_driver-resolve\_conflicts\_on\_create](#input\_aws\_ebs\_csi\_driver-resolve\_conflicts\_on\_create) | Defines a workaround if conflict occurs during creation. | `string` | `"OVERWRITE"` | no |
| <a name="input_aws_ebs_csi_driver-resolve_conflicts_on_update"></a> [aws\_ebs\_csi\_driver-resolve\_conflicts\_on\_update](#input\_aws\_ebs\_csi\_driver-resolve\_conflicts\_on\_update) | Defines a workaround if conflict occurs during the update. | `string` | `"NONE"` | no |
| <a name="input_aws_ebs_csi_driver-version"></a> [aws\_ebs\_csi\_driver-version](#input\_aws\_ebs\_csi\_driver-version) | Addon version of `EBS CSI driver`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html | `string` | `"v1.32.0-eksbuild.1"` | no |
| <a name="input_aws_efs_csi_driver-addon_version"></a> [aws\_efs\_csi\_driver-addon\_version](#input\_aws\_efs\_csi\_driver-addon\_version) | Addon version of `EFS CSI driver`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html | `string` | `"v2.0.4-eksbuild.1"` | no |
| <a name="input_aws_efs_csi_driver-enabled"></a> [aws\_efs\_csi\_driver-enabled](#input\_aws\_efs\_csi\_driver-enabled) | Defines whether `EFS CSI driver` is installed or not. | `bool` | `false` | no |
| <a name="input_aws_efs_csi_driver-irsa-enabled"></a> [aws\_efs\_csi\_driver-irsa-enabled](#input\_aws\_efs\_csi\_driver-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `false` | no |
| <a name="input_aws_efs_csi_driver-namespace"></a> [aws\_efs\_csi\_driver-namespace](#input\_aws\_efs\_csi\_driver-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_aws_efs_csi_driver-resolve_conflicts_on_create"></a> [aws\_efs\_csi\_driver-resolve\_conflicts\_on\_create](#input\_aws\_efs\_csi\_driver-resolve\_conflicts\_on\_create) | Defines a workaround if conflict occurs during creation. | `string` | `"OVERWRITE"` | no |
| <a name="input_aws_efs_csi_driver-resolve_conflicts_on_update"></a> [aws\_efs\_csi\_driver-resolve\_conflicts\_on\_update](#input\_aws\_efs\_csi\_driver-resolve\_conflicts\_on\_update) | Defines a workaround if conflict occurs during the update. | `string` | `"NONE"` | no |
| <a name="input_aws_load_balancer_controller-enabled"></a> [aws\_load\_balancer\_controller-enabled](#input\_aws\_load\_balancer\_controller-enabled) | Defines whether `aws loadbalancer controller` is installed or not. | `bool` | `false` | no |
| <a name="input_aws_load_balancer_controller-irsa-enabled"></a> [aws\_load\_balancer\_controller-irsa-enabled](#input\_aws\_load\_balancer\_controller-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `true` | no |
| <a name="input_aws_load_balancer_controller-namespace"></a> [aws\_load\_balancer\_controller-namespace](#input\_aws\_load\_balancer\_controller-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_aws_load_balancer_controller-values"></a> [aws\_load\_balancer\_controller-values](#input\_aws\_load\_balancer\_controller-values) | Inject the values file of addon. | `list(string)` | `null` | no |
| <a name="input_aws_load_balancer_controller-version"></a> [aws\_load\_balancer\_controller-version](#input\_aws\_load\_balancer\_controller-version) | Addon version of `aws loadbalancer controller`. | `string` | `"1.8.1"` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-enabled"></a> [aws\_mountpoint\_s3\_csi\_driver-enabled](#input\_aws\_mountpoint\_s3\_csi\_driver-enabled) | Defines whether `S3 CSI driver` is installed or not. | `bool` | `false` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-irsa-enabled"></a> [aws\_mountpoint\_s3\_csi\_driver-irsa-enabled](#input\_aws\_mountpoint\_s3\_csi\_driver-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `false` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-namespace"></a> [aws\_mountpoint\_s3\_csi\_driver-namespace](#input\_aws\_mountpoint\_s3\_csi\_driver-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-resolve_conflicts_on_create"></a> [aws\_mountpoint\_s3\_csi\_driver-resolve\_conflicts\_on\_create](#input\_aws\_mountpoint\_s3\_csi\_driver-resolve\_conflicts\_on\_create) | Defines a workaround if conflict occurs during creation. | `string` | `"OVERWRITE"` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-resolve_conflicts_on_update"></a> [aws\_mountpoint\_s3\_csi\_driver-resolve\_conflicts\_on\_update](#input\_aws\_mountpoint\_s3\_csi\_driver-resolve\_conflicts\_on\_update) | Defines a workaround if conflict occurs during the update. | `string` | `"NONE"` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-target_s3"></a> [aws\_mountpoint\_s3\_csi\_driver-target\_s3](#input\_aws\_mountpoint\_s3\_csi\_driver-target\_s3) | S3 arn list allowed mount. | `set(string)` | `[]` | no |
| <a name="input_aws_mountpoint_s3_csi_driver-version"></a> [aws\_mountpoint\_s3\_csi\_driver-version](#input\_aws\_mountpoint\_s3\_csi\_driver-version) | Addon version of `S3 CSI driver`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html | `string` | `"v1.7.0-eksbuild.1"` | no |
| <a name="input_cluster_autoscaler-enabled"></a> [cluster\_autoscaler-enabled](#input\_cluster\_autoscaler-enabled) | Defines whether `cluster autoscaler` is installed or not. | `bool` | `false` | no |
| <a name="input_cluster_autoscaler-irsa-enabled"></a> [cluster\_autoscaler-irsa-enabled](#input\_cluster\_autoscaler-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `true` | no |
| <a name="input_cluster_autoscaler-namespace"></a> [cluster\_autoscaler-namespace](#input\_cluster\_autoscaler-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_cluster_autoscaler-values"></a> [cluster\_autoscaler-values](#input\_cluster\_autoscaler-values) | Inject the values file of addon. | `list(string)` | `null` | no |
| <a name="input_cluster_autoscaler-version"></a> [cluster\_autoscaler-version](#input\_cluster\_autoscaler-version) | Addon version of `cluster autoscaler`. | `string` | `"9.37.0"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | EKS cluster name that addons will be deployed. | `string` | n/a | yes |
| <a name="input_eks_oidc_issuer_url"></a> [eks\_oidc\_issuer\_url](#input\_eks\_oidc\_issuer\_url) | EKS OIDC issuer url. | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | EKS OIDC Provider arn. | `string` | n/a | yes |
| <a name="input_external_secrets-enabled"></a> [external\_secrets-enabled](#input\_external\_secrets-enabled) | Defines whether `external secrets` is installed or not. | `bool` | `true` | no |
| <a name="input_external_secrets-irsa-enabled"></a> [external\_secrets-irsa-enabled](#input\_external\_secrets-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `true` | no |
| <a name="input_external_secrets-namespace"></a> [external\_secrets-namespace](#input\_external\_secrets-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_external_secrets-target_secretsmanager"></a> [external\_secrets-target\_secretsmanager](#input\_external\_secrets-target\_secretsmanager) | Secretmanager arn list that external secrets can access. Default value is "arn:aws:secretsmanager:$\{data.aws\_region.current.name\}:$\{data.aws\_caller\_identity.current.account\_id\}:*" | `list(string)` | `null` | no |
| <a name="input_external_secrets-values"></a> [external\_secrets-values](#input\_external\_secrets-values) | Inject the values file of addon. | `list(string)` | `null` | no |
| <a name="input_external_secrets-version"></a> [external\_secrets-version](#input\_external\_secrets-version) | Addon version of `external secrets`. | `string` | `"0.9.19"` | no |
| <a name="input_kyverno-enabled"></a> [kyverno-enabled](#input\_kyverno-enabled) | Defines whether `kyverno` is installed or not. | `bool` | `false` | no |
| <a name="input_kyverno-irsa-enabled"></a> [kyverno-irsa-enabled](#input\_kyverno-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `true` | no |
| <a name="input_kyverno-namespace"></a> [kyverno-namespace](#input\_kyverno-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kyverno"` | no |
| <a name="input_kyverno-values"></a> [kyverno-values](#input\_kyverno-values) | Inject the values file of addon. | `list(string)` | `null` | no |
| <a name="input_kyverno-version"></a> [kyverno-version](#input\_kyverno-version) | Addon version of `kyverno`. | `string` | `"3.2.5"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used for the created resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags. | `map(string)` | `{}` | no |
| <a name="input_vpc_cni-addon_version"></a> [vpc\_cni-addon\_version](#input\_vpc\_cni-addon\_version) | Addon version of VPC CNI driver. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html | `string` | `"v1.18.2-eksbuild.1"` | no |
| <a name="input_vpc_cni-enabled"></a> [vpc\_cni-enabled](#input\_vpc\_cni-enabled) | Defines whether VPC CNI is installed or not. | `bool` | `true` | no |
| <a name="input_vpc_cni-irsa-enabled"></a> [vpc\_cni-irsa-enabled](#input\_vpc\_cni-irsa-enabled) | Determines whether you want to create a role for addon's irsa. | `bool` | `true` | no |
| <a name="input_vpc_cni-namespace"></a> [vpc\_cni-namespace](#input\_vpc\_cni-namespace) | Defines the namespace to which addon will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_vpc_cni-resolve_conflicts_on_create"></a> [vpc\_cni-resolve\_conflicts\_on\_create](#input\_vpc\_cni-resolve\_conflicts\_on\_create) | Defines a workaround if conflict occurs during creation. | `string` | `"OVERWRITE"` | no |
| <a name="input_vpc_cni-resolve_conflicts_on_update"></a> [vpc\_cni-resolve\_conflicts\_on\_update](#input\_vpc\_cni-resolve\_conflicts\_on\_update) | Defines a workaround if conflict occurs during the update. | `string` | `"NONE"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id for EKS. | `string` | n/a | yes |

## Outputs

No outputs.
