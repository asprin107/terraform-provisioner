resource "aws_eks_addon" "aws_mountpoint_s3_csi_driver" {
  count                       = var.aws_mountpoint_s3_csi_driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-mountpoint-s3-csi-driver"
  addon_version               = var.aws_mountpoint_s3_csi_driver-version
  resolve_conflicts_on_create = var.aws_mountpoint_s3_csi_driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws_mountpoint_s3_csi_driver-resolve_conflicts_on_update
  service_account_role_arn    = module.irsa-aws_mountpoint_s3_csi_driver[0].irsa-role-arn
  tags                        = var.tags
}

module "irsa-aws_mountpoint_s3_csi_driver" {
  count                 = var.aws_mountpoint_s3_csi_driver-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/aws-mountpoint-s3-csi-driver"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.aws_mountpoint_s3_csi_driver-namespace
  mount_target_s3       = var.aws_mountpoint_s3_csi_driver-target_s3
  tags                  = var.tags
}


variable "aws_mountpoint_s3_csi_driver-enabled" {
  description = "Defines whether `S3 CSI driver` is installed or not."
  type        = bool
  default     = false
}

variable "aws_mountpoint_s3_csi_driver-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = false
}

variable "aws_mountpoint_s3_csi_driver-version" {
  description = "Addon version of `S3 CSI driver`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html"
  type        = string
  default     = "v1.7.0-eksbuild.1"
}

variable "aws_mountpoint_s3_csi_driver-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kube-system"
}

variable "aws_mountpoint_s3_csi_driver-resolve_conflicts_on_create" {
  description = "Defines a workaround if conflict occurs during creation."
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}

variable "aws_mountpoint_s3_csi_driver-resolve_conflicts_on_update" {
  description = "Defines a workaround if conflict occurs during the update."
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}

variable "aws_mountpoint_s3_csi_driver-target_s3" {
  description = "S3 arn list allowed mount."
  type        = set(string)
  default     = []
}