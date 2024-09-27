terraform {
  backend "s3" {
    bucket = "sarrionandia.co.uk"
    key    = "terraform-state/matrix/terraform.tfstate"
    region = "eu-west-1"
  }
}