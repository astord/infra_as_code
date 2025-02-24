data "aws_ami" "ubuntu_22" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "vpc1_private_a_1" {
  ami                    = data.aws_ami.ubuntu_22.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc1.private_subnets_map["private_a"]
  private_ip             = "10.${local.vpc1_cidr}.1.10"
  vpc_security_group_ids = [aws_security_group.allow_all_vpc1.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_node.name

  tags = {
    Name = "irl-vpc1-private-a-1"
  }
}

resource "aws_instance" "vpc2_private_a_1" {
  ami                    = data.aws_ami.ubuntu_22.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc2.private_subnets_map["private_a"]
  private_ip             = "10.${local.vpc2_cidr}.1.10"
  vpc_security_group_ids = [aws_security_group.allow_all_vpc2.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_node.name

  tags = {
    Name = "irl-vpc2-private-a-1"
  }
}
