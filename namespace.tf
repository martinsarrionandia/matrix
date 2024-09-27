resource "kubernetes_namespace" "matrix" {
  metadata {
    name = "matrix"
  }
}