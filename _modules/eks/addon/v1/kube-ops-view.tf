resource "aws_security_group" "kube_ops_view" {
  count       = var.kube_ops_view-enabled ? 1 : 0
  name        = "${var.name}-kube-ops-view"
  description = "Security group for kube-ops-view web server."
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-kube-ops-view"
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


variable "kube_ops_view-enabled" {
  description = "Defines whether `kube-ops-view` is installed or not."
  type        = bool
  default     = false
}