# EKS IRSA for aws-mountpoint-s3-csi-driver
module "irsa_role" {
  source                   = "../common"
  eks_oidc_provider_arn    = var.eks_oidc_provider_arn
  eks_oidc_provider_url    = var.eks_oidc_provider_url
  suffix                   = "aws-mountpoint-s3-csi-driver-${var.suffix}"
  k8s_namespace            = var.k8s_namespace
  k8s_service_account_name = var.k8s_service_account_name
  tags                     = var.tags
}

resource "aws_iam_role_policy_attachment" "irsa-att" {
  policy_arn = aws_iam_policy.irsa-aws_mountpoint_s3_csi_driver.arn
  role       = module.irsa_role.role_name
}

resource "aws_iam_policy" "irsa-aws_mountpoint_s3_csi_driver" {
  name   = "eks-irsa-aws-mountpoint-s3-csi-driver-${var.suffix}"
  policy = data.aws_iam_policy_document.aws_mountpoint_s3_csi_driver-policy.json
  tags   = var.tags
}

data "aws_iam_policy_document" "aws_mountpoint_s3_csi_driver-policy" {
  statement {
    sid    = "MountpointFullBucketAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = var.mount_target_s3
  }
  statement {
    sid    = "MountpointFullObjectAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject"
    ]
    resources = [for v in var.mount_target_s3 : "${v}/*"]
  }
}