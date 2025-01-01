data "kubernetes_config_map" "aws-rancher-config" {
  metadata {
    name = "aws-rancher-config"
  }
}