resource "aws_eks_addon" "aws_efs_csi_driver" {
  count                       = var.aws_efs_csi_driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-efs-csi-driver"
  addon_version               = var.aws_efs_csi_driver-addon_version
  resolve_conflicts_on_create = var.aws_efs_csi_driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws_efs_csi_driver-resolve_conflicts_on_update
  service_account_role_arn    = module.irsa-aws_efs_csi_driver[0].irsa-role-arn
  tags                        = var.tags
}

module "irsa-aws_efs_csi_driver" {
  count                 = var.aws_efs_csi_driver-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/aws-efs-csi-driver"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.aws_efs_csi_driver-namespace
  tags                  = var.tags
}


variable "aws_efs_csi_driver-enabled" {
  description = "Defines whether `EFS CSI driver` is installed or not."
  type        = bool
  default     = false
}

variable "aws_efs_csi_driver-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = false
}

variable "aws_efs_csi_driver-addon_version" {
  description = "Addon version of `EFS CSI driver`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html"
  type        = string
  default     = "v2.0.4-eksbuild.1"
}

variable "aws_efs_csi_driver-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kube-system"
}

variable "aws_efs_csi_driver-resolve_conflicts_on_create" {
  description = "Defines a workaround if conflict occurs during creation."
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}

variable "aws_efs_csi_driver-resolve_conflicts_on_update" {
  description = "Defines a workaround if conflict occurs during the update."
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}