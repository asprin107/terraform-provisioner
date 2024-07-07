resource "aws_kms_alias" "kyverno_sigstore" {
  target_key_id = aws_kms_key.signing_key.id
  name          = "alias/${var.project}-${var.service}-sigstore"
}

resource "aws_kms_key" "signing_key" {
  description              = "This key is for signing and verification of image with kyverno."
  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "RSA_3072"
  deletion_window_in_days  = 7

  tags = {
    Project     = var.project
    Service     = var.service
    Environment = "poc"
  }
}

resource "aws_kms_key_policy" "kyverno_sigstore" {
  key_id = aws_kms_key.signing_key.id
  policy = data.aws_iam_policy_document.kms_poliocy.json
}


data "aws_iam_policy_document" "kms_poliocy" {
  source_policy_documents = [
    data.aws_iam_policy_document.kms_basic.json,
    data.aws_iam_policy_document.kms_kyverno_sigstore.json
  ]
}

data "aws_iam_policy_document" "kms_basic" {
  statement {
    sid = "EnableIAMUserPermissions"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "kms_kyverno_sigstore" {
  statement {
    sid = "KyvernoSigsstore"
    principals {
      type = "AWS"
      identifiers = [
        var.kyverno_irsa_arn
      ]
    }
    effect = "Allow"
    actions = [
      "kms:GetPublicKey",
      "kms:DescribeKey"
    ]
    resources = [
      aws_kms_key.signing_key.arn
    ]
  }
}

data "aws_caller_identity" "current" {}