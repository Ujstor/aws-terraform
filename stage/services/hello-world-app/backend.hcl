bucket         = "tf-state-ujstor"
key            = "stage/services/webserver-cluster/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-state-locks"
encrypt        = true
