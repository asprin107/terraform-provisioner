resource "helm_release" "argocd" {
  count            = var.argocd-enabled ? 1 : 0
  repository       = "https://argoproj.github.io/argo-helm"
  name             = "argocd"
  chart            = "argo-cd"
  namespace        = var.argocd-namespace
  create_namespace = true
  version          = var.argocd-version

  values = var.argocd-values == null ? [templatefile("${path.module}/values/argocd-values.yaml", {
    cluster_name   = var.name
    hostname       = "'\"*.elb.amazonaws.com\"'" // Default, available without DNS resources.
    security_group = aws_security_group.argocd[0].id
  })] : var.argocd-values // Default, Ignoring RBAC changes made by AggregateRoles
}

resource "aws_security_group" "argocd" {
  count       = var.argocd-enabled ? 1 : 0
  name        = "${var.name}-argocd"
  description = "Security group for argocd web server."
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-argocd"
    }
  )

  ingress {
    description = "HTTPS for argocd"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["${chomp(data.http.current_ip.response_body)}/32"]
  }
  ingress {
    description = "HTTP for argocd"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["${chomp(data.http.current_ip.response_body)}/32"]
  }
  egress {
    description = "Egress to all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


variable "argocd-enabled" {
  description = "Defines whether `argocd` is installed or not."
  type        = bool
  default     = true
}

variable "argocd-version" {
  description = "Addon version of `argocd`."
  type        = string
  default     = "6.7.18"
}

variable "argocd-namespace" {
  description = "Defines the namespace to which addon will be deployed."
  type        = string
  default     = "argocd"
}

variable "argocd-values" {
  description = "Inject the values file of addon."
  type        = list(string)
  default     = null
}