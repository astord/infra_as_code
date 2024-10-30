resource "aws_security_group" "allow_all_vpc1" {
  name        = "allow_ALL"
  description = "Allow ALL traffic"
  vpc_id      = module.vpc1.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "10.${local.vpc1_cidr}.0.0/16",
      "10.${local.vpc2_cidr}.0.0/16"
    ]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = { Name = "Allow_all" }
}

resource "aws_security_group" "allow_all_vpc2" {
  name        = "allow_ALL"
  description = "Allow ALL traffic"
  vpc_id      = module.vpc2.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "10.${local.vpc2_cidr}.0.0/16",
      "10.${local.vpc1_cidr}.0.0/16",
      "10.${local.vpc1_1_cidr}.0.0/16"
    ]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = { Name = "Allow_all" }
}
