resource "kubernetes_namespace" "matrix" {
  metadata {
    name = var.namespace
    labels = {
        "pod-security.kubernetes.io/enforce"="privileged"
        "pod-security.kubernetes.io/audit"="baseline"
        "pod-security.kubernetes.io/warn"="baseline"
    }
  }
}