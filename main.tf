# Specify AWS as the provider and set the region
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "guy-ford-s3-for-terraform"
    key = "tf-state"
    
  }
}

# Provider for managing Helm charts (used for metrics server)
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to kubeconfig file
  }
}

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC

data "aws_availability_zones" "available" {}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}


# Create an EKS cluster using the official AWS EKS module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  # Name and version of the cluster
  cluster_name    = "guy-ford-pacman-eks-cluster"
  cluster_version = "1.27"

  # Network configuration using the default VPC and subnets
  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids

  # Enable IAM roles for service accounts (IRSA)
  enable_irsa = true

  # Configure the node group
  eks_managed_node_groups = {
    default = {
      desired_size = 2         # 3 EC2 instances
      max_size     = 3
      min_size     = 2
      instance_types = ["t3.medium"]  # EC2 type
      capacity_type  =  "ON_DEMAND"   # Use on-demand EC2s
    }
  }

#   # Configure Amazon EKS add-ons
#   cluster_addons = {
#     coredns = {
#       resolve_conflicts = "OVERWRITE"  # Ensure Terraform manages existing add-ons
#     }
#     kube-proxy = {
#       resolve_conflicts = "OVERWRITE"
#     }
#     vpc-cni = {
#       resolve_conflicts = "OVERWRITE"
#     }
#     # ebs-csi = {
#     #   resolve_conflicts = "OVERWRITE"
#     # }
#     eks-pod-identity-agent = {
#       resolve_conflicts = "OVERWRITE"
#     }
#   }
}

# # Helm release to install Metrics Server
# resource "helm_release" "metrics_server" {
#   name       = "guy-ford-metrics-server"
#   namespace  = "kube-system"
#   repository = "https://kubernetes-sigs.github.io/metrics-server/"
#   chart      = "metrics-server"
#   version    = "3.11.0"  # You can update this as needed

#   # Configuration for insecure TLS (required for many AWS setups)
#   set {
#   name  = "args"
#   value = "--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP"
#   }

#   # Wait for cluster before applying Helm chart
#   depends_on = [module.eks]
# }
