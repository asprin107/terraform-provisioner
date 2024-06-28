resource "aws_iam_role" "irsa_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "eks-irsa-${var.suffix}"
  tags               = var.tags
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    principals {
      identifiers = [var.eks_oidc_provider_arn]
      type        = "Federated"
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = strcontains(var.k8s_service_account_name, "*") ? "StringLike" : "StringEquals"
      variable = "${replace(var.eks_oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account_name}"]
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(var.eks_oidc_provider_url, "https://", "")}:aud"
    }
  }
}