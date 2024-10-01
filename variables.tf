variable "main-domain" {
  type    = string
  default = "sarrionandia.co.uk"
}

variable "matrix-subdomain" {
   type = string
   default = "matrix" 
}

variable "release-name" {
  type = string
  default ="matrix"
}

variable "release-chart" {
  type = string
  default ="matrix-synapse"
}