resource "kubernetes_namespace" "matrix" {
  metadata {
    name = var.namespace
    labels = {
      "pod-security.kubernetes.io/enforce" = var.signingkey-job-enabled ? "privileged" : "baseline"
      "pod-security.kubernetes.io/audit"   = "baseline"
      "pod-security.kubernetes.io/warn"    = "baseline"
    }
  }
  lifecycle {
    ignore_changes = [metadata[0].annotations["cattle.io/status"],
                      metadata[0].annotations["lifecycle.cattle.io/create.namespace-auth"]]
  }

}