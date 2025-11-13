# storage-class.tf

resource "kubernetes_storage_class_v1" "ebs_gp3" {
  # This depends on the EKS cluster being ready
  depends_on = [module.eks.cluster_id]

  metadata {
    name = "gp3" # The new, modern default
    annotations = {
      # This line makes it the new default StorageClass for the cluster
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "ebs.csi.aws.com" # <-- Points to the correct, running driver
  reclaim_policy      = "Delete"
  volume_binding_mode = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type = "gp3"
    fsType = "ext4"
  }
}

