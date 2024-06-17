module "alb" {
  source = "../../modules/networking/alb/"

  providers = {
    aws = aws.stage
  }

  alb_name   = "alb-test"
  subnet_ids = data.aws_subnets.default.ids
}

