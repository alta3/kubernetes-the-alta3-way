# alb-controller.tf

# 1. We manually define the IAM policy for the ALB Controller
data "aws_iam_policy_document" "alb_controller_policy" {
  statement {
    sid = "AWSLoadBalancerControllerIAMPolicy"
    actions = [
      "iam:CreateServiceLinkedRole", "iam:DeleteServiceLinkedRole",
      "ec2:DescribeAccountAttributes", "ec2:DescribeAddresses", "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways", "ec2:DescribeVpcs", "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeSubnets", "ec2:DescribeSecurityGroups", "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces", "ec2:DescribeTags", "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools", "ec2:CreateNetworkInterface", "ec2:DeleteNetworkInterface",
      "ec2:CreateSecurityGroup", "ec2:DeleteSecurityGroup", "ec2:DescribeNetworkInterfacePermissions",
      "ec2:CreateNetworkInterfacePermission", "ec2:DeleteNetworkInterfacePermission",
      "ec2:AuthorizeSecurityGroupIngress", "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress", "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateTags", "ec2:DeleteTags",
      "elasticloadbalancing:DescribeLoadBalancers", "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners", "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies", "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups", "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth", "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:CreateLoadBalancer", "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyLoadBalancerAttributes", "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups", "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:CreateListener", "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:ModifyListener", "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates", "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteRule", "elasticloadbalancing:ModifyRule",
      "elasticloadbalancing:CreateTargetGroup", "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:ModifyTargetGroup", "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterTargets", "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:SetTags", "elasticloadbalancing:RemoveTags",
      "cognito-idp:DescribeUserPoolClient", "acm:ListCertificates", "acm:DescribeCertificate",
      "acm:GetCertificate", "waf-regional:GetWebACLForResource", "waf-regional:GetWebACL",
      "waf-regional:AssociateWebACL", "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACLForResource", "wafv2:GetWebACL", "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL", "shield:GetSubscriptionState", "shield:DescribeProtection",
      "shield:CreateProtection", "shield:DeleteProtection", "shield:DescribeDRTAccess",
      "shield:GetProtectionGroup", "shield:DescribeProtectionGroup", "shield:ListProtections",
      "shield:ListProtectionGroups"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "alb_controller" {
  name        = "${var.cluster_name}-ALBController-IAMPolicy"
  path        = "/"
  description = "IAM policy for the AWS Load Balancer Controller"
  policy      = data.aws_iam_policy_document.alb_controller_policy.json
}

# 2. We create the IAM Role (IRSA) for the controller to use
module "alb_controller_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.30"

  role_name = "${var.cluster_name}-alb-controller"
  
  # This is the corrected line: { "key" = "value" }
  role_policy_arns = {
    alb_controller_policy = aws_iam_policy.alb_controller.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = var.tags
}
# 3. We install the controller using its official Helm chart
resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.7.1" # A recent, stable version

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = "true" # We are providing our own IRSA role
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller" # Must match the name in the IRSA role
  }

  # This annotation is the magic that links the pod to the IAM role
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.alb_controller_irsa_role.iam_role_arn
  }

  # This waits for the cluster and its node groups to be ready
  depends_on = [
    module.eks.eks_managed_node_groups,
    module.alb_controller_irsa_role
  ]
}
