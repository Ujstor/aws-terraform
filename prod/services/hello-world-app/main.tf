module "webserver_cluster" {
  source = "github.com/ujstor/aws-terraform//modules/modules/services/hello-world-app?ref=v0.1.3"
  # source = "../../../modules/modules/services/hello-world-app"

  environment            = "prod"
  image_id               = data.aws_ami.ubuntu.id
  db_remote_state_bucket = "tf-state-ujstor"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"
  min_size      = 2
  max_size      = 11

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "Terraform"
  }

  enable_autoscaling = true
}
