data "aws_vpc" "default" {
  provider = aws.stage
  default  = true
}

data "aws_subnets" "default" {
  provider = aws.stage
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
