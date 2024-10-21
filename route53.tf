data "aws_route53_zone" "main_domain" {
  name         = var.main-domain
  private_zone = false
}

resource "aws_route53_record" "matrix" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix-subdomain}.${var.main-domain}"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.rancher-infra.outputs.public-ip]
}

resource "aws_route53_record" "federated_srv" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix-federation}.${var.matrix-subdomain}.${var.main-domain}"
  type    = "SRV"
  ttl     = "300"
  records = ["5 10 ${var.federation-port} ${aws_route53_record.matrix.fqdn}"]
}