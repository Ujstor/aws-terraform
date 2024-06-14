module "hello-world-app" {
  source = "../../../modules/modules/services/hello-world-app/"

  providers = {
    aws = aws.stage
  }

  environment   = "stage"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  db_remote_state_bucket = "tf-state-ujstor"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  server_text = "New server text from stage"
  min_size    = 2
  max_size    = 5

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "Terraform"
  }

  enable_autoscaling = false
}
