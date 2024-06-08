output "service_endpoint" {
  description = "The K8S Service endpoint"
  value       = module.simple_webapp.service_endpoint
}


output "cluster_endpoint" {
  description = "endpoint of the eks cluster"
  value       = module.eks_cluster.cluster_endpoint
}
