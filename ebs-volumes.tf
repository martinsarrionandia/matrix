data "aws_ebs_volume" "matrix" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp3"]
  }

  filter {
    name   = "tag:Name"
    values = [var.matrix-ebs-volume-name]
  }
}

data "aws_ebs_volume" "matrix-postgresql" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp3"]
  }

  filter {
    name   = "tag:Name"
    values = [var.postgresql-ebs-volume-name]
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
    storage_class_name = data.terraform_remote_state.rancher-config.outputs.amazon-ebs-class
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
    name      = "matrix-claim"
    namespace = kubernetes_namespace.matrix.metadata.0.name
  }
  spec {
    storage_class_name = data.terraform_remote_state.rancher-config.outputs.amazon-ebs-class
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.matrix.metadata.0.name
  }
}

resource "kubernetes_persistent_volume" "matrix-postgresql" {
  metadata {
    name = "matrix-postgresql"
    labels = {
      type = "amazonEBS"
    }
  }
  spec {
    storage_class_name = data.terraform_remote_state.rancher-config.outputs.amazon-ebs-class
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = data.aws_ebs_volume.matrix-postgresql.id
      }
    }
  }

}

resource "kubernetes_persistent_volume_claim" "matrix-postgresql" {
  metadata {
    name      = "matrix-postgresql-claim"
    namespace = kubernetes_namespace.matrix.metadata.0.name
  }
  spec {
    storage_class_name = data.terraform_remote_state.rancher-config.outputs.amazon-ebs-class
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.matrix-postgresql.metadata.0.name
  }
}