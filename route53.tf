data "aws_route53_zone" "main_domain" {
  name         = var.main-domain
  private_zone = false
}

resource "aws_route53_record" "matrix" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix-subdomain}.${var.main-domain}"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.rancher-infra.outputs.public_ip]
}