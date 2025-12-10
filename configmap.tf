data "kubernetes_config_map_v1" "aws-rancher-config" {
  metadata {
    name = "aws-rancher-config"
  }
}