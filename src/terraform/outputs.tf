/*
output "eks_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "region" {
  value = var.region
}
*/

output "api_url" {
  value = aws_api_gateway_stage.api.invoke_url
}