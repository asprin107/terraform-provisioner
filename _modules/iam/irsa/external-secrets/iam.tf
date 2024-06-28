# EKS IRSA for external-secrets
module "irsa_role" {
  source                   = "../common"
  eks_oidc_provider_arn    = var.eks_oidc_provider_arn
  eks_oidc_provider_url    = var.eks_oidc_provider_url
  suffix                   = "external-secrets-${var.suffix}"
  k8s_namespace            = var.k8s_namespace
  k8s_service_account_name = var.k8s_service_account_name
  tags                     = var.tags
}

resource "aws_iam_role_policy_attachment" "irsa-att" {
  policy_arn = aws_iam_policy.irsa-external_secrets.arn
  role       = module.irsa_role.role_name
}

resource "aws_iam_policy" "irsa-external_secrets" {
  name   = "eks-irsa-external-secrets-${var.suffix}"
  policy = data.aws_iam_policy_document.external_secrets-policy.json
  tags   = var.tags
}

data "aws_iam_policy_document" "external_secrets-policy" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:CreateSecret",
      "secretsmanager:PutSecretValue",
      "secretsmanager:TagResource",
      "secretsmanager:DeleteSecret"
    ]
    resources = var.target_secretsmanager != null ? var.target_secretsmanager : ["arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}