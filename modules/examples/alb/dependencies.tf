data "aws_vpc" "default" {
  provider = aws.snadbox
  default  = true
}

data "aws_subnets" "default" {
  provider = aws.snadbox
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
