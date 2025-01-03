data "aws_route53_zone" "main_domain" {
  name         = var.main-domain
  private_zone = false
}

resource "aws_route53_record" "matrix" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix-subdomain}.${var.main-domain}"
  type    = "A"
  ttl     = "300"
  records = [data.kubernetes_config_map.aws-rancher-config.data["public-ip"]]
}

resource "aws_route53_record" "federated_srv" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix-federation}.${var.matrix-subdomain}.${var.main-domain}"
  type    = "SRV"
  ttl     = "300"
  records = ["5 10 ${var.federation-port} ${aws_route53_record.matrix.fqdn}"]
}