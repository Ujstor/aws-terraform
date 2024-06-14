module "eks_cluster" {
  source       = "../../../modules/modules/eks-cluster/"
  name         = "example-eks-cluster"
  min_size     = 3
  max_size     = 6
  desired_size = 3

  instance_types = ["t3.small"]
}

module "simple_webapp" {
  source = "../../../modules/services/k8s"

  name           = "portfolio-webapp"
  image          = "ujstor/portfolio-web-go:1.2.0"
  replicas       = 4
  container_port = 5000
  ingress_port   = 80

  environment_variables = {
    PORT = "5000"
  }

  depends_on = [module.eks_cluster]
}

