resource "aws_signer_signing_profile" "kyverno-profile" {
  platform_id = "Notation-OCI-SHA384-ECDSA"           // for Notation.
  name        = "${var.project}${title(var.service)}" // make camelcase. Only available alphanumeric.

  // Default valid period is 135 Months
  signature_validity_period {
    type  = "MONTHS"
    value = 135
  }

  #  signing_material {
  #    certificate_arn = ""
  #  }

  tags = {
    Project     = var.project
    Service     = var.service
    Environment = "poc"
  }
}
