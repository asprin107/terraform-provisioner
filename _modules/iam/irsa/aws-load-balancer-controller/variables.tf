variable "suffix" {
  description = "IRSA Name suffix about aws load balancer controller."
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "EKS OIDC provider arn for federation."
  type        = string
}

variable "eks_oidc_provider_url" {
  description = "EKS OIDC provider url."
  type        = string
}

variable "k8s_namespace" {
  type    = string
  default = "kube-system"
}

variable "k8s_service_account_name" {
  description = "Kubernetes service account name for IRSA."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}