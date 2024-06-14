module "simple_webapp" {
  source = "../../../modules/modules/k8s/"

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
