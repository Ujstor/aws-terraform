module "alb" {
  source = "../../modules/networking/alb/"

  providers = {
    aws = aws.snadbox
  }

  alb_name   = var.alb_name
  subnet_ids = data.aws_subnets.default.ids
}

