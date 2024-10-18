resource "kubernetes_manifest" "matrix-ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      annotations = {
        "cert-manager.io/cluster-issuer" = data.terraform_remote_state.rancher-config.outputs.cluster-issuer
      }
      labels = {
        app = var.release-chart
      }
      name      = var.release-name
      namespace = kubernetes_namespace.matrix.metadata.0.name
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
                    name = "${var.release-name}-${var.release-chart}"
                    port = {
                      number = 80
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
          secretName = data.terraform_remote_state.rancher-config.outputs.cluster-issuer
        },
      ]
    }
  }
}