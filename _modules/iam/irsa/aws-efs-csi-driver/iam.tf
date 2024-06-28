# EKS IRSA for aws-efs-csi-driver
module "irsa_role" {
  source                   = "../common"
  eks_oidc_provider_arn    = var.eks_oidc_provider_arn
  eks_oidc_provider_url    = var.eks_oidc_provider_url
  suffix                   = "aws-efs-csi-driver-${var.suffix}"
  k8s_namespace            = var.k8s_namespace
  k8s_service_account_name = var.k8s_service_account_name
  tags                     = var.tags
}

resource "aws_iam_role_policy_attachment" "irsa-att" {
  policy_arn = data.aws_iam_policy.aws_efs_csi_driver.arn
  role       = module.irsa_role.role_name
}

data "aws_iam_policy" "aws_efs_csi_driver" {
  name = "AmazonEFSCSIDriverPolicy"
}