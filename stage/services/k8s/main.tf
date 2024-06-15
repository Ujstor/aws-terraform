module "simple_webapp" {
  source = "github.com/ujstor/aws-terraform//modules/modules/k8s?ref=v0.1.3"
  # source = "../../../modules/modules/k8s/"

  name           = "portfolio-webapp"
  image          = "ujstor/portfolio-web-go:1.2.0"
  replicas       = 2
  container_port = 5000
  ingress_port   = 80

  # Port from docker image build if it was passed through .env
  environment_variables = {
    PORT = "5000"
  }
}
