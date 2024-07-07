resource "helm_release" "gha_runner_scale_set_controller" {
  count            = var.gha_runner_scale_set_controller-enabled ? 1 : 0
  repository       = "oci://ghcr.io/actions/actions-runner-controller-charts"
  name             = "gha-runner-scale-set-controller"
  chart            = "gha-runner-scale-set-controller"
  namespace        = var.gha_runner_scale_set_controller-namespace
  create_namespace = true
  version          = var.gha_runner_scale_set_controller-version

  values = var.gha_runner_scale_set_controller-values == null ? [] : var.gha_runner_scale_set_controller-values
}

resource "helm_release" "gha_runner_scale_set" {
  count            = var.gha_runner_scale_set_controller-enabled ? 1 : 0
  repository       = "oci://ghcr.io/actions/actions-runner-controller-charts"
  name             = "gha-runner-scale-set"
  chart            = "gha-runner-scale-set"
  namespace        = var.gha_runner_scale_set_controller-namespace
  create_namespace = true
  version          = var.gha_runner_scale_set_controller-version

  values = var.gha_runner_scale_set-values == null ? [templatefile("${path.module}/values/gha-runner-scale-set-values.yaml", {
    github_config_url = var.gha_config_url
    runner_group      = var.gha_runner_group
  })] : var.gha_runner_scale_set-values

  depends_on = [helm_release.gha_runner_scale_set_controller]
}

module "irsa-gha_runner_scale_set" {
  count                 = var.gha_runner_scale_set_controller-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/actions-runner"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.gha_runner_scale_set_controller-namespace
  tags                  = var.tags
}


variable "gha_runner_scale_set_controller-enabled" {
  description = "Defines whether `actions runner controller` is installed or not."
  type        = bool
  default     = false
}

variable "gha_runner_scale_set_controller-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = false
}

variable "gha_runner_scale_set_controller-version" {
  description = "Addon version of `actions runner controller`."
  type        = string
  default     = "0.9.3"
}

variable "gha_runner_scale_set_controller-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "arc-runners"
}

variable "gha_runner_scale_set_controller-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}

variable "gha_runner_scale_set-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}

variable "gha_config_url" {
  description = "The information of the target GitHub URL for the action runner to connect to."
  type        = string
  default     = ""
}

variable "gha_runner_group" {
  description = ""
  type        = string
  default     = "k8s-self-hosted"
}