data "aws_iam_policy_document" "action_runner" {
  source_policy_documents = [
    data.aws_iam_policy_document.kyverno_notary.json,
    data.aws_iam_policy_document.kyverno_sigstore.json
  ]
}

data "aws_iam_policy_document" "kyverno_notary" {
  statement {
    sid    = "KyvernoNotaryPolicy"
    effect = "Allow"
    actions = [
      "signer:GetSigningProfile",
      "signer:ListSigningProfiles",
      "signer:SignPayload",
      "signer:GetRevocationStatus",
      "signer:DescribeSigningJob",
      "signer:ListSigningJobs"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "kyverno_sigstore" {
  statement {
    sid    = "KyvernoSigstorePolicy"
    effect = "Allow"
    actions = [
      "kms:GetPublicKey",
      "kms:DescribeKey"
    ]
    resources = var.kms_arns == null ? ["*"] : var.kms_arns
  }
}