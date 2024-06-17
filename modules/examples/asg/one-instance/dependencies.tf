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

data "aws_ami" "ubuntu" {
  provider    = aws.snadbox
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

