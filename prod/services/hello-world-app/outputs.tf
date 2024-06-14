output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.webserver_cluster.alb_dns_name
}
