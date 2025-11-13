# REPLACED: eks-cluster.tf

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.kubernetes_version # "1.32"
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  enable_irsa                     = true

  # --- THIS IS THE FIX ---
  # We hardcode the versions for the addons that EXIST,
  # and we REMOVE the aws-load-balancer-controller.
  cluster_addons = {
    coredns = {
      addon_version = "v1.11.4-eksbuild.2" # From your command
    }
    kube-proxy = {
      addon_version = "v1.32.6-eksbuild.12" # From your command
    }
    vpc-cni = {
      addon_version = "v1.20.4-eksbuild.2" # From your command
    }
    aws-ebs-csi-driver = {
      addon_version = "v1.52.1-eksbuild.1" # From your command
    }
    # aws-load-balancer-controller = {}  <-- REMOVED
  }
  
  authentication_mode = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    clearml = {
      desired_size = var.desired_nodes
      min_size     = 1
      max_size     = 5
      instance_types = [var.node_instance_type]
      key_name       = null 

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 50
            volume_type = "gp3"
            encrypted   = true
          }
        }
      }

      labels = {
        role = "clearml-worker"
      }

    iam_role_additional_policies = {
        ebs_csi_driver = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }

  node_security_group_id = module.eks_sg.security_group_id

  tags = {
    Environment = "dev"
    Project     = "ClearML"
  }
}