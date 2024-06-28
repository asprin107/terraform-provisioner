resource "aws_eks_addon" "adot" {
  count                       = var.adot-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "adot"
  addon_version               = var.adot-version
  resolve_conflicts_on_create = var.adot-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.adot-resolve_conflicts_on_update
  tags                        = var.tags
}


variable "adot-enabled" {
  description = "Defines whether `AWS Distro for OpenTelemetry` is installed or not."
  type        = bool
  default     = false
}

variable "adot-version" {
  description = "Addon version of `AWS Distro for OpenTelemetry`. You can check the available values using awscli. https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html"
  type        = string
  default     = "v0.94.1-eksbuild.1"
}

variable "adot-resolve_conflicts_on_create" {
  description = "Defines a workaround if conflict occurs during creation."
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}

variable "adot-resolve_conflicts_on_update" {
  description = "Defines a workaround if conflict occurs during the update."
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}