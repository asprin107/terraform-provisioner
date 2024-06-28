variable "project" {
  description = "Project name."
  type        = string
  default     = "test"
}

variable "service" {
  description = "Service name."
  type        = string
  default     = "kyverno"
}

variable "region" {
  description = "AWS region name."
  type        = string
}