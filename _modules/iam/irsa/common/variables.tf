variable "suffix" {
  description = "IRSA role name suffix."
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
  description = "Kubernetes namespace for serviceaccount."
  type        = string
  default     = "default"
}

variable "k8s_service_account_name" {
  description = "Kubernetes service account name for IRSA."
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}