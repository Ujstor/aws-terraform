output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The domain name of the load balancer"
}

output "alb_http_listener_arn" {
  value       = module.alb.alb_http_listener_arn
  description = "The ARN of the HTTP listener"
}

output "alb_security_group_id" {
  value       = module.alb.alb_security_group_id
  description = "The ALB Security Group ID"
}
