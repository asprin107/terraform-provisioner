# EKS IRSA for actions-runner
module "irsa_role" {
  source                   = "../common"
  eks_oidc_provider_arn    = var.eks_oidc_provider_arn
  eks_oidc_provider_url    = var.eks_oidc_provider_url
  suffix                   = "actions-runner-${var.suffix}"
  k8s_namespace            = var.k8s_namespace
  k8s_service_account_name = var.k8s_service_account_name
  tags                     = var.tags
}

resource "aws_iam_role_policy_attachment" "irsa-att-ecr" {
  policy_arn = data.aws_iam_policy.ecr_readonly.arn
  role       = module.irsa_role.role_name
}

resource "aws_iam_role_policy_attachment" "irsa-att-policy" {
  policy_arn = aws_iam_policy.actions_runner.arn
  role       = module.irsa_role.role_name
}

data "aws_iam_policy" "ecr_readonly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_policy" "actions_runner" {
  name   = "eks-irsa-actions-runner-${var.suffix}"
  policy = data.aws_iam_policy_document.action_runner.json
}