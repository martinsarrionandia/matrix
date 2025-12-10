resource "kubernetes_manifest" "network_policy_synapse" {
  manifest = yamldecode(templatefile("${path.module}/templates/network_policy_synapse.yaml",
    {
      release-name = var.release-name,
      namespace    = kubernetes_namespace_v1.matrix.metadata[0].name
  }))
}

resource "kubernetes_manifest" "network_policy_postgresql" {
  manifest = yamldecode(templatefile("${path.module}/templates/network_policy_postgresql.yaml",
    {
      release-name = var.release-name,
      namespace    = kubernetes_namespace_v1.matrix.metadata[0].name
  }))
}

resource "kubernetes_manifest" "network_policy_redis" {
  manifest = yamldecode(templatefile("${path.module}/templates/network_policy_redis.yaml",
    {
      release-name = var.release-name,
      namespace    = kubernetes_namespace_v1.matrix.metadata[0].name
  }))
}

resource "kubernetes_manifest" "network_policy_signkey-job" {
  count = 0
  manifest = yamldecode(templatefile("${path.module}/templates/network_policy_signkey-job.yaml",
    {
      release-name = var.release-name,
      namespace    = kubernetes_namespace_v1.matrix.metadata[0].name
  }))
}