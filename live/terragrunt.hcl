remote_state {
  backend "s3" 

  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
  
  config = {
    bucket         = "tf-state-ujstor"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
