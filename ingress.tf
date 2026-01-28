resource "kubernetes_manifest" "matrix-ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      annotations = {
        "cert-manager.io/cluster-issuer" = data.kubernetes_config_map_v1.aws-rancher-config.data["cluster-issuer"]
      }
      labels = {
        app = var.release_chart
      }
      name      = var.release_name
      namespace = kubernetes_namespace_v1.matrix.metadata[0].name
    }
    spec = {
      rules = [
        {
          host = aws_route53_record.matrix.fqdn
          http = {
            paths = [
              {
                backend = {
                  service = {
                    name = "${var.release_name}-${var.release_chart}"
                    port = {
                      number = 8008
                    }
                  }
                }
                path     = "/"
                pathType = "Prefix"
              },
            ]
          }
        },
      ]
      tls = [
        {
          hosts = [
            aws_route53_record.matrix.fqdn,
          ]
          secretName = "${var.release_name}-${data.kubernetes_config_map_v1.aws-rancher-config.data["cluster-issuer"]}"
        },
      ]
    }
  }
}

