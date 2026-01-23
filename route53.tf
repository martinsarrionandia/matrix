data "aws_route53_zone" "main_domain" {
  name         = var.main_domain
  private_zone = false
}

resource "aws_route53_record" "matrix" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix_subdomain}.${var.main_domain}"
  type    = "A"
  ttl     = "300"
  records = [data.kubernetes_config_map_v1.aws-rancher-config.data["public-ip"]]
}

resource "aws_route53_record" "federated_srv" {
  zone_id = data.aws_route53_zone.main_domain.id
  name    = "${var.matrix_federation}.${var.matrix_subdomain}.${var.main_domain}"
  type    = "SRV"
  ttl     = "300"
  records = ["5 10 ${var.federation_port} ${aws_route53_record.matrix.fqdn}"]
}