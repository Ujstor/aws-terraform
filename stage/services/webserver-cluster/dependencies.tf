data "aws_vpc" "default" {
  default = true
}

data "terraform_remote_state" "s3" {
  backend = "s3"

  config = {
    bucket = "tf-state-ujstor"
    key    = "stage/data-stores/msql/terraform.tfstate"
    region = "us-east-1"
  }
}
