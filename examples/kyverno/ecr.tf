resource "aws_ecr_repository" "kyverno" {
  name                 = "${var.project}-${var.service}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = "false"
  }
}