module "eks_cluster" {
  source = "github.com/ujstor/aws-terraform//modules/modules/eks-cluster?ref=v0.1.3"
  # source       = "../../../modules/modules/eks-cluster/"
  name         = "example-eks-cluster"
  min_size     = 3
  max_size     = 6
  desired_size = 3

  instance_types = ["t3.small"]
}

module "simple_webapp" {
  source = "github.com/ujstor/aws-terraform//modules/modules/k8s?ref=v0.1.3"
  # source = "../../../modules/modules/k8s"

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

