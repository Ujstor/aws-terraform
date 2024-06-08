# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1
locals {
  status = kubernetes_ingress_v1.ingress.status
}

#AWS
output "service_endpoint" {
  description = "The K8S Service endpoint"
  value = try(
    "http://${local.status[0]["load_balancer"][0]["ingress"][0]["hostname"]}",
    "(error parsing hostname from status)"
  )
}
