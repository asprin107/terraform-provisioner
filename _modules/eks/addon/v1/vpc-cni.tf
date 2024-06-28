resource "aws_eks_addon" "vpc_cni" {
  count                       = var.vpc_cni-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc_cni-addon_version
  resolve_conflicts_on_create = var.vpc_cni-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.vpc_cni-resolve_conflicts_on_update
  service_account_role_arn    = module.irsa-vpc_cni[0].irsa-role-arn
  tags                        = var.tags
}

module "irsa-vpc_cni" {
  count                 = var.vpc_cni-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/vpc-cni"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.vpc_cni-namespace
  tags                  = var.tags
}


variable "vpc_cni-enabled" {
  description = "Defines whether VPC CNI is installed or not."
  type        = bool
  default     = true
}

variable "vpc_cni-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = true
}

variable "vpc_cni-addon_version" {
  description = "Addon version of VPC CNI driver. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html"
  type        = string
  default     = "v1.18.2-eksbuild.1"
}

variable "vpc_cni-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kube-system"
}

variable "vpc_cni-resolve_conflicts_on_create" {
  description = "Defines a workaround if conflict occurs during creation."
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}

variable "vpc_cni-resolve_conflicts_on_update" {
  description = "Defines a workaround if conflict occurs during the update."
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}