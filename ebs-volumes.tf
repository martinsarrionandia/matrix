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

resource "kubernetes_persistent_volume_v1" "matrix" {
  metadata {
    name = "matrix"
    labels = {
      type = "amazonEBS"
    }
  }
  spec {
    storage_class_name = data.kubernetes_config_map_v1.aws-rancher-config.data["amazon-ebs-class"]
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      csi {
        driver        = "ebs.csi.aws.com"
        volume_handle = data.aws_ebs_volume.matrix.id
        fs_type       = "ext4" # change to xfs if that's what you formatted it as
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "matrix" {
  metadata {
    name      = "matrix-claim"
    namespace = kubernetes_namespace_v1.matrix.metadata[0].name
  }
  spec {
    storage_class_name = data.kubernetes_config_map_v1.aws-rancher-config.data["amazon-ebs-class"]
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = kubernetes_persistent_volume_v1.matrix.metadata[0].name
  }
}

resource "kubernetes_persistent_volume_v1" "matrix-postgresql" {
  metadata {
    name = "matrix-postgresql"
    labels = {
      type = "amazonEBS"
    }
  }
  spec {
    storage_class_name = data.kubernetes_config_map_v1.aws-rancher-config.data["amazon-ebs-class"]
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

resource "kubernetes_persistent_volume_claim_v1" "matrix-postgresql" {
  metadata {
    name      = "matrix-postgresql-claim"
    namespace = kubernetes_namespace_v1.matrix.metadata[0].name
  }
  spec {
    storage_class_name = data.kubernetes_config_map_v1.aws-rancher-config.data["amazon-ebs-class"]
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume_v1.matrix-postgresql.metadata[0].name
  }
}