module "hello-world-app" {
  # source = "github.com/ujstor/aws-terraform//modules/modules/services/hello-world-app?ref=v0.1.3"
  source = "../../../modules/modules/services/hello-world-app/"

  providers = {
    aws = aws.stage
  }

  environment   = var.environment
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  min_size = 2
  max_size = 5

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "Terraform"
  }

  enable_autoscaling = false
}
