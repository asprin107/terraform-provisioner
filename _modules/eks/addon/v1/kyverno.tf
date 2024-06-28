resource "helm_release" "kyverno" {
  count            = var.kyverno-enabled ? 1 : 0
  repository       = "https://kyverno.github.io/kyverno/"
  chart            = "kyverno"
  name             = "kyverno"
  namespace        = var.kyverno-namespace
  create_namespace = true
  version          = var.kyverno-version

  values = var.kyverno-values == null ? [templatefile("${path.module}/values/kyverno-values.yaml", {
    serviceaccount_role_arn = module.irsa-kyverno[0].irsa-role-arn
  })] : var.kyverno-values
}

module "irsa-kyverno" {
  count                 = var.kyverno-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/kyverno"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.kyverno-namespace
  tags                  = var.tags
}

variable "kyverno-enabled" {
  description = "Defines whether `kyverno` is installed or not."
  type        = bool
  default     = false
}

variable "kyverno-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = true
}

variable "kyverno-version" {
  description = "Addon version of `kyverno`."
  type        = string
  default     = "3.2.5"
}

variable "kyverno-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kyverno"
}

variable "kyverno-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}