resource "helm_release" "cluster_autoscaler" {
  count            = var.cluster_autoscaler-enabled ? 1 : 0
  repository       = "https://kubernetes.github.io/autoscaler"
  name             = "cluster-autoscaler"
  chart            = "cluster-autoscaler"
  namespace        = var.cluster_autoscaler-namespace
  create_namespace = true
  version          = var.cluster_autoscaler-version

  values = var.cluster_autoscaler-values == null ? [templatefile("${path.module}/values/cluster_autoscaler-values.yaml", {
    cluster_name            = var.name
    region                  = data.aws_region.current.name
    serviceaccount_role_arn = module.irsa-cluster_autoscaler[0].irsa-role-arn
  })] : var.cluster_autoscaler-values
}

module "irsa-cluster_autoscaler" {
  count                 = var.cluster_autoscaler-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/cluster-autoscaler"
  eks_name              = var.eks_cluster_name
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.cluster_autoscaler-namespace
  tags                  = var.tags
}


variable "cluster_autoscaler-enabled" {
  description = "Defines whether `cluster autoscaler` is installed or not."
  type        = bool
  default     = false
}

variable "cluster_autoscaler-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = true
}

variable "cluster_autoscaler-version" {
  description = "Addon version of `cluster autoscaler`."
  type        = string
  default     = "9.37.0"
}

variable "cluster_autoscaler-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kube-system"
}

variable "cluster_autoscaler-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}
