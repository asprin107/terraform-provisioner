resource "helm_release" "external_secrets" {
  count            = var.external_secrets-enabled ? 1 : 0
  repository       = "https://charts.external-secrets.io"
  name             = "external-secrets"
  chart            = "external-secrets"
  namespace        = var.external_secrets-namespace
  create_namespace = true
  version          = var.external_secrets-version

  values = var.external_secrets-values == null ? [] : var.external_secrets-values
}

module "irsa-external_secrets" {
  count                 = var.external_secrets-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/external-secrets"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.external_secrets-namespace
  target_secretsmanager = var.external_secrets-target_secretsmanager
  tags                  = var.tags
}


variable "external_secrets-enabled" {
  description = "Defines whether `external secrets` is installed or not."
  type        = bool
  default     = true
}

variable "external_secrets-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = true
}

variable "external_secrets-version" {
  description = "Addon version of `external secrets`."
  type        = string
  default     = "0.9.19"
}

variable "external_secrets-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kube-system"
}

variable "external_secrets-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}

variable "external_secrets-target_secretsmanager" {
  description = "Secretmanager arn list that external secrets can access. Default value is \"arn:aws:secretsmanager:$\\{data.aws_region.current.name\\}:$\\{data.aws_caller_identity.current.account_id\\}:*\""
  type        = list(string)
  default     = null
}
