module "hello-world-app" {
  source = "../../../modules/services/hello-world-app/"

  providers = {
    aws = aws.snadbox
  }

  environment   = "snadbox"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  server_text = "Hello, World"

  mysql_config = var.mysql_config

  min_size = 2
  max_size = 2

  enable_autoscaling = false

  vpc_id     = local.vpc_id
  subnet_ids = local.subnet_ids
}
