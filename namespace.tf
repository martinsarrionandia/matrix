resource "kubernetes_namespace" "matrix" {
  metadata {
    name = var.namespace
  }
}