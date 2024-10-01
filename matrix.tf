resource "helm_release" "matrix" {
  create_namespace = true
  namespace        = kubernetes_namespace.matrix.metadata.0.name
  name             = var.release-name
  repository       = "https://ananace.gitlab.io/charts"
  chart            = var.release-chart

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.matrix.metadata.0.name
  }

  set {
    name  = "postgresql.primary.persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.matrix-postgresql.metadata.0.name
  }

  set {
    name  = "volumePermissions.enabled"
    value = "true"
  }

  set {
    name  = "serverName"
    value = aws_route53_record.matrix.fqdn
  }

  set {
    name  = "wellknown.enabled"
    value = true
  }

  set {
    name  = "enableRegistration"
    value = "false"
  }

  set {
    name = "registrationSharedSecret"
    value = jsondecode(data.aws_secretsmanager_secret_version.matrix_current.secret_string)["registrationSharedSecret"]
  }
}