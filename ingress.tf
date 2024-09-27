#resource "kubernetes_manifest" "matrix-ingress" {
#  manifest = yamldecode(templatefile("${path.module}/templates/ingress.yaml",
#    {
#      namespace      = kubernetes_namespace.matrix.metadata.0.name,
#      app-name       = helm_release.matrix.metadata.0.name,
#      chart-name     = helm_release.matrix.metadata.0.chart,
#      cluster-issuer = data.terraform_remote_state.rancher-config.outputs.cluster-issuer,
#      endpoint-fqdn  = aws_route53_record.matrix.fqdn
#  }))
#}

resource "kubernetes_manifest" "matrix-ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind = "Ingress"
    metadata = {
      annotations = {
        "cert-manager.io/cluster-issuer" = data.terraform_remote_state.rancher-config.outputs.cluster-issuer
      }
      labels = {
        app = helm_release.matrix.metadata.0.chart
      }
      name = helm_release.matrix.metadata.0.name
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
                    name = "${helm_release.matrix.metadata.0.name}-${helm_release.matrix.metadata.0.chart}"
                    port = {
                      number = 80
                    }
                  }
                }
                path = "/"
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