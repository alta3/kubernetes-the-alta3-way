# MODIFIED: providers.tf

provider "aws" {
  region = var.aws_region
}

# Add these new provider blocks:

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    # Wait for the worker nodes to be fully created
    module.eks.eks_managed_node_groups
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    # Wait for the worker nodes to be fully created
    module.eks.eks_managed_node_groups
  ]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}