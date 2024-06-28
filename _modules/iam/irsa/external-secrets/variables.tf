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
  default     = "external-secrets-sa"
}

variable "target_secretsmanager" {
  description = "Secretmanager arn list that external secrets can access. Default value is \"arn:aws:secretsmanager:$\\{data.aws_region.current.name\\}:$\\{data.aws_caller_identity.current.account_id\\}:*\""
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}