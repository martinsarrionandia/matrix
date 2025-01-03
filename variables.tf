variable "namespace" {
  type    = string
  default = "matrix"
}

variable "matrix-secret-arn" {
  type    = string
  default = "arn:aws:secretsmanager:eu-west-2:281287281094:secret:matrix-fFyAgI"
}

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
  type    = string
  default = "https://ananace.gitlab.io/charts"
}

variable "release-chart" {
  type    = string
  default = "matrix-synapse"
}

variable "signingkey-job-enabled" {
  type    = bool
  default = false
}

variable "matrix-federation" {
  type    = string
  default = "_matrix._tcp"
}

variable "federation-port" {
  description = "This will be 443 for kubernetes deployments"
  type        = string
  default     = "443"
}

variable "matrix-ebs-volume-name" {
  type    = string
  default = "rancher-matrix"
}

variable "postgresql-ebs-volume-name" {
  type    = string
  default = "rancher-matrix-postgresql"
}

variable "kube-config-fqdn" {
  type    = string
  default = "rancher.sarrionandia.co.uk"
}