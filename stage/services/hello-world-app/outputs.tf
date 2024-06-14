output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.hello-world-app.alb_dns_name
}
