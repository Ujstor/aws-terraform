module "asg" {
  source = "../../../modules/cluster/asg-rolling-deploy"

  providers = {
    aws = aws.stage
  }

  cluster_name       = var.cluster_name
  image_id           = data.aws_ami.ubuntu.id
  instance_type      = "t2.micro"
  min_size           = 1
  max_size           = 1
  enable_autoscaling = false
  subnet_ids         = data.aws_subnets.default.ids
}

