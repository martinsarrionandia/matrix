data "aws_ebs_volume" "matrix" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp3"]
  }

  filter {
    name   = "tag:Name"
    values = ["rancher-matrix"]
  }
}

resource "kubernetes_persistent_volume" "matrix" {
  metadata {
    name = "matrix"
    labels = {
      type = "amazonEBS"
    }
  }
  spec {
    storage_class_name = "amazon-ebs"
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      aws_elastic_block_store { 
          volume_id = data.aws_ebs_volume.matrix.id
      }
    }
  }
  
}

resource "kubernetes_persistent_volume_claim" "matrix" {
  metadata {
    name = "matrix-claim"
    namespace = kubernetes_namespace.matrix.metadata.0.name
  }
  spec {
    storage_class_name = "amazon-ebs"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.matrix.metadata.0.name
  }
}