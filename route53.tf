data "aws_route53_zone" "main_domain" {
  name         = var.main_domain
  private_zone = false
}

resource "aws_route53_record" "matrix" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix_subdomain}.${var.main_domain}"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.rancher-infra.outputs.public_ip]
}