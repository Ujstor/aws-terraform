data "aws_ami" "ubuntu" {
  provider = aws.snadbox

  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_vpc" "default" {
  provider = aws.snadbox
  count    = var.vpc_id == null ? 1 : 0
  default  = true
}

data "aws_subnets" "default" {
  provider = aws.snadbox
  count    = var.subnet_ids == null ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

}

locals {
  vpc_id = (
    var.vpc_id == null
    ? data.aws_vpc.default[0].id
    : var.vpc_id
  )

  subnet_ids = (
    var.subnet_ids == null
    ? data.aws_subnets.default[0].ids
    : var.subnet_ids
  )
}
