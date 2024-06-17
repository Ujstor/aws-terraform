module "alb" {
  source = "../../modules/networking/alb/"

  providers = {
    aws = aws.snadbox
  }

  alb_name   = "alb-sandbox-test"
  subnet_ids = data.aws_subnets.default.ids
}

