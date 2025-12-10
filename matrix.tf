resource "helm_release" "matrix" {
  namespace  = kubernetes_namespace_v1.matrix.metadata[0].name
  name       = var.release-name
  repository = var.release-repo
  chart      = var.release-chart

  set = [{
    name  = "replicaCount"
    value = "1"
    },
    {
      name  = "service.type"
      value = "ClusterIP"
    },
    {
      name  = "persistence.existingClaim"
      value = kubernetes_persistent_volume_claim_v1.matrix.metadata[0].name
    },
    {
      name  = "postgresql.primary.persistence.existingClaim"
      value = kubernetes_persistent_volume_claim_v1.matrix-postgresql.metadata[0].name
    },
    {
      name  = "volumePermissions.enabled"
      value = "true"
    },
    {
      name  = "signingkey.job.enabled"
      value = var.signingkey-job-enabled
    },
    {
      name  = "serverName"
      value = aws_route53_record.matrix.fqdn
    },
    {
      name  = "wellknown.enabled"
      value = false
    },
    {
      name  = "enableRegistration"
      value = false
    },
    {
      name  = "config.registrationSharedSecret"
      value = jsondecode(data.aws_secretsmanager_secret_version.matrix_current.secret_string)["registrationSharedSecret"]
    },
    {
      name  = "ingress.annotations.traefik\\.ingress\\.kubernetes\\.io\\/router\\.middlewares"
      value = data.kubernetes_config_map_v1.aws-rancher-config.data["crowdsec-bouncer-middleware"]
  }]
}

