resource "helm_release" "aws_load_balancer_controller" {
  count            = var.aws_load_balancer_controller-enabled ? 1 : 0
  repository       = "https://aws.github.io/eks-charts"
  name             = "aws-load-balancer-controller"
  chart            = "aws-load-balancer-controller"
  namespace        = var.aws_load_balancer_controller-namespace
  create_namespace = true
  version          = var.aws_load_balancer_controller-version

  values = var.aws_load_balancer_controller-values == null ? [templatefile("${path.module}/values/aws_load_balancer_controller-values.yaml", {
    cluster_name            = var.name
    region                  = data.aws_region.current.name
    vpc_id                  = var.vpc_id
    serviceaccount_role_arn = module.irsa-aws_load_balancer_controller[0].irsa-role-arn
  })] : var.aws_load_balancer_controller-values
}

module "irsa-aws_load_balancer_controller" {
  count                 = var.aws_load_balancer_controller-irsa-enabled ? 1 : 0
  source                = "../../../iam/irsa/aws-load-balancer-controller"
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.aws_load_balancer_controller-namespace
  tags                  = var.tags
}


variable "aws_load_balancer_controller-enabled" {
  description = "Defines whether `aws loadbalancer controller` is installed or not."
  type        = bool
  default     = false
}

variable "aws_load_balancer_controller-irsa-enabled" {
  description = "Determines whether you want to create a role for addon's irsa."
  type        = bool
  default     = true
}

variable "aws_load_balancer_controller-version" {
  description = "Addon version of `aws loadbalancer controller`."
  type        = string
  default     = "1.8.1"
}

variable "aws_load_balancer_controller-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "kube-system"
}

variable "aws_load_balancer_controller-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}