resource "kubernetes_namespace_v1" "matrix" {
  metadata {
    name = var.namespace
    labels = {
      "pod-security.kubernetes.io/enforce" = var.signingkey-job-enabled ? "privileged" : "baseline"
      "pod-security.kubernetes.io/audit"   = "baseline"
      "pod-security.kubernetes.io/warn"    = "baseline"
    }
  }
}