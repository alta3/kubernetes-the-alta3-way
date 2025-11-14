# heml-clearml.tf 

resource "random_pet" "bucket_suffix" {
  length = 2
}

resource "aws_s3_bucket" "clearml_artifacts" {
  bucket        = "clearml-artifacts-${var.cluster_name}-${random_pet.bucket_suffix.id}"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "clearml_artifacts" {
  bucket = aws_s3_bucket.clearml_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "clearml_artifacts" {
  bucket = aws_s3_bucket.clearml_artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# === Install ClearML (The RIGHT way) ===
/*
resource "helm_release" "clearml" {
  name       = "clearml"
  chart      = "clearml"
  repository = "https://clearml.github.io/clearml-helm-charts"
  namespace  = "clearml"
  
  create_namespace = true
  wait             = true
  timeout          = 1800 # 30 minutes

  values = [
    yamlencode({
      s3 = {
        bucket = aws_s3_bucket.clearml_artifacts.bucket
      }
      mongodb = {
        auth = {
          enabled = false
        }
      }
      redis = {
        auth = {
          enabled = false
        }
      }
      elasticsearch = {
        replicas = 1
      }
      
      webserver = {
        ingress = {
          enabled     = true
          className   = "alb"
          annotations = {
            "alb.ingress.kubernetes.io/scheme"      = "internet-facing"
            "alb.ingress.kubernetes.io/target-type" = "ip"
          }
          hosts = [
            {
              paths = [
                {
                  path = "/"
                  port = 8080
                }
              ]
            }
          ]
        }
      }
      
      apiserver = {
        ingress = {
          enabled = false
        }
      }
      
      fileserver = {
        # --- THIS FIX IS INCLUDED ---
        # Explicitly disable persistence, as we are using S3.
        persistence = {
          enabled = false
        }
        ingress = {
          enabled = false
        }
      }
    })
  ]

  depends_on = [
    module.eks.eks_managed_node_groups,
    helm_release.alb_controller
  ]
}
*/
