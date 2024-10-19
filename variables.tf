variable "main-domain" {
  type    = string
  default = "sarrionandia.co.uk"
}

variable "matrix-subdomain" {
  type    = string
  default = "matrix"
}

variable "release-name" {
  type    = string
  default = "matrix"
}

variable "release-repo" {
  type = string
  default = "https://ananace.gitlab.io/charts"
}

variable "release-chart" {
  type    = string
  default = "matrix-synapse"
}

variable "matrix-federation" {
  type    = string
  default = "_matrix._tcp"
}

variable "federation_port" {
  description = "This will be 443 for kubernetes deployments"
  type        = string
  default     = "443"
}

variable "matrix-secret-arn" {
  type    = string
  default = "arn:aws:secretsmanager:eu-west-2:281287281094:secret:matrix-fFyAgI"
}

variable "remote-state-bucket" {
  type = string
  default = "sarrionandia.co.uk"
}

variable "matrix-ebs-volume-name" {
  type = string
  default = "rancher-matrix"
}

variable "postgresql-ebs-volume-name" {
  type = string
  default = "rancher-matrix-postgresql"
}