bucket         = "tf-state-ujstor"
key            = "stage/data-stores/mysql/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-state-locks"
encrypt        = true
