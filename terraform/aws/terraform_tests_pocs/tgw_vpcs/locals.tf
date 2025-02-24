locals {
  aws_region = "eu-west-1"
  default_tags = {
    Terraform = "false"
  }

  vpc1_cidr   = "100"
  vpc2_cidr   = "200"
  vpc1_1_cidr = "110"
}
