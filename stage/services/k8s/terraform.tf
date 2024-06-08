terraform {
  backend "s3" {
    bucket         = "tf-state-ujstor"
    key            = "stage/services/k8s/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"
    }
  }
}

provider "kubernetes" {
  config_paths   = ["~/.kube/config"]
  config_context = "k3d-terraform"
}

