module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  providers = {
    aws = aws.stage
  }

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "tf-state-ujstor"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  server_text   = "New server text"
  min_size      = 2
  max_size      = 5

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "Terraform"
  }

  enable_autoscaling = false
}

# resource "aws_security_group_rule" "allow_testing_inbound" {
#   type              = "ingress"
#   security_group_id = module.webserver_cluster.alb_security_group_id
#
#   from_port   = 12345
#   to_port     = 12345
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }
