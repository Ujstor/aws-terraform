output "service_endpoint" {
  description = "The K8S Service endpoint"
  value       = module.simple_webapp.service_endpoint
}
