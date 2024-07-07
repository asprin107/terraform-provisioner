variable "project" {
  description = "Project name."
  type        = string
}

variable "service" {
  description = "Service name."
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region name."
  type        = string
}

variable "gha_config_url" {
  description = "The information of the target GitHub URL for the action runner to connect to."
  type        = string
}