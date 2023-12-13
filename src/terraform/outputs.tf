output "eks_cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "region" {
  value = var.region
}

output "ecr_url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "api_url" {
  value = aws_api_gateway_stage.api.invoke_url
}