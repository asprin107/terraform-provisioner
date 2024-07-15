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

variable "gha_secret_name" {
  description = "Secret name for github action runner auth. it must contain github PAT."
  type        = string
}