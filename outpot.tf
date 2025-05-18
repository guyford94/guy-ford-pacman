# Output EKS cluster name
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

# Output cluster endpoint
output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks.cluster_endpoint
}

# Output node IAM role ARN
output "node_group_role_arn" {
  description = "IAM role ARN used by node group"
  value       = module.eks.eks_managed_node_groups["default"].iam_role_arn
}
