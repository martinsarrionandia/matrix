provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Environment = "Rancher"
      Managedby   = "Terraform"
    }
  }
}

# Helm Provider
provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/${var.kube-config-fqdn}")
  }
}

# Kubernetes Provider
provider "kubernetes" {
  config_path = pathexpand("~/.kube/${var.kube-config-fqdn}")
}