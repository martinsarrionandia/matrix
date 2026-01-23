variable "namespace" {
  type    = string
  default = "matrix"
}

variable "matrix_secret_arn" {
  type    = string
  default = "arn:aws:secretsmanager:eu-west-2:281287281094:secret:matrix-fFyAgI"
}

variable "main_domain" {
  type    = string
  default = "sarrionandia.co.uk"
}

variable "matrix_subdomain" {
  type    = string
  default = "matrix"
}

variable "release_name" {
  type    = string
  default = "matrix"
}

variable "release_repo" {
  type    = string
  default = "https://ananace.gitlab.io/charts"
}

variable "release_chart" {
  type    = string
  default = "matrix-synapse"
}

variable "signingkey_job_enabled" {
  type    = bool
  default = false
}

variable "matrix_federation" {
  type    = string
  default = "_matrix._tcp"
}

variable "federation_port" {
  description = "This will be 443 for kubernetes deployments"
  type        = string
  default     = "443"
}

variable "csi_driver" {
  type    = string
  default = "ebs.csi.aws.com"
}

variable "csi_fs_type" {
  type    = string
  default = "ext4"
}

variable "matrix_ebs_volume_name" {
  type    = string
  default = "rancher-matrix"
}

variable "postgresql_ebs_volume_name" {
  type    = string
  default = "rancher-matrix-postgresql"
}

variable "kube_config_fqdn" {
  type    = string
  default = "rancher.sarrionandia.co.uk"
}