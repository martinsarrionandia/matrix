resource "kubernetes_manifest" "matrix_network_policy" {
  manifest = yamldecode(templatefile("${path.module}/templates/network_policy.yaml",
    {
      release-name   = var.release-name,
      namespace      = kubernetes_namespace.matrix.metadata.0.name
  }))
}